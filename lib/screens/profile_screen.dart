import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:finalproject/widgets/profile/profile_body.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _userName;
  String? _userEmail;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data from SharedPreferences
  }

  // Fungsi untuk mengambil data pengguna dari SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _userName = prefs.getString('username') ?? 'No Name';
      _userEmail = prefs.getString('email') ?? 'No Email';
      _profileImageUrl = prefs.getString('profileImageUrl') ?? 'assets/images/default_profile.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      child: _userName == null || _userEmail == null
          ? const Center(child: CircularProgressIndicator()) // Menunggu data load
          : ProfileBody(
              userName: _userName!,
              userEmail: _userEmail!,
              profileImageUrl: _profileImageUrl!,
            ),
    );
  }
}

