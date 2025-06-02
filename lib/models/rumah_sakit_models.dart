class RumahSakitModel {
  final String name;
  final String address;
  final String image;

  RumahSakitModel({
    required this.name,
    required this.address,
    required this.image,
  });
}

// Contoh data dummy rumah sakit
final List<RumahSakitModel> rumahSakitList = [
  RumahSakitModel(
    name: 'RS Mitra Sehat',
    address: 'Jl. Merdeka No. 123, Yogyakarta',
    image: 'assets/images/rumahsakit1.jpg',
  ),
  RumahSakitModel(
    name: 'RS Harapan Bunda',
    address: 'Jl. Sudirman No. 45, Jakarta',
    image: 'assets/images/rumahsakit2.jpg',
  ),
  RumahSakitModel(
    name: 'RS Sentosa',
    address: 'Jl. Diponegoro No. 78, Bandung',
    image: 'assets/images/rumahsakit3.jpg',
  ),
  RumahSakitModel(
    name: 'RS Sejahtera',
    address: 'Jl. Gatot Subroto No. 10, Surabaya',
    image: 'assets/images/rumahsakit1.jpg',
  ),
];
