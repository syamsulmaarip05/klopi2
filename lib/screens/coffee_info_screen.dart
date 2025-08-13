import 'package:flutter/material.dart';

class CoffeeInfoScreen extends StatelessWidget {
  const CoffeeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Kopi'),
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
              // Gambar utama di bagian atas
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.brown[100],
                  child: Image.asset(
                    'assets/images/info_coffee.png', // Gambar header utama
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.brown[200],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.coffee,
                                size: 60,
                                color: Colors.brown[600],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Informasi Kopi',
                                style: TextStyle(
                                  color: Colors.brown[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              // Konten dalam satu container
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bagian Kualitas Biji Kopi
                    Text(
                      'Kualitas Biji Kopi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Kualitas biji kopi juga bisa diukur dari warna yang dimiliki. Biji kopi mentah yang memiliki titik-titik hitam atau coklat tua mungkin sudah mengalami kerusakan dan dapat menghasilkan kopi sangrai yang tidak berkualitas. Titik-titik tersebut bisa jadi adalah indikasi adanya jamur, yang dapat mengandung racun seperti aflatoksin. Warna biji kopi umumnya bervariasi dari hijau muda hingga hitam, yang dipengaruhi oleh tingkat kematangan saat panen, cara pengolahan, serta metode penyimpanan setelah dipanen. Biji kopi yang matang dengan baik biasanya berwarna merah atau hitam, sedangkan biji kopi yang tidak sepenuhnya matang akan berwarna hijau muda. Biji kopi hijau muda cenderung memiliki rasa yang kurang enak dibandingkan dengan biji kopi yang telah matang dengan sempurna.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.brown[700],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Bagian Green Bean
                    Text(
                      'Green Bean',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Kopi green bean merujuk pada biji kopi yang belum mengalami proses pemanggangan atau sangrai. Biji ini masih memiliki warna hijau dan terasa keras, berbeda dengan biji kopi yang telah disangrai yang berwarna cokelat dan mengeluarkan aroma yang kuat. Green bean merupakan bagian awal dari proses pengolahan biji kopi sebelum siap untuk diseduh.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.brown[700],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Bagian Indikator Klasifikasi
                    Text(
                      'Indikator Klasifikasi Green Bean',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Klasifikasi dan penentuan grade green bean ditentukan oleh beberapa faktor, baik secara keseluruhan maupun sebagian, tergantung pada standar yang diterapkan di setiap negara.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.brown[700],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Faktor-faktor dalam list
                    _buildFactorItem('Altitude', 'Ketinggian lokasi tempat penanaman kopi berpengaruh besar terhadap kualitas biji kopi. Tinggi rendahnya tempat menentukan suhu, kelembapan, serta tekanan udara yang dapat mempengaruhi pertumbuhan dan perkembangan buah kopi.'),
                    
                    _buildFactorItem('Region', 'Setiap daerah penghasil kopi memiliki ciri khas tersendiri terkait tanah, iklim, dan jenis kopi yang ada, sehingga lokasi menjadi faktor penting dalam menentukan profil rasa dari sebuah kopi.'),
                    
                    _buildFactorItem('Varietas', 'Ada banyak jenis kopi, seperti Arabika, Robusta, dan berbagai jenis hibrida yang berbeda dalam hal cita rasa, kekuatan, serta keunikan yang memengaruhi kualitas akhir kopi.'),
                    
                    _buildFactorItem('Pengolahan Biji Kopi', 'Metode pengolahan kopi, seperti pengolahan basah, kering, dan semi-basah, berpengaruh pada profil rasa dan karakteristik dari biji kopi.'),
                    
                    _buildFactorItem('Ukuran Biji Kopi', 'Dimensi fisik biji kopi dapat memberikan informasi mengenai kualitas dan potensi rasa yang muncul saat biji tersebut dipanggang.'),
                    
                    _buildFactorItem('Bentuk Biji dan Warna', 'Bentuk serta warna biji kopi juga dapat berfungsi sebagai indikator kualitas; beberapa di antaranya bisa mencerminkan tingkat kematangan dan pengolahan biji kopi.'),
                    
                    _buildFactorItem('Jumlah Biji Kopi Yang Cacat dan Cacat Biji Kopi Yang Ditoleransi', 'Faktor ini dapat mencerminkan proses panen, pemrosesan, dan pemilahan biji kopi.'),
                    
                    _buildFactorItem('Densitas Biji Kopi', 'Densitas biji kopi mengacu pada ukuran berat jenis biji tersebut. Biji yang lebih padat mungkin memiliki karakteristik rasa yang berbeda.'),
                    
                    _buildFactorItem('Kualitas Cupping', 'Nilai cupping berkaitan dengan keseluruhan profil rasa kopi, termasuk tingkat keasaman, kepedasan, keharuman, serta pengalaman umum saat meneguk kopi tersebut.'),
                    
                    const SizedBox(height: 24),
                    
                    // Bagian Sistem Penilaian
                    Text(
                      'Sistem Penilaian Grade',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Dari berbagai pertimbangan ini, tidak semua faktor digunakan, bergantung pada proses yang ada di tiap negara. Beberapa sistem penilaian grade dan klasifikasi green bean juga berkembang untuk memenuhi standar kualitas dari pembeli green bean. Jika terdapat kecacatan pada green bean yang dapat meningkatkan risiko kontaminasi, sistem penilaian akan menyesuaikan kecacatan tersebut.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.brown[700],
                      ),
                      textAlign: TextAlign.justify,
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

  Widget _buildFactorItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.brown[600],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.brown[600],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}