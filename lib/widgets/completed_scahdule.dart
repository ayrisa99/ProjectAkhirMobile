import 'package:finalproject/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CompletedScahdule extends StatelessWidget {
  const CompletedScahdule({super.key});

  // Method untuk satu jadwal dokter
  Widget _buildSingleSchedule(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
          ],
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  "Dr. Ruben Dorwart",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: const Text(
                  "Dokter Gigi",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                trailing: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/doctor_2.jpg"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(thickness: 1, height: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Ionicons.calendar_outline,
                              size: 16,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "15/07/2025",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: const [
                            Icon(
                              Ionicons.time_outline,
                              size: 16,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "14:30 - 15:30 AM",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            margin: const EdgeInsets.only(left: 15),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F6FA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Review",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
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
                              borderRadius: BorderRadius.circular(10),
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
            ],
          ),
        ),
      ),
    );
  }

  // Build method utama menampilkan 5 jadwal
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(5, (index) => _buildSingleSchedule(context)),
      ),
    );
  }
}
