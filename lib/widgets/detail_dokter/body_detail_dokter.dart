import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/screens/jadwal_konsultasi_screen.dart';
import 'package:finalproject/widgets/detail_dokter/detail_navbar.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/theme/theme.dart';

class Review {
  final String profile;
  final String name;
  final double rating;
  final String reviewText;
  final String timeAgo;

  Review({
    required this.profile,
    required this.name,
    required this.rating,
    required this.reviewText,
    required this.timeAgo,
  });
}

final List<Review> reviews = [
  Review(
    profile: 'assets/images/doctor_1.jpg',
    name: 'Ayu Saputra',
    rating: 4.9,
    reviewText: 'Dokternya sangat ramah dan profesional.',
    timeAgo: '2 jam lalu',
  ),
  Review(
    profile: 'assets/images/doctor_1.jpg',
    name: 'Budi Santoso',
    rating: 4.8,
    reviewText: 'Pelayanan cepat dan memuaskan.',
    timeAgo: '1 jam lalu',
  ),
  Review(
    profile: 'assets/images/doctor_1.jpg',
    name: 'Citra Dewi',
    rating: 5.0,
    reviewText: 'Sangat membantu masalah kesehatan saya.',
    timeAgo: '30 menit lalu',
  ),
  Review(
    profile: 'assets/images/doctor_1.jpg',
    name: 'Dewi Lestari',
    rating: 4.7,
    reviewText: 'Rekomendasi terbaik untuk dokter gigi.',
    timeAgo: '3 jam lalu',
  ),
];

class BodyDetailDokter extends StatelessWidget {
  final DoctorModel doctor;
  final RumahSakitModel hospital;
  const BodyDetailDokter({
    super.key,
    required this.doctor,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 47,
                    backgroundImage: AssetImage(doctor.profile),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    doctor.position,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tentang Dokter",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Review",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 9),
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 4),
                          const Text(
                            "4.9",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 9),
                          Text(
                            "(${reviews.length})",
                            style: TextStyle(
                              color: lightColorScheme.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Lihat Semua",
                              style: TextStyle(color: lightColorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                        review.profile,
                                      ),
                                    ),
                                    title: Text(
                                      review.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: List.generate(5, (
                                            starIndex,
                                          ) {
                                            return Icon(
                                              Icons.star,
                                              size: 16,
                                              color:
                                                  starIndex <
                                                          review.rating.floor()
                                                      ? Colors.amber
                                                      : Colors.grey.shade300,
                                            );
                                          }),
                                        ),
                                        Text(
                                          review.timeAgo,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    review.reviewText,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Lokasi",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: lightColorScheme.primary.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.location_on,
                              color: lightColorScheme.primary,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hospital.name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  hospital.address,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            DetailNavBar(
              onBook: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => JadwalKonsultasiScreen(doctor: doctor),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
