import 'package:finalproject/widgets/scaffold/custom_scaffold2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/artikel_model.dart';

class ArtikelDetail extends StatelessWidget {
  final Article article;

  const ArtikelDetail({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMd().format(article.createdAt);

    return CustomScaffold2(
      appBar: AppBar(
        title: Text(
          article.title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Image.asset('assets/logo/back.png', width: 35, height: 35),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar artikel
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                article.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Tanggal artikel
            Text(
              formattedDate,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),

            // Judul artikel (bold)
            Text(
              article.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 16),

            // Isi artikel
            Text(
              article.content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
