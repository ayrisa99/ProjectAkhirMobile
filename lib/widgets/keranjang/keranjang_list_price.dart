import 'package:finalproject/screens/checkout_screen.dart';
import 'package:finalproject/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/medicine_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/cubit/app_state_cubit.dart';

class KeranjangListPrice extends StatelessWidget {
  final List<Medicine> items;

  const KeranjangListPrice({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AppStateCubit>();

    // Ambil list item yang sedang dicentang di cubit
    final selectedItems = cubit.selectedItems;

    // Hitung subtotal berdasarkan item yang dicentang dan quantity-nya
    double subTotal = 0;
    for (var item in selectedItems) {
      try {
        final priceStr = item.price.replaceAll(RegExp(r'[^\d.]'), '');
        final price = double.tryParse(priceStr) ?? 0;
        final qty = cubit.getQuantity(item);

        subTotal += price * qty;
      } catch (_) {}
    }

    final double pajak = subTotal * 0.10; // pajak 10% dari subtotal
    final double total = subTotal + pajak;

    TextStyle labelStyle = const TextStyle(color: Colors.grey, fontSize: 14);
    TextStyle priceStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pajak (10%)', style: labelStyle),
              Text('\$${pajak.toStringAsFixed(2)}', style: priceStyle),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: labelStyle),
              Text('\$${subTotal.toStringAsFixed(2)}', style: priceStyle),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigasi ke CheckoutScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightColorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Text(
                'CHECKOUT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
