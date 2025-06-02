import 'package:finalproject/widgets/pendaftaran/form_pendaftaran.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';

class PendaftaranScreen extends StatefulWidget {
  const PendaftaranScreen({super.key});

  @override
  State<PendaftaranScreen> createState() => _PendaftaranScreenState();
}

class _PendaftaranScreenState extends State<PendaftaranScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Pendaftaran',
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
      child: PendaftaranBody(
        allDoctors: nearbyDoctors,     // langsung dari model doctor_models.dart
        allHospitals: rumahSakitList,  // langsung dari model rumah_sakit_models.dart
      ),
    );
  }
}
