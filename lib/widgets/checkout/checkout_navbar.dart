import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/cubit/app_state_cubit.dart';
import 'package:finalproject/theme/theme.dart';

class CheckoutNavBar extends StatelessWidget {
  final VoidCallback onCheckout;

  const CheckoutNavBar({super.key, required this.onCheckout});

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
    final double total = subTotal + tax;

    TextStyle labelStyle = const TextStyle(color: Colors.grey, fontSize: 14);
    TextStyle priceStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.grey,
    );
    TextStyle totalStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: lightColorScheme.primary,
    );

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
              Text('Pajak (10%)', style: labelStyle),
              Text('\$${tax.toStringAsFixed(2)}', style: priceStyle),
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
                  color: Colors.black, // warna item default
                ),
              ),
              Text('\$${total.toStringAsFixed(2)}', style: totalStyle),
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
  }
}
