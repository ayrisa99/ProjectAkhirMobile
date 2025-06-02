import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/widgets/dokter_sekitarmu/list_dokter_sekitarmu.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:flutter/material.dart';

class DokterSekitarmuScreen extends StatefulWidget {
  final DoctorModel doctor;

  const DokterSekitarmuScreen({super.key, required this.doctor});

  @override
  State<DokterSekitarmuScreen> createState() => _DokterSekitarmuScreenState();
}

class _DokterSekitarmuScreenState extends State<DokterSekitarmuScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Dokter Sekitarmu',
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
      child: ListDokterSekitarmu(
        doctors: nearbyDoctors,
        isLiked: false, // contoh default false, jangan null
        hospitals: rumahSakitList,
      ),
    );
  }
}
