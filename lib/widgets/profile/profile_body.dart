import 'package:finalproject/screens/diskon_screen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/screens/welcome_screen.dart';
import 'package:finalproject/screens/orderanku_screen.dart';
import 'package:finalproject/widgets/profile/edit_profile.dart';
import 'package:finalproject/theme/theme.dart';

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

          // Menu Dapatkan Diskon
          _buildMenuItem(
            context,
            imageAssetPath:
                'assets/logo/uang.png', // Ganti dengan icon yang sesuai
            label: 'Dapatkan Diskon',
            onTap: () {
              // Arahkan ke halaman DiscountScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          const DiskonScreen(), // Menuju ke halaman diskon
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Menyisakan menu Orderanku dan Logout saja
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
