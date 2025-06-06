import 'package:finalproject/screens/diskon_screen.dart';
import 'package:finalproject/screens/medicine_store_screen.dart';
import 'package:finalproject/screens/profile_screen.dart';
import 'package:finalproject/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NavbarRoots extends StatefulWidget {
  const NavbarRoots({super.key});

  @override
  State<NavbarRoots> createState() => _NavbarRootsState();
}

class _NavbarRootsState extends State<NavbarRoots> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MedicineStoreScreen(),
    const ProfileScreen(),
    // Halaman lokasi
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIcon(IconData icon, int index) {
    final bool isActive = _selectedIndex == index;
    if (isActive) {
      return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: lightColorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 25),
      );
    } else {
      return Icon(icon, color: Colors.grey, size: 25);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: ClipRRect(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: SizedBox(
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: lightColorScheme.primary,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: _buildIcon(Ionicons.medkit, 2),
                  label: 'Obat',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(Ionicons.person, 3),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
