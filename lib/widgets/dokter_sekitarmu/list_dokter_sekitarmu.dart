import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/screens/detail_doctor_screen.dart'; // import halaman detail
import 'package:ionicons/ionicons.dart';

class ListDokterSekitarmu extends StatelessWidget {
  final bool isLiked;
  final VoidCallback? onTapLike;
  final List<DoctorModel> doctors;
  final List<RumahSakitModel> hospitals;

  const ListDokterSekitarmu({
    super.key,
    required this.doctors,
    required this.isLiked,
    this.onTapLike,
    required this.hospitals,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          // Cari rumah sakit sesuai hospitalId dokter
          final hospital = hospitals.firstWhere(
            (h) => _getHospitalId(h) == doctor.hospitalId,
            orElse:
                () => RumahSakitModel(
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
                  builder:
                      (context) => DetailDoctorScreen(
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
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar Dokter
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          doctor.profile,
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.person, size: 120),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Bagian teks
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
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                ...List.generate(5, (starIndex) {
                                  return Icon(
                                    Ionicons.star,
                                    size: 20,
                                    color:
                                        starIndex < doctor.averageReview
                                            ? Colors.amber
                                            : Colors.grey.shade300,
                                  );
                                }),
                                const SizedBox(width: 8),
                                Text(
                                  doctor.averageReview.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  "(10 views)",
                                  style: TextStyle(
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
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: onTapLike,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                            size: 24,
                          ),
                        ),
                      ),
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
}

// Mapping nama rumah sakit ke id yang digunakan di DoctorModel
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
