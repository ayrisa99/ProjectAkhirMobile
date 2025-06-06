import 'package:finalproject/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/models/medicine_model.dart';
import 'package:finalproject/widgets/medicine/medicine_category_card.dart';
import 'package:finalproject/widgets/medicine/medicine_category_button.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:geocoding/geocoding.dart' as Geocoding;
import '../services/medicine_service.dart';
import '../screens/medicine_detail_screen.dart';
import '../screens/shopping_keranjang.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/currency.dart';
import 'package:geolocator/geolocator.dart'; // Import geolocator
import 'package:geocoding/geocoding.dart'; // Import geocoding

class MedicineStoreScreen extends StatefulWidget {
  const MedicineStoreScreen({super.key});

  @override
  State<MedicineStoreScreen> createState() => _MedicineStoreScreenState();
}

class _MedicineStoreScreenState extends State<MedicineStoreScreen> {
  final MedicineService _medicineService = MedicineService();
  late Future<List<Medicine>> _futureMedicines;

  int selectedCategoryIndex = 0;
  final TextEditingController searchController = TextEditingController();

  List<String> categories = ['All'];

  // Variabel untuk lokasi pengguna
  String _currentLocation = "Mendapatkan lokasi...";

  @override
  void initState() {
    super.initState();
    _futureMedicines = _medicineService.fetchMedicines();
    _getCurrentLocation(); // Mendapatkan lokasi pengguna
  }

  // Fungsi untuk mendapatkan lokasi pengguna
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = "Layanan lokasi tidak diaktifkan";
      });
      return;
    }

    // Memeriksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = "Izin lokasi ditolak";
        });
        return;
      }
    }

    // Mendapatkan lokasi
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Mengonversi koordinat menjadi alamat
    List<Placemark> placemarks = await Geocoding.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Menampilkan alamat pengguna
    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      setState(() {
        // Menampilkan alamat dengan lebih lengkap, termasuk sublocality dan street
        _currentLocation =
            "${place.street ?? 'Tidak ditemukan'}, ${place.subLocality ?? 'Tidak ditemukan'}, ${place.locality ?? 'Tidak ditemukan'}, ${place.administrativeArea ?? 'Tidak ditemukan'}, ${place.country ?? 'Tidak ditemukan'}";
      });
    }
  }

  // Filter obat berdasarkan kategori dan search query
  List<Medicine> filterMedicines(
    List<Medicine> medicines,
    String category,
    String query,
  ) {
    query = query.toLowerCase();
    return medicines.where((medicine) {
      final matchesCategory =
          category == 'All' ? true : medicine.productGroup == category;
      final matchesQuery =
          medicine.name.toLowerCase().contains(query) ||
          medicine.productGroup.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  // Ambil kategori unik dari list medicine
  List<String> getCategoriesFromMedicines(List<Medicine> medicines) {
    final Set<String> uniqueCategories = {};
    for (var medicine in medicines) {
      if (medicine.productGroup.isNotEmpty) {
        uniqueCategories.add(medicine.productGroup);
      }
    }
    return ['All', ...uniqueCategories];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Body Shop', // Mengubah nama toko jadi Body Shop
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        actionsPadding: const EdgeInsets.only(right: 15),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ShoppingKeranjangScreen(),
                ),
              );
            },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Filter bar with search and currency dropdown
            Row(
              children: [
                // Search bar
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        hintText: 'Cari produk',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        suffixIcon:
                            searchController.text.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    searchController.clear();
                                    setState(() {});
                                  },
                                )
                                : null,
                      ),
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Currency Dropdown
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: lightColorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {
                      // TODO: implement filter action jika perlu
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Mata uang
            Row(
              children: [
                const Text('Mata Uang:'),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: context.watch<CurrencyProvider>().currency,
                  onChanged: (String? newValue) {
                    setState(() {
                      context.read<CurrencyProvider>().setCurrency(newValue!);
                    });
                  },
                  items:
                      <String>[
                        'IDR',
                        'USD',
                        'EUR',
                        'JPY',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Lokasi Pengguna
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                _currentLocation, // Menampilkan lokasi pengguna
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // FutureBuilder untuk data medicine
            FutureBuilder<List<Medicine>>(
              future: _futureMedicines,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'Tidak ada produk ditemukan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }

                final medicines = snapshot.data!;

                // Update categories list secara dinamis dari data medicine
                categories = getCategoriesFromMedicines(medicines);

                final category = categories[selectedCategoryIndex];

                // Tombol kategori horizontal scroll
                final categorySelector = SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CategoryButton(
                          title: categories[index],
                          isSelected: selectedCategoryIndex == index,
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = index;
                              searchController.clear();
                            });
                          },
                        ),
                      );
                    }),
                  ),
                );

                // Filter produk berdasarkan kategori dan pencarian
                final filteredProducts = filterMedicines(
                  medicines,
                  category,
                  searchController.text,
                );

                return Expanded(
                  child: Column(
                    children: [
                      categorySelector,
                      const SizedBox(height: 25),
                      filteredProducts.isEmpty
                          ? const Center(
                            child: Text(
                              'Tidak ada produk ditemukan',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                          : Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 0.75,
                                  ),
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                final medicine = filteredProducts[index];

                                // Ambil currency dari provider
                                final currencyProvider =
                                    Provider.of<CurrencyProvider>(
                                      context,
                                      listen: false,
                                    );
                                final currencySymbol =
                                    currencyProvider.currency == 'USD'
                                        ? '\$'
                                        : currencyProvider.currency == 'EUR'
                                        ? '€'
                                        : currencyProvider.currency == 'JPY'
                                        ? '¥'
                                        : 'Rp'; // default IDR
                                final bool isOriginalCurrency =
                                    currencyProvider.currency == 'IDR';
                                final double priceValue =
                                    double.tryParse(medicine.price) ?? 0.0;
                                final double displayPrice =
                                    isOriginalCurrency
                                        ? priceValue
                                        : priceValue * currencyProvider.rate;
                                final String priceText =
                                    '${isOriginalCurrency ? 'Rp' : currencyProvider.currency} ${displayPrice.toStringAsFixed(2)}';

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => MedicineDetailScreen(
                                              item: medicine,
                                            ),
                                      ),
                                    );
                                  },
                                  child: ProductCard(
                                    imageUrl: medicine.imageUrl,
                                    name: medicine.name,
                                    category: medicine.productGroup,
                                    price: priceText,
                                    storeAddress: medicine.storeAddress,
                                    isLiked: false,
                                    onTapAdd: () {},
                                    onTapLike: () {},
                                    pricePrefix: '',
                                  ),
                                );
                              },
                            ),
                          ),
                    ],
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
