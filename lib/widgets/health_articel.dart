import 'package:flutter/material.dart';

class HealthArticel extends StatelessWidget {
  const HealthArticel({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = [
      {
        "title": "Tips for a Healthier Heart",
        "image": "assets/images/article1.jpeg",
      },
      {
        "title": "How to Manage Stress Effectively",
        "image": "assets/images/article2.jpg",
      },
    ];

    return Column(
      children:
          articles.map((article) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
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
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.asset(
                      article["image"]!,
                      width: 100,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      article["title"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
