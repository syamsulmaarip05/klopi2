import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class ClassifierService {
  Interpreter? _interpreter;
  List<String> _labels = ["Dark", "Green", "Light", "Medium"]; // Default labels
  List<int> _inputShape = [1, 224, 224, 3]; // Default input shape
  dynamic
      _inputType; // Menyimpan tipe sebagai dynamic untuk menghindari cast error

  bool _modelLoaded = false;

  // Singleton pattern
  static final ClassifierService _instance = ClassifierService._internal();

  factory ClassifierService() {
    return _instance;
  }

  ClassifierService._internal();

  // Memeriksa apakah model sudah dimuat
  bool get isModelLoaded => _modelLoaded;

  // Sama seperti `__init__` di Python, memuat model dan label
  Future<void> loadModel() async {
    try {
      // Coba muat labels.txt jika ada
      try {
        final labelsData = await rootBundle.loadString('assets/model/labels.txt');
        _labels = labelsData.split('\n').where((s) => s.isNotEmpty).toList();
        debugPrint('✅ Labels loaded: $_labels');
      } catch (e) {
        debugPrint(
            '⚠️ Could not load labels.txt, using default labels: $_labels');
        // Tetap gunakan label default jika file tidak ditemukan
      }

      // Memuat model TFLite dari lokasi yang sudah diketahui
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
        // Dapatkan detail input tensor
        _inputShape = _interpreter!.getInputTensor(0).shape;
        // Simpan tipe sebagai dynamic untuk menghindari cast error
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

  // Fungsi utama untuk melakukan prediksi
  Future<Map<String, dynamic>> predict(File imageFile) async {
    final stopwatch = Stopwatch()..start();

    // Pastikan model sudah dimuat
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
      // 1. Memuat dan memproses gambar (Pre-processing)
      final inputTensor = _preprocessImage(imageFile);

      // Siapkan output tensor
      final outputTensor =
          List.filled(1 * _labels.length, 0.0).reshape([1, _labels.length]);

      // 2. Jalankan inference
      _interpreter!.run(inputTensor, outputTensor);

      stopwatch.stop();
      final predictionTime = stopwatch.elapsedMilliseconds;

      // 3. Proses hasil output (Post-processing)
      final results = outputTensor[0] as List<double>;

      // Cari index dengan probabilitas tertinggi
      final double maxValue =
          results.reduce((curr, next) => curr > next ? curr : next);
      final int bestIndex = results.indexWhere((val) => val == maxValue);

      // Pastikan index valid
      final String predictedClass = bestIndex >= 0 && bestIndex < _labels.length
          ? _labels[bestIndex]
          : "Unknown";
      final double confidence = maxValue;

      // Buat map probabilitas untuk semua kelas
      final Map<String, double> probabilities =
          Map.fromIterables(_labels, results);

      debugPrint('📊 PREDICTION RESULTS:');
      debugPrint('Predicted Class: $predictedClass');
      debugPrint('Confidence: ${confidence.toStringAsFixed(4)}');
      debugPrint('Prediction Time: $predictionTime ms');
      debugPrint('All Probabilities: $probabilities');

      return {
        'predictedClass': predictedClass,
        'confidence': confidence,
        'predictionTime': predictionTime / 1000.0, // dalam detik
        'probabilities': probabilities,
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

  // Fungsi internal untuk pre-processing gambar
  Uint8List _preprocessImage(File imageFile) {
    // Baca gambar dari file
    final imageBytes = imageFile.readAsBytesSync();
    final originalImage = img.decodeImage(imageBytes)!;

    // Ambil dimensi input dari _inputShape (jika tersedia, gunakan default jika tidak)
    final int width = _inputShape.length > 1 ? _inputShape[1] : 224;
    final int height = _inputShape.length > 2 ? _inputShape[2] : 224;
    final int channels = _inputShape.length > 3 ? _inputShape[3] : 3;

    // Resize gambar ke ukuran input model
    final resizedImage =
        img.copyResize(originalImage, width: width, height: height);

    // Konversi gambar menjadi Float32List dan normalisasi
    final imageBytesAsFloat = Float32List(width * height * channels);
    int bufferIndex = 0;
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        final pixel = resizedImage.getPixel(x, y);

        // Normalisasi piksel
        // Opsi 1: Tetap di rentang [0, 255]
        imageBytesAsFloat[bufferIndex++] = pixel.r.toDouble();
        imageBytesAsFloat[bufferIndex++] = pixel.g.toDouble();
        imageBytesAsFloat[bufferIndex++] = pixel.b.toDouble();

        // Opsi 2: Normalisasi ke [0, 1]
        // imageBytesAsFloat[bufferIndex++] = pixel.r / 255.0;
        // imageBytesAsFloat[bufferIndex++] = pixel.g / 255.0;
        // imageBytesAsFloat[bufferIndex++] = pixel.b / 255.0;

        // Opsi 3: Normalisasi ke [-1, 1]
        // imageBytesAsFloat[bufferIndex++] = (pixel.r - 127.5) / 127.5;
        // imageBytesAsFloat[bufferIndex++] = (pixel.g - 127.5) / 127.5;
        // imageBytesAsFloat[bufferIndex++] = (pixel.b - 127.5) / 127.5;
      }
    }

    // Kembalikan sebagai Uint8List view dari buffer Float32
    return imageBytesAsFloat.buffer.asUint8List();
  }

  void close() {
    _interpreter?.close();
    _modelLoaded = false;
  }
}
