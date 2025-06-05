import 'dart:io';
import 'package:finalproject/theme/theme.dart';
import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key, required String initialName, required String initialEmail, required String initialProfileImage,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;

  bool agreePersonalData = true;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load data from SharedPreferences
  }

  // Fungsi untuk mengambil data pengguna dari SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String email = prefs.getString('email') ?? '';
    String profileImage = prefs.getString('profileImageUrl') ?? 'assets/images/leehan.jpg';

    _nameController = TextEditingController(text: username);
    _emailController = TextEditingController(text: email);
    setState(() {
      _pickedImage = File(profileImage); // Jika ada gambar, set gambar profile
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile != null) {
      setState(() {
        _pickedImage = File(imageFile.path);
      });
    }
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    if (!agreePersonalData) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the processing of personal data'),
        ),
      );
      return;
    }

    // Simpan data ke SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('profileImageUrl', _pickedImage?.path ?? 'assets/images/leehan.jpg');

    // Memuat ulang data pengguna setelah disimpan
    await _loadUserData();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil berhasil disimpan')));
    Navigator.pop(context); // kembali setelah simpan
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = _pickedImage != null
        ? CircleAvatar(
            radius: 56,
            backgroundImage: FileImage(_pickedImage!),
          )
        : CircleAvatar(
            radius: 56,
            backgroundImage: AssetImage('assets/images/default_profile.jpg'), // Default image jika tidak ada gambar
          );

    return CustomScaffold2(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Image.asset('assets/logo/back.png', width: 35, height: 35),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      imageWidget,
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: lightColorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    hintText: 'Enter Nama',
                    hintStyle: const TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter Email',
                    hintStyle: const TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightColorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Simpan', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
