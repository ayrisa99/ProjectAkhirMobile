import 'package:finalproject/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CompletedScahdule extends StatelessWidget {
  const CompletedScahdule({super.key});

  Widget _buildSingleSchedule(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        height: 186,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: lightColorScheme.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: lightColorScheme.primary.withOpacity(0.08),
              blurRadius: 1,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto dokter kiri
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/doctor_2.jpg',
                  width: 45,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Informasi dan tombol
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dr. Ruben Dorwart",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Dokter Gigi",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Ionicons.calendar_outline,
                            size: 18,
                            color: Colors.black45,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "15/07/2025",
                            style: TextStyle(color: Colors.black45),
                          ),
                          SizedBox(width: 14),
                          Icon(
                            Ionicons.time_outline,
                            size: 18,
                            color: Colors.black45,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "14:30 - 15:30 AM",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F6FA),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: lightColorScheme.primary,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Review",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: lightColorScheme.primary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                "Booking Lagi",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(5, (index) => _buildSingleSchedule(context)),
      ),
    );
  }
}
