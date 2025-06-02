class DoctorModel {
  final String name;
  final String position;
  final int averageReview;
  final int totalReviews;
  final String profile;
  final String hospitalId; // tambah properti hospitalId

  DoctorModel({
    required this.name,
    required this.position,
    required this.averageReview,
    required this.totalReviews,
    required this.profile,
    required this.hospitalId,
  });
}

// Contoh data dokter dengan relasi ke rumah sakit melalui hospitalId
final List<DoctorModel> nearbyDoctors = [
  DoctorModel(
    name: "Luke Holland",
    position: "General Practitioner",
    averageReview: 0,
    totalReviews: 0,
    profile: "assets/images/doctor_1.jpg",
    hospitalId: "rs1", // misal RS Mitra Sehat
  ),
  DoctorModel(
    name: "Sophie Harmon",
    position: "General Practitioner",
    averageReview: 0,
    totalReviews: 0,
    profile: "assets/images/doctor_2.jpg",
    hospitalId: "rs2", // misal RS Harapan Bunda
  ),
  DoctorModel(
    name: "Louise Reid",
    position: "General Practitioner",
    averageReview: 2,
    totalReviews: 0,
    profile: "assets/images/doctor_3.jpg",
    hospitalId: "rs1", // misal RS Mitra Sehat
  ),
];
