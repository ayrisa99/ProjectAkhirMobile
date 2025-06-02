import 'package:finalproject/screens/pendaftaran_screen.dart';
import 'package:finalproject/screens/rumah_sakit_screen.dart';
import 'package:flutter/material.dart';

class HealthNeeds extends StatelessWidget {
  const HealthNeeds({super.key});

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(name: "Pendaftaran", icon: 'assets/logo/appointment.png'),
      CustomIcon(name: "Rumah Sakit", icon: 'assets/logo/hospitallogo.png'),
      CustomIcon(name: "Artikel", icon: 'assets/logo/articlelogo.png'),
      CustomIcon(name: "Lainnya", icon: 'assets/logo/morelogo.png'),
    ];
    List<CustomIcon> healthNeeds = [
      CustomIcon(name: "Pendaftaran", icon: 'assets/logo/appointment.png'),
      CustomIcon(name: "Rumah Sakit", icon: 'assets/logo/hospitallogo.png'),
      CustomIcon(name: "Artikel", icon: 'assets/logo/articlelogo.png'),
      CustomIcon(name: "Obat", icon: 'assets/logo/pharmacylogo.png'),
    ];
    List<CustomIcon> specialisedCared = [
      CustomIcon(name: "Dokter Umum", icon: 'assets/logo/dokterumum.png'),
      CustomIcon(name: "Mata", icon: 'assets/logo/doktermata.png'),
      CustomIcon(name: "Anak", icon: 'assets/logo/dokteranak.png'),
      CustomIcon(
        name: "Kulit dan Kelamin",
        icon: 'assets/logo/dokterkulit.png',
      ),
      CustomIcon(name: "Jantung", icon: 'assets/logo/dokterjantung.png'),
      CustomIcon(name: "Kandungan", icon: 'assets/logo/dokterkandungan.png'),
      CustomIcon(name: "Ortopedi", icon: 'assets/logo/ortopedi.png'),
      CustomIcon(name: "Psikiater", icon: 'assets/logo/dokterpsikolog.png'),
      CustomIcon(name: "Saraf", icon: 'assets/logo/doktersaraf.png'),
      CustomIcon(name: "THT", icon: 'assets/logo/doktertht.png'),
      CustomIcon(
        name: "Penyakit Dalam",
        icon: 'assets/logo/dokterpenyakitdalam.png',
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(customIcons.length, (index) {
        return SizedBox(
          width: 70, // Lebar tetap supaya rata
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (index == 0) {
                    // Navigasi ke halaman RumahSakitScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PendaftaranScreen(),
                      ),
                    );
                  } else if (index == 1) {
                    // Navigasi ke halaman RumahSakitScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RumahSakitScreen(),
                      ),
                    );
                  } else if (index == customIcons.length - 1) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          initialChildSize: 0.6,
                          minChildSize: 0.4,
                          maxChildSize: 0.9,
                          builder: (context, scrollController) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: ListView(
                                controller: scrollController,
                                shrinkWrap: true,
                                children: [
                                  const Center(child: Icon(Icons.drag_handle)),
                                  const SizedBox(height: 15),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Kebutuhan Kesehatan",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),

                                  /// Health Needs Grid
                                  GridView.count(
                                    crossAxisCount: 4,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    children: List.generate(
                                      healthNeeds.length,
                                      (index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.shade200,
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  healthNeeds[index].icon,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Flexible(
                                              child: Text(
                                                healthNeeds[index].name,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Specialised Care",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),

                                  /// Specialised Care Grid
                                  GridView.count(
                                    crossAxisCount: 4,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisSpacing: 35,
                                    mainAxisSpacing: 35,
                                    children: List.generate(
                                      specialisedCared.length,
                                      (index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.shade200,
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  specialisedCared[index].icon,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Flexible(
                                              child: SizedBox(
                                                width: 70,
                                                child: Text(
                                                  specialisedCared[index].name,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
                borderRadius: BorderRadius.circular(90),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.asset(
                      customIcons[index].icon,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                customIcons[index].name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CustomIcon {
  final String name;
  final String icon;

  CustomIcon({required this.name, required this.icon});
}
