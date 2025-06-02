import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/screens/dokter_sekitarmu_screen.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:finalproject/widgets/health_articel.dart';
import 'package:finalproject/widgets/health_needs.dart';
import 'package:finalproject/widgets/top_doctor.dart';
import 'package:finalproject/widgets/upcoming_card.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false;
  final DoctorModel exampleDoctor = nearbyDoctors[0];
  final TextEditingController _searchController = TextEditingController();

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title:
            _isSearching
                ? Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Cari sesuatu...",
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Ionicons.search_outline,
                        color: Colors.black54,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close, color: Colors.black54),
                        onPressed: () {
                          _searchController.clear();
                          _stopSearch();
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    cursorColor: Colors.black,
                    onSubmitted: (query) {
                      print("Search query: $query");
                    },
                  ),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hi, Ayrisa",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Bagaimana perasaanmu hari ini?",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontSize: 15),
                    ),
                  ],
                ),
        actions: [
          IconButton(
            icon: const Icon(
              Ionicons.notifications_outline,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          if (!_isSearching)
            IconButton(
              icon: const Icon(Ionicons.search_outline, color: Colors.black),
              onPressed: _startSearch,
            ),
        ],
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        children: [
          const SizedBox(height: 20),
          const UpcomingCard(),
          const SizedBox(height: 20),
          const Text(
            "Kebutuhan Kesehatan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const HealthNeeds(),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dokter Sekitarmu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              DokterSekitarmuScreen(doctor: exampleDoctor),
                    ),
                  );
                },
                child: const Text(
                  "Lihat Semua",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          NearbyDoctors(hospitals: rumahSakitList),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Artikel Kesehatan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Lihat Semua",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const HealthArticel(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
