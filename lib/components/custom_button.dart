import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final Function() onTap;
  const CustomButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 47,
        padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(67, 184, 136, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: CustomText(
            text: buttonTitle,
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
