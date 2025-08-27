import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierService {
  Interpreter? _interpreter;
  List<String> _labels = ["Dark", "Green", "Light", "Medium"]; 
  List<int> _inputShape = [1, 224, 224, 3]; 
  dynamic
      _inputType; 

  bool _modelLoaded = false;

  
  static final ClassifierService _instance = ClassifierService._internal();

  factory ClassifierService() {
    return _instance;
  }

  ClassifierService._internal();

  
  bool get isModelLoaded => _modelLoaded;

  
  Future<void> loadModel() async {
    try {
      
      try {
        final labelsData = await rootBundle.loadString('assets/model/labels.txt');
        _labels = labelsData.split('\n').where((s) => s.isNotEmpty).toList();
        debugPrint('✅ Labels loaded: $_labels');
      } catch (e) {
        debugPrint(
            '⚠️ Could not load labels.txt, using default labels: $_labels');
        
      }

      
      try {
        _interpreter = await Interpreter.fromAsset(
            'assets/model/improved_coffee_classifier.tflite');
        debugPrint(
            '✅ Model loaded from assets/model/improved_coffee_classifier.tflite');
      } catch (e) {
        debugPrint('❌ Error loading model from exact path: $e');
        throw Exception(
            'Failed to load model. Please check the file path and make sure the model exists.');
      }

      if (_interpreter != null) {
        
        _inputShape = _interpreter!.getInputTensor(0).shape;
        
        _inputType = _interpreter!.getInputTensor(0).type;
        _modelLoaded = true;

        debugPrint('✅ Model loaded successfully!');
        debugPrint('Input Shape: $_inputShape');
        debugPrint('Input Type: $_inputType');
      } else {
        throw Exception('Interpreter is null after initialization');
      }
    } catch (e) {
      debugPrint('❌ Error loading model: $e');
      rethrow;
    }
  }

  
  Future<Map<String, dynamic>> predict(File imageFile) async {
    final stopwatch = Stopwatch()..start();

    
    if (!_modelLoaded || _interpreter == null) {
      try {
        await loadModel();
      } catch (e) {
        return {
          'predictedClass': 'Error',
          'confidence': 0.0,
          'predictionTime': 0.0,
          'probabilities':
              Map.fromIterables(_labels, List.filled(_labels.length, 0.0)),
          'error': 'Model failed to load: $e'
        };
      }
    }

    try {
      
      final inputTensor = _preprocessImage(imageFile);

      
      final outputTensor =
          List.filled(1 * _labels.length, 0.0).reshape([1, _labels.length]);

      
      _interpreter!.run(inputTensor, outputTensor);

      stopwatch.stop();
      final predictionTime = stopwatch.elapsedMilliseconds;

      
      final results = outputTensor[0] as List<double>;

      
      final sortedEntries = List.generate(
        _labels.length,
        (i) => MapEntry(_labels[i], results[i]),
      )..sort((a, b) => b.value.compareTo(a.value));


      final Map<String, double> probabilitiesSorted =
          Map<String, double>.fromEntries(sortedEntries);


      final double maxValue = sortedEntries.first.value;
      final String predictedClass = sortedEntries.first.key;
      final double confidence = maxValue;


      final Map<String, double> probabilities =
          Map<String, double>.fromIterables(_labels, results);


      debugPrint('📊 PREDICTION RESULTS:');
      debugPrint('Predicted Class: $predictedClass');
      debugPrint('Confidence: ${confidence.toStringAsFixed(4)}');
      debugPrint('Prediction Time: $predictionTime ms');
      debugPrint('All Probabilities (sorted): $probabilitiesSorted');

      return {
        'predictedClass': predictedClass,
        'confidence': confidence,
        'predictionTime': predictionTime / 1000.0, 
        'probabilities': probabilities,
        'probabilitiesSorted' : probabilitiesSorted,
      };
    } catch (e) {
      debugPrint('❌ Error during prediction: $e');
      return {
        'predictedClass': 'Error',
        'confidence': 0.0,
        'predictionTime': 0.0,
        'probabilities':
            Map.fromIterables(_labels, List.filled(_labels.length, 0.0)),
        'error': 'Prediction failed: $e'
      };
    }
  }

  
  Uint8List _preprocessImage(File imageFile) {
    
    final imageBytes = imageFile.readAsBytesSync();
    final originalImage = img.decodeImage(imageBytes)!;

    
    final int width = _inputShape.length > 1 ? _inputShape[1] : 224;
    final int height = _inputShape.length > 2 ? _inputShape[2] : 224;
    final int channels = _inputShape.length > 3 ? _inputShape[3] : 3;

    
    final resizedImage =
        img.copyResize(originalImage, width: width, height: height);

    
    final imageBytesAsFloat = Float32List(width * height * channels);
    int bufferIndex = 0;
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        final pixel = resizedImage.getPixel(x, y);

        
        
        imageBytesAsFloat[bufferIndex++] = pixel.r.toDouble();
        imageBytesAsFloat[bufferIndex++] = pixel.g.toDouble();
        imageBytesAsFloat[bufferIndex++] = pixel.b.toDouble();

        
        
        
        

        
        
        
        
      }
    }

    
    return imageBytesAsFloat.buffer.asUint8List();
  }

  void close() {
    _interpreter?.close();
    _modelLoaded = false;
  }
}
