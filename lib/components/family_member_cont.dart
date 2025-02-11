import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class FamilyMemberCont extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  final String text;
  const FamilyMemberCont({
    super.key,
    required this.image,
    required this.onTap,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 146.21,
        decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 247, 1),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            SizedBox(height: 10),
            CustomText(
              text: title,
              color: Color.fromRGBO(53, 49, 51, 1),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10),
            CustomText(
              text: text,
              fontSize: 11,
              textAlign: TextAlign.center,
              color: Color.fromRGBO(119, 119, 121, 1),
              fontWeight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}
