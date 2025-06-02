import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/models/medicine_model.dart';
import 'package:finalproject/cubit/app_state_cubit.dart';
import 'package:finalproject/theme/theme.dart';
import 'package:intl/intl.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({super.key});

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  String pickupOption = 'Sekarang';

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;

  List<DateTime> get nextThreeDays {
    final now = DateTime.now();
    return List.generate(
      3,
      (i) => DateTime(now.year, now.month, now.day).add(Duration(days: i)),
    );
  }

  List<TimeOfDay> generateTimeSlots() {
    final slots = <TimeOfDay>[];
    for (int hour = 10; hour <= 20; hour++) {
      slots.add(TimeOfDay(hour: hour, minute: 0));
    }
    return slots;
  }

  String formatDate(DateTime d) => DateFormat('EEE, dd MMM').format(d);

  Widget buildCustomButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? lightColorScheme.primary : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AppStateCubit>();
    final List<Medicine> selectedItems = cubit.selectedItems;

    // Group produk berdasarkan alamat toko
    final Map<String, List<Medicine>> groupedByStore = {};
    for (var item in selectedItems) {
      groupedByStore.putIfAbsent(item.storeAddress, () => []).add(item);
    }

    // Hitung total harga
    double totalPrice = 0;
    for (var item in selectedItems) {
      final priceStr = item.price.replaceAll(RegExp(r'[^\d.]'), '');
      final price = double.tryParse(priceStr) ?? 0;
      final qty = cubit.getQuantity(item);
      totalPrice += price * qty;
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Alamat Toko',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...groupedByStore.keys.map(
                    (storeAddress) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.store,
                            color: lightColorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              storeAddress,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Opsi Ambil Pesanan Sendiri',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      RadioListTile<String>(
                        activeColor:
                            lightColorScheme
                                .primary, // warna lingkaran saat dipilih
                        title: const Text('Ambil Sekarang'),
                        value: 'Sekarang',
                        groupValue: pickupOption,
                        onChanged: (value) {
                          setState(() {
                            pickupOption = value!;
                            selectedDate = null;
                            selectedTime = null;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: lightColorScheme.primary,
                        title: const Text('Ambil Terjadwal'),
                        value: 'Terjadwal',
                        groupValue: pickupOption,
                        onChanged: (value) {
                          setState(() {
                            pickupOption = value!;
                            if (selectedDate == null) {
                              selectedDate = nextThreeDays[0];
                              selectedDateIndex = 0;
                            }
                            if (selectedTime == null) {
                              selectedTime = generateTimeSlots()[0];
                              selectedTimeIndex = 0;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  if (pickupOption == 'Terjadwal') ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Pilih Tanggal',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nextThreeDays.length,
                        itemBuilder: (context, index) {
                          final day = nextThreeDays[index];
                          final label = formatDate(day);
                          final isSelected = selectedDateIndex == index;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: buildCustomButton(label, isSelected, () {
                              setState(() {
                                selectedDateIndex = index;
                                selectedDate = nextThreeDays[index];
                              });
                            }),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Pilih Jam',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(generateTimeSlots().length - 1, (
                        index,
                      ) {
                        final start = generateTimeSlots()[index];
                        final end = generateTimeSlots()[index + 1];
                        final label =
                            '${start.format(context)} - ${end.format(context)}';
                        final isSelected = selectedTimeIndex == index;
                        return buildCustomButton(label, isSelected, () {
                          setState(() {
                            selectedTimeIndex = index;
                            selectedTime = start;
                          });
                        });
                      }),
                    ),
                  ],
                ],
              ),
            ),
          ),

          ...groupedByStore.entries.map((entry) {
            final storeAddress = entry.key;
            final medicines = entry.value;

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    const SizedBox(height: 15),
                    ...medicines.map((item) {
                      final quantity = cubit.getQuantity(item);
                      final priceStr = item.price.replaceAll(
                        RegExp(r'[^\d.]'),
                        '',
                      );
                      final price = double.tryParse(priceStr) ?? 0;
                      final totalItemPrice = price * quantity;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
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
                                  Text(
                                    '\$${totalItemPrice.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: lightColorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'x$quantity',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 80), // space untuk navbar bawah
        ],
      ),
    );
  }
}
