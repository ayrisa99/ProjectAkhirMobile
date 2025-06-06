import 'package:finalproject/widgets/checkout/body.dart';
import 'package:finalproject/widgets/checkout/checkout_navbar.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/cubit/app_state_cubit.dart';
import 'package:sensors_plus/sensors_plus.dart'; // Import sensors_plus

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _accelerometerData =
      'Data belum tersedia'; // Menyimpan data accelerometer

  @override
  void initState() {
    super.initState();
    _startListening(); // Mulai mendengarkan data accelerometer
  }

  // Fungsi untuk mendengarkan data dari accelerometer
  void _startListening() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerData =
            'X: ${event.x}\nY: ${event.y}\nZ: ${event.z}'; // Perbarui data UI
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AppStateCubit>();

    void onCheckoutPressed() {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pesanan berhasil dibuat!')));
      Navigator.pop(context);
    }

    return CustomScaffold2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Konfirmasi Pesanan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
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
      bottomNavigationBar: CheckoutNavBar(onCheckout: onCheckoutPressed),
      child: Column(
        children: [
          // Menampilkan data accelerometer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Data Accelerometer:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(_accelerometerData, style: TextStyle(fontSize: 18)),
                ElevatedButton(
                  onPressed: () {
                    // Gunakan sensor untuk aksi lain
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sensor digunakan di Checkout')),
                    );
                  },
                  child: Text('Gunakan Sensor di Checkout'),
                ),
              ],
            ),
          ),
          // Checkout body (fitur checkout yang sudah ada)
          const CheckoutBody(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
