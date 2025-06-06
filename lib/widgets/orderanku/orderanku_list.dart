import 'package:flutter/material.dart';
import 'package:finalproject/models/medicine_model.dart';
import 'package:finalproject/theme/theme.dart';

class OrderankuList extends StatelessWidget {
  final List<Medicine> items;
  final Map<String, DateTime> pickUpTimes; // Waktu pengambilan per toko
  final Map<String, double> totalPrices; // Total harga per toko

  const OrderankuList({
    super.key,
    required this.items,
    required this.pickUpTimes,
    required this.totalPrices,
  });

  @override
  Widget build(BuildContext context) {
    // Group items by storeAddress
    final Map<String, List<Medicine>> groupedItems = {};
    for (var item in items) {
      groupedItems.putIfAbsent(item.storeAddress, () => []).add(item);
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: groupedItems.entries.map((entry) {
        final storeAddress = entry.key;
        final medicines = entry.value;
        final pickUpTime = pickUpTimes[storeAddress];
        final totalPrice = totalPrices[storeAddress] ?? 0;

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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan ikon toko dan alamat toko
                Row(
                  children: [
                    Icon(Icons.store, size: 20, color: lightColorScheme.primary),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        storeAddress,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Daftar obat
                ...medicines.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.imageUrl,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 80,
                              width: 80,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )),
                              const SizedBox(height: 4),
                              Text(
                                item.price,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: lightColorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const Divider(height: 32, thickness: 1),

                // Informasi waktu pengambilan dan total harga
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (pickUpTime != null)
                      Text(
                        'Waktu Pengambilan: ${_formatDateTime(pickUpTime)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    Text(
                      'Total: Rp ${totalPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: lightColorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _formatDateTime(DateTime dt) {
    // Format tanggal dan jam, bisa disesuaikan
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
