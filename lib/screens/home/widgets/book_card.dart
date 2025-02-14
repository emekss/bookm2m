import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String description;
  const BookCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 252,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 246, 247, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 189,
            child: Image.asset('assets/images/homebook1.png'),
          ),
          const SizedBox(height: 12),
          CustomText(
            text: title,
            color: const Color.fromRGBO(41, 42, 44, 1),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 12),
          CustomText(
            text: description,
            color: const Color.fromRGBO(119, 119, 121, 1),
            fontSize: 10,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
