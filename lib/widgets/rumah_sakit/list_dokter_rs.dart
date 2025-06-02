import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/screens/detail_doctor_screen.dart'; // Asumsi sudah ada halaman detail dokter

class ListDokterRS extends StatelessWidget {
  final RumahSakitModel hospital;
  final List<DoctorModel> allDoctors;

  const ListDokterRS({
    super.key,
    required this.hospital,
    required this.allDoctors,
  });

  @override
  Widget build(BuildContext context) {
    // Filter dokter berdasarkan hospitalId
    final doctorsInHospital =
        allDoctors
            .where((doc) => doc.hospitalId == _getHospitalId(hospital))
            .toList();

    return CustomScaffold2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Dokter di ${hospital.name}',
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
      child:
          doctorsInHospital.isEmpty
              ? const Center(
                child: Text("Belum ada dokter terdaftar di rumah sakit ini."),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: doctorsInHospital.length,
                itemBuilder: (context, index) {
                  final doctor = doctorsInHospital[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => DetailDoctorScreen(
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
                              errorBuilder:
                                  (context, error, stackTrace) =>
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
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    ...List.generate(5, (starIndex) {
                                      return Icon(
                                        Icons.star,
                                        size: 20,
                                        color:
                                            starIndex < doctor.averageReview
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

  // Karena rumah sakit kamu gak punya id, tapi di doctorModel pakai hospitalId,
  // kamu perlu cara untuk 'mapping' antara rumah sakit dan hospitalId doctor.
  // Contoh: kamu bisa buat mapping manual di sini:
  String _getHospitalId(RumahSakitModel hospital) {
    // contoh mapping berdasarkan nama rumah sakit
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
