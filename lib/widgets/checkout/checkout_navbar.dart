import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/cubit/app_state_cubit.dart';
import 'package:finalproject/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Untuk menyimpan dan mengambil diskon

class CheckoutNavBar extends StatelessWidget {
  final VoidCallback onCheckout;

  const CheckoutNavBar({super.key, required this.onCheckout});

  // Fungsi untuk mengambil diskon yang tersimpan
  Future<double> _getDiscount() async {
    final prefs = await SharedPreferences.getInstance();
    String? discountMessage = prefs.getString('discount');
    double discount = 0.0;

    if (discountMessage != null) {
      // Memilih nilai diskon berdasarkan pesan
      if (discountMessage.contains("10%")) {
        discount = 0.10;
      } else if (discountMessage.contains("20%")) {
        discount = 0.20;
      } else if (discountMessage.contains("30%")) {
        discount = 0.30;
      } else if (discountMessage.contains("50%")) {
        discount = 0.50;
      }
    }

    // Hapus diskon setelah dipakai
    await prefs.remove('discount');

    return discount;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AppStateCubit>();
    final selectedItems = cubit.selectedItems;

    double subTotal = 0;
    for (var item in selectedItems) {
      final priceStr = item.price.replaceAll(RegExp(r'[^\d.]'), '');
      final price = double.tryParse(priceStr) ?? 0;
      final qty = cubit.getQuantity(item);
      subTotal += price * qty;
    }

    final double tax = subTotal * 0.10;

    return FutureBuilder<double>(
      future: _getDiscount(), // Ambil diskon dari SharedPreferences
      builder: (context, snapshot) {
        double total = subTotal + tax;
        double discount = 0.0;

        if (snapshot.connectionState == ConnectionState.done) {
          // Jika diskon tersedia
          if (snapshot.hasData && snapshot.data != null && snapshot.data! > 0) {
            discount = snapshot.data!;
            total =
                (subTotal + tax) * (1 - discount); // Apply diskon pada total
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Pajak & Subtotal (abu-abu)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pajak (10%)',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      '\$${tax.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      '\$${subTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                // Menampilkan Diskon jika ada
                if (discount > 0) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Diskon',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '-\$${(subTotal * discount).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 12),

                // Bar bawah: total (hijau) + tombol di kanan
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: lightColorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: onCheckout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightColorScheme.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: const Text(
                          'Buat Pesanan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          // Jika data diskon belum selesai dimuat, tampilkan loading
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
