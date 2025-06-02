import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/models/rumah_sakit_models.dart'; // import model rumah sakit
import 'package:finalproject/screens/detail_doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NearbyDoctors extends StatelessWidget {
  final List<RumahSakitModel> hospitals; // tambahkan daftar rumah sakit

  const NearbyDoctors({super.key, required this.hospitals});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: nearbyDoctors.length,
        itemBuilder: (context, index) {
          final doctor = nearbyDoctors[index];

          // Cari rumah sakit sesuai hospitalId dokter
          final hospital = hospitals.firstWhere(
            (h) => _getHospitalId(h) == doctor.hospitalId,
            orElse: () => RumahSakitModel(
              name: 'Tidak diketahui',
              address: '-',
              image: '',
            ),
          );

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailDoctorScreen(
                    doctor: doctor,
                    hospital: hospital,
                  ),
                ),
              );
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      doctor.profile,
                      height: 155,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Dr. ${doctor.name}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.position,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (starIndex) {
                      return Icon(
                        Ionicons.star,
                        size: 16,
                        color:
                            starIndex < doctor.averageReview
                                ? Colors.amber
                                : Colors.grey.shade300,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Fungsi mapping nama rumah sakit ke id
  String _getHospitalId(RumahSakitModel hospital) {
    switch (hospital.name) {
      case 'RS Mitra Sehat':
        return 'rs1';
      case 'RS Harapan Bunda':
        return 'rs2';
      case 'RS Sentosa':
        return 'rs3';
      case 'RS Sejahtera':
        return 'rs4';
      default:
        return '';
    }
  }
}
