import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/widgets/jadwal_konsul/jadwal_konsul_body.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:flutter/material.dart';

class JadwalKonsultasiScreen extends StatefulWidget {
  final DoctorModel doctor;

  const JadwalKonsultasiScreen({super.key, required this.doctor});

  @override
  State<JadwalKonsultasiScreen> createState() => _JadwalKonsultasiScreenState();
}

class _JadwalKonsultasiScreenState extends State<JadwalKonsultasiScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Janji Temu',
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
      child: JadwalKonsulBody(doctor: widget.doctor),
    );
  }
}
