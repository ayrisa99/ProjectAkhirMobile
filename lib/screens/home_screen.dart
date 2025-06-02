import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/screens/artikel_screen.dart';
import 'package:finalproject/screens/dokter_sekitarmu_screen.dart';
import 'package:finalproject/theme/theme.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:finalproject/widgets/health_articel.dart';
import 'package:finalproject/widgets/health_needs.dart';
import 'package:finalproject/widgets/top_doctor.dart';
import 'package:finalproject/widgets/upcoming_card.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // <-- import ini
import 'package:google_maps_flutter/google_maps_flutter.dart'; // tidak perlu kalau hanya alamat

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _currentAddress; // <-- alamat lokasi
  LatLng? _currentPosition;
  bool _isSearching = false;
  final DoctorModel exampleDoctor = nearbyDoctors[0];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enable location services')),
        );
      }
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied')),
          );
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Location permissions are permanently denied, please enable it from settings',
            ),
          ),
        );
      }
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (mounted) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      await _getAddressFromLatLng(position);
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        setState(() {
          _currentAddress =
              "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      print("Error reverse geocoding: $e");
    }
  }

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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Hi, Ayrisa",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 7),
                    GestureDetector(
                      onTap: () async {
                        await _determinePosition();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Ionicons.location,
                            size: 20,
                            color: lightColorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _currentAddress ?? "Mencari lokasi kamu...",
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArtikelScreen()),
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
          const HealthArticel(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
