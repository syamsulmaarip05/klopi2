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
              // Header dengan logo aplikasi
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
                      'Versi 1.0.0',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // Konten utama
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Deskripsi Aplikasi
                    _buildSectionTitle('Tentang Aplikasi'),
                    const SizedBox(height: 12),
                    _buildSectionContent(
                      'DetectCoffee adalah aplikasi mobile berbasis AI yang dapat mengidentifikasi dan mengklasifikasikan jenis biji kopi menggunakan teknologi deep learning. Aplikasi ini menggunakan model Convolutional Neural Network (CNN) berbasis EfficientNet yang telah dikonversi ke TensorFlow Lite untuk inference yang cepat dan efisien pada perangkat mobile.',
                    ),

                    const SizedBox(height: 24),

                    // Teknologi AI
                    _buildSectionTitle('Teknologi AI yang Digunakan'),
                    const SizedBox(height: 12),
                    _buildSectionContent(
                      'Model menggunakan arsitektur EfficientNet yang telah dilatih dengan dataset khusus biji kopi. Model asli dalam format H5 kemudian dikonversi ke TensorFlow Lite dengan optimasi quantization untuk mengurangi ukuran model hingga 75% tanpa mengurangi akurasi secara signifikan.',
                    ),

                    const SizedBox(height: 24),

                    // Fitur Utama
                    _buildSectionTitle('Fitur Utama'),
                    const SizedBox(height: 12),
                    _buildFeatureItem(Icons.camera_alt, 'Deteksi Real-time',
                        'Ambil foto biji kopi dengan kamera atau pilih dari galeri'),
                    _buildFeatureItem(Icons.analytics, 'Klasifikasi AI',
                        'Identifikasi jenis biji kopi: Dark, Green, Light, dan Medium'),
                    _buildFeatureItem(Icons.speed, 'Hasil Cepat',
                        'Prediksi hasil dalam hitungan detik'),
                    _buildFeatureItem(Icons.info, 'Informasi Lengkap',
                        'Panduan lengkap tentang kualitas dan klasifikasi biji kopi'),

                    const SizedBox(height: 24),

                    // Spesifikasi Software
                    _buildSectionTitle('Spesifikasi Software'),
                    const SizedBox(height: 12),
                    _buildSpecItem('Platform', 'Flutter (Cross-platform)'),
                    _buildSpecItem('Machine Learning', 'TensorFlow Lite'),
                    _buildSpecItem('Base Model', 'EfficientNet (Pre-trained)'),
                    _buildSpecItem('Model Format',
                        'TFLite dengan Post-training Quantization'),
                    _buildSpecItem('Input Resolution', '224 x 224 pixels'),
                    _buildSpecItem('Bahasa Pemrograman', 'Dart'),
                    _buildSpecItem('Image Processing', 'Flutter Image Picker'),
                    _buildSpecItem(
                        'Preprocessing', 'EfficientNet Preprocessing Function'),
                    _buildSpecItem('Permissions', 'Camera & Gallery Access'),

                    const SizedBox(height: 24),

                    // Spesifikasi Hardware
                    _buildSectionTitle('Kebutuhan Hardware'),
                    const SizedBox(height: 12),
                    _buildSpecItem(
                        'OS Android', 'Android 5.0 (API Level 21) ke atas'),
                    _buildSpecItem('OS iOS', 'iOS 9.0 ke atas'),
                    _buildSpecItem('RAM', 'Minimal 2 GB (Rekomendasi 4 GB)'),
                    _buildSpecItem('Storage', 'Minimal 100 MB ruang kosong'),
                    _buildSpecItem(
                        'Kamera', 'Kamera belakang dengan autofocus'),
                    _buildSpecItem('Processor', 'ARM64 atau x86_64'),

                    const SizedBox(height: 24),

                    // Cara Penggunaan
                    _buildSectionTitle('Cara Penggunaan'),
                    const SizedBox(height: 12),
                    _buildStepItem(1, 'Buka aplikasi DetectCoffee'),
                    _buildStepItem(2, 'Pilih menu "Deteksi Kopi"'),
                    _buildStepItem(3, 'Tekan tombol "Ambil Foto Kopi"'),
                    _buildStepItem(
                        4, 'Pilih sumber gambar (Kamera atau Galeri)'),
                    _buildStepItem(
                        5, 'Ambil foto biji kopi dengan pencahayaan yang baik'),
                    _buildStepItem(6, 'Tunggu hasil prediksi muncul'),
                    _buildStepItem(7,
                        'Lihat hasil klasifikasi jenis biji kopi yang terdeteksi'),

                    const SizedBox(height: 24),

                    // Tips Penggunaan
                    _buildSectionTitle('Tips untuk Hasil Optimal'),
                    const SizedBox(height: 12),
                    _buildTipItem('Gunakan pencahayaan alami yang cukup'),
                    _buildTipItem('Posisikan biji kopi di tengah frame'),
                    _buildTipItem('Pastikan biji kopi dalam kondisi kering'),
                    _buildTipItem('Gunakan background kontras (putih/netral)'),
                    _buildTipItem('Hindari bayangan yang menutupi objek'),
                    _buildTipItem('Ambil foto dari jarak 15-30 cm'),

                    const SizedBox(height: 24),

                    // Informasi Developer
                    _buildSectionTitle('Informasi Pengembang'),
                    const SizedBox(height: 12),
                    _buildSectionContent(
                      'Aplikasi ini dikembangkan menggunakan teknologi terdepan dalam bidang computer vision dan machine learning untuk membantu para pecinta kopi, petani, pedagang, dan pelaku industri kopi dalam mengidentifikasi jenis biji kopi dengan akurasi tinggi. Model AI telah dilatih menggunakan dataset komprehensif dan dioptimasi untuk performa terbaik pada perangkat mobile.',
                    ),

                    const SizedBox(height: 16),

                    // Copyright
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
