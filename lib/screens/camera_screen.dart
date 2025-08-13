import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/classifier_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final picker = ImagePicker();
  bool _loading = false;

  
  final ClassifierService _classifier = ClassifierService();

  
  String? _selectedClass;
  double _confidence = 0.0;
  double? _predictionTime;
  Map<String, double>? _probabilities;

  @override
  void initState() {
    super.initState();
    _checkPermissions();

    
    _classifier.loadModel().then((_) {
      
      debugPrint("Model TFLite berhasil dimuat dari CameraScreen.");
    });
  }

  @override
  void dispose() {
    
    _classifier.close();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final galleryStatus = await Permission.photos.status;

    debugPrint("Camera permission: $cameraStatus");
    debugPrint("Gallery permission: $galleryStatus");
  }

  Future<bool> _requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    if (status.isPermanentlyDenied) {
      _showOpenSettingsDialog("Kamera");
      return false;
    }

    return status.isGranted;
  }

  Future<bool> _requestGalleryPermission() async {
    var status = await Permission.photos.status;

    if (status.isDenied) {
      status = await Permission.photos.request();
    }

    if (status.isPermanentlyDenied) {
      _showOpenSettingsDialog("Galeri");
      return false;
    }

    return status.isGranted;
  }

  void _showOpenSettingsDialog(String permissionType) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Izin $permissionType Diperlukan"),
          content: Text(
              "Aplikasi memerlukan izin $permissionType untuk mengambil gambar. Silakan aktifkan di pengaturan."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text("Buka Pengaturan"),
            ),
          ],
        );
      },
    );
  }

  
  Future<void> _runClassification() async {
    if (_image == null) return;

    setState(() => _loading = true);

    try {
      
      final result = await _classifier.predict(_image!);

      
      setState(() {
        _selectedClass = result['predictedClass'];
        _confidence = result['confidence'];
        _predictionTime = result['predictionTime'];
        _probabilities = result['probabilities'];
      });

      
    } catch (e) {
      debugPrint("Error saat klasifikasi: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error saat klasifikasi: $e")));
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _takePhoto() async {
    try {
      bool hasPermission = await _requestCameraPermission();
      if (!hasPermission) return;

      setState(() => _loading = true);

      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile == null) {
        setState(() => _loading = false);
        return;
      }

      setState(() {
        _image = File(pickedFile.path);
        _selectedClass = null; 
        _confidence = 0.0;
        _predictionTime = null;
        _probabilities = null;
      });

      
      await _runClassification();
    } catch (e) {
      debugPrint("Error mengambil foto: $e");
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error mengambil foto: $e")));
      }
      setState(() => _loading = false);
    }
  }

  Future<void> _pickImage() async {
    try {
      bool hasPermission = await _requestGalleryPermission();
      if (!hasPermission) return;

      setState(() => _loading = true);

      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) {
        setState(() => _loading = false);
        return;
      }

      setState(() {
        _image = File(pickedFile.path);
        _selectedClass = null; 
        _confidence = 0.0;
        _predictionTime = null;
        _probabilities = null;
      });

      
      await _runClassification();
    } catch (e) {
      debugPrint("Error memilih gambar: $e");
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error memilih gambar: $e")));
      }
      setState(() => _loading = false);
    }
  }

  void _showImageSourceDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pilih Sumber Gambar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSourceOption(
                      dialogContext,
                      Icons.camera_alt,
                      'Kamera',
                      _takePhoto,
                    ),
                    _buildSourceOption(
                      dialogContext,
                      Icons.photo_library,
                      'Galeri',
                      _pickImage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSourceOption(
      BuildContext context, IconData icon, String label, Function() onTap) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.brown[100],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 28,
              color: Colors.brown[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.brown[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoffeeTypeItem(String type, String imagePath) {
    final bool isSelected = _selectedClass == type;

    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(color: Colors.brown[700]!, width: 2)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isSelected ? 8 : 10),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          type,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.brown[800] : Colors.brown[700],
          ),
        ),
      ],
    );
  }

  
  Widget _buildProbabilityBar(String label, double probability) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.brown[700],
                ),
              ),
              Text(
                '${(probability * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.brown[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.brown.shade100,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: probability,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.brown.shade400, Colors.brown.shade700],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    final imagePreviewHeight = screenHeight * 0.40;
    final bottomButtonHeight = 65.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.brown[800]),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      "Deteksi Kopi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        height: imagePreviewHeight,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 12, 16, 16),
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt,
                                      color: Colors.brown[700], size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Foto Kopi",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: _loading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.brown[700],
                                          ),
                                        )
                                      : _image == null
                                          ? Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.coffee_outlined,
                                                    size: 40,
                                                    color: Colors.brown[300],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    "Tambahkan foto biji kopi",
                                                    style: TextStyle(
                                                      color: Colors.brown[400],
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Image.file(
                                              _image!,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8, left: 4),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.coffee_outlined,
                                    size: 14,
                                    color: Colors.brown[700],
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Jenis Biji Kopi",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildCoffeeTypeItem(
                                    "Dark", "assets/images/kopi_hitam.png"),
                                _buildCoffeeTypeItem(
                                    "Green", "assets/images/kopi_hijau.png"),
                                _buildCoffeeTypeItem(
                                    "Medium", "assets/images/kopi_medium.png"),
                                _buildCoffeeTypeItem(
                                    "Light", "assets/images/kopi_light.png"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.brown.shade400,
                              Colors.brown.shade800
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.category_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Hasil Klasifikasi",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    _selectedClass ?? "Belum Terdeteksi",
                                    style: TextStyle(
                                      color: Colors.brown[800],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (_selectedClass != null) ...[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        "Akurasi: ${(_confidence * 100).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          color: Colors.brown[600],
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    if (_predictionTime != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          "Waktu: ${_predictionTime!.toStringAsFixed(2)} detik",
                                          style: TextStyle(
                                            color: Colors.brown[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],

                                  
                                  if (_probabilities != null &&
                                      _probabilities!.isNotEmpty) ...[
                                    const SizedBox(height: 16),
                                    const Divider(
                                        height: 1, color: Colors.brown),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Probabilitas Setiap Kelas",
                                      style: TextStyle(
                                        color: Colors.brown[700],
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ..._probabilities!.entries
                                        .map((entry) => _buildProbabilityBar(
                                            entry.key, entry.value))
                                        .toList(),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: bottomButtonHeight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _showImageSourceDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Ambil Foto Kopi",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
