import 'package:finalproject/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/screens/orderanku_screen.dart';
import 'package:finalproject/widgets/profile/edit_profile.dart';
import 'package:finalproject/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:finalproject/currency.dart'; // path sesuai


class ProfileBody extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String profileImageUrl;

  const ProfileBody({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.profileImageUrl,
  });

  void _showCurrencyConversionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String? selectedCurrency;

        Widget buildCurrencyButton(String label) {
          final bool isSelected = selectedCurrency == label;
          return GestureDetector(
            onTap: () {
              selectedCurrency = label;
              // Update UI agar tombol bisa berubah warna
              (context as Element).markNeedsBuild();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? lightColorScheme.primary
                        : lightColorScheme.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : lightColorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Pilih Mata Uang Konversi',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCurrency = 'Won (KRW)';
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            selectedCurrency == 'Won (KRW)'
                                ? lightColorScheme.primary
                                : lightColorScheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Won (KRW)',
                        style: TextStyle(
                          color:
                              selectedCurrency == 'Won (KRW)'
                                  ? Colors.white
                                  : lightColorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCurrency = 'Dollar (USD)';
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            selectedCurrency == 'Dollar (USD)'
                                ? lightColorScheme.primary
                                : lightColorScheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Dollar (USD)',
                        style: TextStyle(
                          color:
                              selectedCurrency == 'Dollar (USD)'
                                  ? Colors.white
                                  : lightColorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCurrency = 'Yen (JPY)';
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            selectedCurrency == 'Yen (JPY)'
                                ? lightColorScheme.primary
                                : lightColorScheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Yen (JPY)',
                        style: TextStyle(
                          color:
                              selectedCurrency == 'Yen (JPY)'
                                  ? Colors.white
                                  : lightColorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.black45),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: lightColorScheme.primary, // warna hijau
              ),
              onPressed: () {
                if (selectedCurrency != null) {
                  double conversionRate = 1.0;

                  switch (selectedCurrency) {
                    case 'Won (KRW)':
                      conversionRate = 13.0; // contoh: 1 IDR = 13 KRW
                      break;
                    case 'Dollar (USD)':
                      conversionRate = 0.000065; // contoh: 1 IDR = 0.000065 USD
                      break;
                    case 'Yen (JPY)':
                      conversionRate = 0.0093; // contoh: 1 IDR = 0.0093 JPY
                      break;
                  }

                  // Provider.of<CurrencyProvider>(context, listen: false)
                  //     .updateCurrency(selectedCurrency!, conversionRate);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Konversi ke $selectedCurrency dipilih')),
                  );
                }
              },

              child: const Text(
                'Konfirmasi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 56,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset(
                profileImageUrl,
                fit: BoxFit.cover,
                width: 112,
                height: 112,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            userName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text(
            userEmail,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),

          const SizedBox(height: 15),

          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 140,
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const EditProfile(
                            initialName: '',
                            initialEmail: '',
                            initialProfileImage: '',
                          ),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: lightColorScheme.primary),
                ),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: lightColorScheme.primary),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          _buildMenuItem(
            context,
            imageAssetPath: 'assets/logo/belanja.png',
            label: 'Orderanku',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderankuScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          _buildMenuItem(
            context,
            imageAssetPath: 'assets/logo/waktu.png',
            label: 'Zona Waktu',
            subLabel: 'WIB (Waktu Indonesia Barat)',
            onTap: () {
              // TODO: Aksi ubah zona waktu
            },
          ),

          const SizedBox(height: 16),

          _buildMenuItem(
            context,
            imageAssetPath: 'assets/logo/uang.png',
            label: 'Konversi Mata Uang',
            subLabel: 'IDR (Rupiah)',
            onTap: () {
              _showCurrencyConversionDialog(context);
            },
          ),

          const SizedBox(height: 16),

          _buildMenuItem(
            context,
            imageAssetPath: 'assets/logo/logout.png',
            label: 'Logout',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String label,
    String? subLabel,
    Color? labelColor,
    String? imageAssetPath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            if (imageAssetPath != null)
              Image.asset(imageAssetPath, width: 50, height: 50)
            else
              const SizedBox(width: 50, height: 50),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: labelColor ?? Colors.black,
                    ),
                  ),
                  if (subLabel != null)
                    Text(
                      subLabel,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}