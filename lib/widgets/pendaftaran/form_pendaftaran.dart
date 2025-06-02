import 'package:finalproject/widgets/pendaftaran/jam_pendaftaran.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/models/doctor_models.dart';
import 'package:finalproject/models/rumah_sakit_models.dart';
import 'package:finalproject/theme/theme.dart';

class PendaftaranBody extends StatefulWidget {
  final List<DoctorModel> allDoctors;
  final List<RumahSakitModel> allHospitals;

  const PendaftaranBody({
    super.key,
    required this.allDoctors,
    required this.allHospitals,
  });

  @override
  State<PendaftaranBody> createState() => _PendaftaranBodyState();
}

class _PendaftaranBodyState extends State<PendaftaranBody> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _complaintController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  RumahSakitModel? _selectedHospital;
  DoctorModel? _selectedDoctor;

  int _selectedGender = 0;
  int _selectedInsurance = 0;

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

  List<DoctorModel> get doctorsForSelectedHospital {
    if (_selectedHospital == null) return [];
    String hospitalId = _getHospitalId(_selectedHospital!);
    return widget.allDoctors
        .where((doc) => doc.hospitalId == hospitalId)
        .toList();
  }

  String _getHospitalId(RumahSakitModel hospital) {
    switch (hospital.name) {
      case 'RS Mitra Sehat':
        return 'rs1';
      case 'RS Harapan Bunda':
        return 'rs2';
      case 'RS Sentosa':
        return 'rs3';
      case 'RS Sejahtera':
        return 'rs4';
      default:
        return '';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Form Pendaftaran",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),

          // Dropdown Rumah Sakit
          DropdownButtonFormField<RumahSakitModel>(
            decoration: InputDecoration(
              labelText: 'Pilih Rumah Sakit',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            value: _selectedHospital,
            items:
                widget.allHospitals.map((hospital) {
                  return DropdownMenuItem(
                    value: hospital,
                    child: Text(hospital.name),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedHospital = value;
                _selectedDoctor = null; // reset dokter saat rumah sakit berubah
              });
            },
            validator: (value) => value == null ? 'Pilih rumah sakit' : null,
          ),

          const SizedBox(height: 16),

          // Dropdown Dokter (filtered)
          DropdownButtonFormField<DoctorModel>(
            decoration: InputDecoration(
              labelText: 'Pilih Dokter',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            value: _selectedDoctor,
            items:
                doctorsForSelectedHospital.map((doctor) {
                  return DropdownMenuItem(
                    value: doctor,
                    child: Text("Dr. ${doctor.name} - ${doctor.position}"),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedDoctor = value;
              });
            },
            validator: (value) => value == null ? 'Pilih dokter' : null,
          ),

          const SizedBox(height: 16),

          // Nama pasien
          TextField(
            controller: _patientNameController,
            decoration: InputDecoration(
              labelText: 'Nama Pasien',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Nomor Telepon
          TextField(
            controller: _contactNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Nomor Telepon',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Tanggal Lahir
          TextField(
            controller: _birthDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Tanggal Lahir',
              suffixIcon: const Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onTap: () => _selectBirthDate(context),
          ),

          const SizedBox(height: 16),

          // Jenis Kelamin
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

          // Jaminan
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

          // Keluhan
          TextField(
            controller: _complaintController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Keluhan',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // Validasi
                if (_selectedHospital == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pilih rumah sakit terlebih dahulu'),
                    ),
                  );
                  return;
                }
                if (_selectedDoctor == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pilih dokter terlebih dahulu'),
                    ),
                  );
                  return;
                }
                if (_patientNameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Masukkan nama pasien')),
                  );
                  return;
                }

                // Navigasi ke halaman JamPendaftaran
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => JamPendaftaran(
                          doctor: _selectedDoctor!,
                          onBack: () => Navigator.pop(context),
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightColorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
