import 'dart:ui';

import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CategoryBox extends StatelessWidget {
  final Map<String, dynamic> category;
  final VoidCallback onPressed;

  const CategoryBox({
    super.key,
    required this.category,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        height: 86,
        width: 101,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      category['icon']!,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: category['text']!,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
