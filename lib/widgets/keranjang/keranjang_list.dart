import 'package:flutter/material.dart';
import 'package:finalproject/models/medicine_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/cubit/app_state_cubit.dart';
import 'package:finalproject/theme/theme.dart';

class KeranjangList extends StatelessWidget {
  final List<Medicine> items;

  const KeranjangList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AppStateCubit>();

    // Group items by storeAddress
    final Map<String, List<Medicine>> groupedItems = {};
    for (var item in items) {
      groupedItems.putIfAbsent(item.storeAddress, () => []).add(item);
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children:
          groupedItems.entries.map((entry) {
            final storeAddress = entry.key;
            final medicines = entry.value;

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with icon store and store address
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.store,
                          size: 20,
                          color: lightColorScheme.primary,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            storeAddress,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1, thickness: 0.5),

                  ...medicines.map((item) {
                    final quantity = cubit.getQuantity(item);
                    final isSelected = cubit.isItemSelected(
                      item,
                    ); // pastikan fungsi ini ada di cubit

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          // Checkbox di kiri gambar
                          Checkbox(
                            value: isSelected,
                            onChanged: (bool? value) {
                              if (value != null) {
                                cubit.toggleItemSelected(item, value);
                              }
                            },
                            activeColor: lightColorScheme.primary,
                          ),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.imageUrl,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    height: 80,
                                    width: 80,
                                    color: Colors.grey.shade300,
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Kategori: ${item.category}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.price,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: lightColorScheme.primary,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (quantity > 1) {
                                              cubit.decrementQuantity(item);
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (context) => AlertDialog(
                                                      backgroundColor:
                                                          Colors
                                                              .white, // warna dasar putih
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                      ),
                                                      titlePadding:
                                                          const EdgeInsets.fromLTRB(
                                                            24,
                                                            24,
                                                            24,
                                                            0,
                                                          ),
                                                      contentPadding:
                                                          const EdgeInsets.fromLTRB(
                                                            24,
                                                            20,
                                                            24,
                                                            24,
                                                          ),
                                                      title: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.info_outline,
                                                            color:
                                                                lightColorScheme
                                                                    .primary,
                                                            size: 28,
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              'Konfirmasi Penghapusan',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                color:
                                                                    Colors
                                                                        .black87,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      content: Text(
                                                        'Apakah Anda yakin ingin menghapus "${item.name}" dari keranjang?',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      actionsPadding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 8,
                                                          ),
                                                      actions: [
                                                        TextButton(
                                                          style: TextButton.styleFrom(
                                                            foregroundColor:
                                                                Colors
                                                                    .grey
                                                                    .shade600,
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 12,
                                                                ),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    12,
                                                                  ),
                                                            ),
                                                          ),
                                                          onPressed:
                                                              () =>
                                                                  Navigator.pop(
                                                                    context,
                                                                  ),
                                                          child: const Text(
                                                            'Batal',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                lightColorScheme
                                                                    .primary,
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      24,
                                                                  vertical: 12,
                                                                ),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    12,
                                                                  ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            cubit
                                                                .removeItemFromCart(
                                                                  item,
                                                                );
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          },
                                                          child: const Text(
                                                            'Ya, hapus',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: lightColorScheme.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(6),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          '$quantity',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: lightColorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        GestureDetector(
                                          onTap:
                                              () =>
                                                  cubit.incrementQuantity(item),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: lightColorScheme.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(6),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          }).toList(),
    );
  }
}
