import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/screens/detail_doctor_screen.dart'; // Asumsi sudah ada halaman detail dokter

class ListDokterSpecialist extends StatelessWidget {
  final String position; // filter berdasarkan position di doctor model
  final List<DoctorModel> allDoctors;
  final List<RumahSakitModel> allHospitals;

  const ListDokterSpecialist({
    super.key,
    required this.position,
    required this.allDoctors,
    required this.allHospitals,
  });

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = allDoctors
        .where((doc) => doc.position.toLowerCase() == position.toLowerCase())
        .toList();

    return CustomScaffold2(
      child: filteredDoctors.isEmpty
          ? const Center(
              child: Text("Belum ada dokter dengan spesialisasi ini."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];

                final hospital = allHospitals.firstWhere(
                  (h) => _getHospitalId(h) == doctor.hospitalId,
                  orElse: () => RumahSakitModel(
                    name: 'Tidak diketahui',
                    address: '-',
                    image: '',
                  ),
                );

                return InkWell(
                  borderRadius: BorderRadius.circular(14),
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
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            doctor.profile,
                            width: 85,
                            height: 85,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 85),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr. ${doctor.name}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor.position,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                hospital.name,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  ...List.generate(5, (starIndex) {
                                    return Icon(
                                      Icons.star,
                                      size: 20,
                                      color: starIndex < doctor.averageReview
                                          ? Colors.amber
                                          : Colors.grey.shade300,
                                    );
                                  }),
                                  const SizedBox(width: 8),
                                  Text(
                                    doctor.averageReview.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "(${doctor.totalReviews} reviews)",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

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
