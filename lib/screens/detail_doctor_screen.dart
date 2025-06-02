import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/widgets/detail_dokter/body_detail_dokter.dart';

class DetailDoctorScreen extends StatefulWidget {
  final DoctorModel doctor;
  final RumahSakitModel hospital;

  const DetailDoctorScreen({
    super.key,
    required this.doctor,
    required this.hospital,
  });

  @override
  State<DetailDoctorScreen> createState() => _DetailDoctorScreenState();
}

class _DetailDoctorScreenState extends State<DetailDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      child: BodyDetailDokter(doctor: widget.doctor, hospital: widget.hospital),
    );
  }
}
