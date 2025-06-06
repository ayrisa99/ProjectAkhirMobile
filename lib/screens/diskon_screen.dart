import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart'; // Untuk mendapatkan data dari accelerometer
import 'dart:math'; // Untuk memilih voucher secara acak
import 'package:shared_preferences/shared_preferences.dart'; // Untuk menyimpan diskon

class DiskonScreen extends StatefulWidget {
  const DiskonScreen({super.key});

  @override
  _DiskonScreenState createState() => _DiskonScreenState();
}

class _DiskonScreenState extends State<DiskonScreen> {
  String _discountMessage = "Tidak ada diskon"; // Pesan awal tanpa diskon
  double _acceleration =
      0.0; // Variabel untuk menyimpan data dari accelerometer
  double _lastAcceleration =
      0.0; // Menyimpan percepatan terakhir untuk deteksi shake
  int _shakeThreshold = 15; // Ambang batas untuk deteksi shake
  DateTime _lastShakeTime = DateTime.now(); // Waktu terakhir shake terjadi
  Duration _shakeInterval = Duration(seconds: 1); // Interval waktu antara shake

  // Daftar voucher yang tersedia
  final List<String> _vouchers = [
    "Selamat Kamu Mendapatkan Diskon 10 %",
    "Diskon 20% hanya untukmu!",
    "Selamat kamu mendapatkan diskon 30%",
    "Kamu beruntung banget dapet diskon 50%",
  ];

  List<String> _history = []; // Riwayat diskon yang sudah diperoleh
  List<String> _usedDiscounts = []; // Diskon yang sudah digunakan

  @override
  void initState() {
    super.initState();
    _loadDiscountHistory(); // Memuat riwayat diskon
    _startAccelerometerListener(); // Mulai mendengarkan data accelerometer
  }

  // Fungsi untuk memuat riwayat diskon dan diskon yang sudah digunakan
  Future<void> _loadDiscountHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('discountHistory') ?? [];
    List<String> usedDiscounts = prefs.getStringList('usedDiscounts') ?? [];
    setState(() {
      _history = history;
      _usedDiscounts = usedDiscounts;
    });
  }

  // Fungsi untuk mendengarkan data dari accelerometer
  void _startAccelerometerListener() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      double totalAcceleration =
          event.x + event.y + event.z; // Total percepatan

      // Deteksi apakah perubahan percepatan lebih besar dari ambang batas
      if ((totalAcceleration - _lastAcceleration).abs() > _shakeThreshold) {
        // Cek interval waktu antara shake sebelumnya dan yang sekarang
        if (DateTime.now().difference(_lastShakeTime) > _shakeInterval) {
          setState(() {
            // Memilih voucher secara acak dari daftar
            int randomIndex = Random().nextInt(_vouchers.length);
            _discountMessage = _vouchers[randomIndex]; // Memberikan diskon acak
          });
          _lastShakeTime = DateTime.now(); // Simpan waktu terakhir shake
          // Menyimpan diskon ke SharedPreferences
          _saveDiscountToSharedPreferences(_discountMessage);
          // Menyimpan diskon ke riwayat
          _addToDiscountHistory(_discountMessage);
          // Menampilkan pop-up dengan diskon yang diperoleh
          _showDiscountDialog();
        }
      }

      // Menyimpan percepatan untuk perbandingan berikutnya
      _lastAcceleration = totalAcceleration;
    });
  }

  // Fungsi untuk menyimpan diskon ke SharedPreferences
  Future<void> _saveDiscountToSharedPreferences(String discount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'discount',
      discount,
    ); // Menyimpan diskon ke SharedPreferences
  }

  // Fungsi untuk menambahkan diskon ke riwayat
  Future<void> _addToDiscountHistory(String discount) async {
    final prefs = await SharedPreferences.getInstance();
    _history.add(discount);
    await prefs.setStringList(
      'discountHistory',
      _history,
    ); // Menyimpan riwayat diskon
  }

  // Fungsi untuk menandai diskon sebagai sudah dipakai
  Future<void> _markDiscountAsUsed(String discount) async {
    final prefs = await SharedPreferences.getInstance();
    _usedDiscounts.add(discount);
    await prefs.setStringList(
      'usedDiscounts',
      _usedDiscounts,
    ); // Menyimpan diskon yang digunakan
  }

  // Fungsi untuk menampilkan pop-up dialog diskon
  void _showDiscountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selamat!'),
          content: Text(_discountMessage),
          actions: [
            TextButton(
              onPressed: () {
                _markDiscountAsUsed(
                  _discountMessage,
                ); // Menandai diskon sebagai digunakan
                Navigator.pop(context); // Menutup pop-up
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Dapatkan Diskon'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Image.asset('assets/logo/back.png', width: 35, height: 35),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Goyangkan ponsel untuk mendapatkan diskon!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              _discountMessage,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 40),
            // Riwayat Diskon
            const Text(
              'Riwayat Diskon:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  String discount = _history[index];
                  bool isUsed = _usedDiscounts.contains(discount);
                  return ListTile(
                    title: Text(discount),
                    subtitle:
                        isUsed
                            ? const Text(
                              "Sudah Dipakai",
                              style: TextStyle(color: Colors.red),
                            )
                            : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
