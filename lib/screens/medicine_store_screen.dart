import 'package:finalproject/screens/shopping_keranjang.dart';
import 'package:finalproject/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/data/medicine_data.dart';
import 'package:finalproject/widgets/medicine/medicine_category_button.dart';
import 'package:finalproject/widgets/medicine/medicine_category_card.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import '../screens/medicine_detail_screen.dart';

class MedicineStoreScreen extends StatefulWidget {
  const MedicineStoreScreen({super.key});

  @override
  State<MedicineStoreScreen> createState() => _MedicineStoreScreenState();
}

class _MedicineStoreScreenState extends State<MedicineStoreScreen> {
  int selectedCategoryIndex = 0;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final category = categories[selectedCategoryIndex];

    final filteredProducts =
        category == 'All'
            ? products.values.expand((list) => list).where((medicine) {
              final query = searchController.text.toLowerCase();
              return medicine.name.toLowerCase().contains(query) ||
                  medicine.category.toLowerCase().contains(query);
            }).toList()
            : products[category]!.where((medicine) {
              final query = searchController.text.toLowerCase();
              return medicine.name.toLowerCase().contains(query) ||
                  medicine.category.toLowerCase().contains(query);
            }).toList();

    return CustomScaffold2(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Toko Kesehatan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        actionsPadding: const EdgeInsets.only(right: 15), // Perbaikan di sini
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
            Row(
              children: [
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
                      // TODO: Implementasi aksi filter
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
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
            ),
            const SizedBox(height: 25),
            Expanded(
              child:
                  filteredProducts.isEmpty
                      ? const Center(
                        child: Text(
                          'Tidak ada produk ditemukan',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : GridView.builder(
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          MedicineDetailScreen(item: medicine),
                                ),
                              );
                            },
                            child: ProductCard(
                              imageUrl: medicine.imageUrl,
                              name: medicine.name,
                              category: medicine.category,
                              price: medicine.price,
                              storeAddress: medicine.storeAddress,
                              isLiked: false,
                              onTapAdd: () {},
                              onTapLike: () {},
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
