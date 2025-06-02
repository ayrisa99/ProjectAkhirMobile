import 'package:finalproject/widgets/rumah_sakit/list_dokter_rs.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/widgets/rumah_sakit/list_rumah_sakit.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';

class RumahSakitScreen extends StatefulWidget {
  const RumahSakitScreen({super.key});

  @override
  State<RumahSakitScreen> createState() => _RumahSakitScreenState();
}

class _RumahSakitScreenState extends State<RumahSakitScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Rumah Sakit',
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
      child: ListRumahSakit(
        hospitals: rumahSakitList,
        onTapHospital: (hospital) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ListDokterRS(
                hospital: hospital,
                allDoctors: nearbyDoctors,
              ),
            ),
          );
        },
      ),
    );
  }
}
