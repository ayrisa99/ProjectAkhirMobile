import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:finalproject/widgets/specialist/list_specialist.dart';
import 'package:flutter/material.dart';

class DokterSpecialistScreen extends StatefulWidget {
  final DoctorModel doctor;
  final String position;
  final List<DoctorModel> allDoctors;
  final List<RumahSakitModel> allHospitals;

  const DokterSpecialistScreen({super.key, required this.doctor, required this.allDoctors, required this.allHospitals, required this.position});

  @override
  State<DokterSpecialistScreen> createState() => _DokterSpecialistScreenState();
}

class _DokterSpecialistScreenState extends State<DokterSpecialistScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Dokter Spesialis ${widget.doctor.position}",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
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
      child: ListDokterSpecialist(
        position: widget.position,
        allDoctors: widget.allDoctors,
        allHospitals: widget.allHospitals,
      ),
    );
  }
}
