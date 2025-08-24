import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.brown[400]!, Colors.brown[800]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      
                      child: Image.asset(
                        'assets/images/icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'DetectCoffee',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    _buildSectionTitle('About the Application'),
                    const SizedBox(height: 12),
                    _buildSectionContent(
                      'DetectCoffee is an AI-based mobile application that can identify and classify types of coffee beans using deep learning technology. This application uses a Convolutional Neural Network (CNN) model based on EfficientNet that has been converted to TensorFlow Lite for fast and efficient inference on mobile devices.',
                    ),

                    const SizedBox(height: 24),

                    
                    _buildSectionTitle('AI Technology Used'),
                    const SizedBox(height: 12),
                    _buildSectionContent(
                      'The model uses the EfficientNet architecture that has been trained with a special coffee bean dataset. The original model in H5 format was then converted to TensorFlow Lite with quantization optimization to reduce the model size by up to 75% without significantly compromising accuracy.',
                    ),

                    const SizedBox(height: 24),

                    
                    _buildSectionTitle('Main Features'),
                    const SizedBox(height: 12),
                    _buildFeatureItem(Icons.camera_alt, 'Real-time Detection',
                        'Take a photo of the coffee bean with the camera or select from the gallery'),
                    _buildFeatureItem(Icons.analytics, 'AI Classification',
                        'Identify coffee bean types: Dark, Green, Light, and Medium'),
                    _buildFeatureItem(Icons.speed, 'Fast Results',
                        'Predictions in seconds'),
                    _buildFeatureItem(Icons.info, 'Comprehensive Information',
                        'Complete guide to coffee bean quality and classification'),

                    const SizedBox(height: 24),

                    
                    _buildSectionTitle('Software Specifications'),
                    const SizedBox(height: 12),
                    _buildSpecItem('Platform', 'Flutter (Cross-platform)'),
                    _buildSpecItem('Machine Learning', 'TensorFlow Lite'),
                    _buildSpecItem('Base Model', 'EfficientNet (Pre-trained)'),
                    _buildSpecItem('Model Format', 'TFLite with Post-training Quantization'),
                    _buildSpecItem('Input Resolution', '224 x 224 pixels'),
                    _buildSpecItem('Programming Language', 'Dart'),
                    _buildSpecItem('Image Processing', 'Flutter Image Picker'),
                    _buildSpecItem('Preprocessing', 'EfficientNet Preprocessing Function'),
                    _buildSpecItem('Permissions', 'Camera & Gallery Access'),

                    const SizedBox(height: 24),

                    
                    _buildSectionTitle('Hardware Requirements'),
                    const SizedBox(height: 12),
                    _buildSpecItem(
                        'OS Android', 'Android 5.0 (API Level 21) upwards'),
                    _buildSpecItem('OS iOS', 'iOS 9.0 upwards'),
                    _buildSpecItem('RAM', 'Minimum 2 GB (Recommended 4 GB)'),
                    _buildSpecItem('Storage', 'Minimum 100 MB free space'),
                    _buildSpecItem('Camera', 'Rear camera'),
                    _buildSpecItem('Processor', 'ARM64 or x86_64'),

                    const SizedBox(height: 24),

                    
                    _buildSectionTitle('How to Use the Application'),
                    const SizedBox(height: 12),
                    _buildStepItem(1, 'Open the DetectCoffee app'),
                    _buildStepItem(2, 'Select "Coffee Detection" menu'),
                    _buildStepItem(3, 'Press "Take Coffee Photo" button'),
                    _buildStepItem(
                        4, 'Select image source (Camera or Gallery)'),
                    _buildStepItem(
                        5, 'Take a photo of the coffee bean with good lighting'),
                    _buildStepItem(6, 'Wait for the prediction results to appear'),
                    _buildStepItem(7,
                        'View the classification results of the detected coffee bean'),

                    const SizedBox(height: 24),

                    
                    _buildSectionTitle('Tips for Optimal Results'),
                    const SizedBox(height: 12),
                    _buildTipItem('Use adequate natural lighting'),
                    _buildTipItem('Position the coffee bean in the center of the frame'),
                    _buildTipItem('Ensure the coffee bean is dry'),
                    _buildTipItem('Use a contrasting background (white/neutral)'),
                    _buildTipItem('Avoid shadows covering the object'),
                    _buildTipItem('Take the photo from a distance of 15-30 cm'),

                    const SizedBox(height: 24),

                    _buildSectionTitle('Developer Information'),
                    const SizedBox(height: 12),
                    _buildSectionContent(
                      'This application is developed using cutting-edge technology in the field of computer vision and machine learning to assist coffee lovers, farmers, traders, and industry players in identifying coffee bean types with high accuracy. The AI model has been trained using a comprehensive dataset and optimized for the best performance on mobile devices.',
                    ),

                    const SizedBox(height: 16),

                    
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.brown[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '© 2025 DetectCoffee | All Rights Reserved',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.brown[600],
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.brown[800],
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 14,
        height: 1.6,
        color: Colors.brown[700],
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.brown[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.brown[700],
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.brown[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: Colors.brown[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(int number, String step) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.brown[600],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              step,
              style: TextStyle(
                fontSize: 13,
                color: Colors.brown[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: Colors.brown[600],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 13,
                color: Colors.brown[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
