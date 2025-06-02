import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/theme/theme.dart';
import 'package:finalproject/widgets/jadwal_konsul/hari_konsul.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class JadwalKonsulBody extends StatefulWidget {
  final DoctorModel doctor;
  const JadwalKonsulBody({super.key, required this.doctor});

  @override
  State<JadwalKonsulBody> createState() => _JadwalKonsulBodyState();
}

class _JadwalKonsulBodyState extends State<JadwalKonsulBody> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  int _selectedGender = 0;
  int _selectedInsurance = 0;
  int _currentStep = 0;

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: lightColorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
              surface: Colors.white,
            ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _birthDateController.text =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      });
    }
  }

  Widget _buildSelectableButton(
    String label,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color:
              selected
                  ? lightColorScheme.primary
                  : lightColorScheme.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : lightColorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    final doctor = widget.doctor;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 140,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 12, 13, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        doctor.profile,
                        width: 92,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 80),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doctor.position,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              ...List.generate(5, (starIndex) {
                                return Icon(
                                  Ionicons.star,
                                  size: 20,
                                  color:
                                      starIndex < doctor.averageReview
                                          ? Colors.amber
                                          : Colors.grey.shade300,
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Form Pendaftaran",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _patientNameController,
            decoration: InputDecoration(
              hintText: "Nama Pasien",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: lightColorScheme.primary,
                  width: 1,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _contactNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Nomor Telepon",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: lightColorScheme.primary,
                  width: 1,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _birthDateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Tanggal Lahir",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: const Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: lightColorScheme.primary,
                  width: 1,
                ),
              ),
            ),
            onTap: () => _selectBirthDate(context),
          ),

          const SizedBox(height: 16),

          const Text(
            "Jenis Kelamin",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              _buildSelectableButton(
                "Pria",
                _selectedGender == 0,
                () => setState(() => _selectedGender = 0),
              ),
              _buildSelectableButton(
                "Wanita",
                _selectedGender == 1,
                () => setState(() => _selectedGender = 1),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            "Jaminan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),

          const SizedBox(height: 8),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSelectableButton(
                  "BPJS",
                  _selectedInsurance == 0,
                  () => setState(() => _selectedInsurance = 0),
                ),
                _buildSelectableButton(
                  "Umum",
                  _selectedInsurance == 1,
                  () => setState(() => _selectedInsurance = 1),
                ),
                _buildSelectableButton(
                  "Asuransi",
                  _selectedInsurance == 2,
                  () => setState(() => _selectedInsurance = 2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _complaintController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Keluhan",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: lightColorScheme.primary,
                  width: 1,
                ),
              ),
            ),
          ),

          const SizedBox(height: 36),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentStep = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightColorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return HariKonsul(
          doctor: widget.doctor,
          onBack: () {
            setState(() {
              _currentStep = 0;
            });
          },
        );
      default:
        return Container();
    }
  }
}
