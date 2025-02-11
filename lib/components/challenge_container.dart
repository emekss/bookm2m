import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';

class ChallengeContainer extends StatelessWidget {
  const ChallengeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        child: Row(
          children: [
            SizedBox(
                height: 111,
                width: 111,
                child: Image.asset('assets/images/family_image.png')),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: 22,
                        width: 22,
                        child: Image.asset('assets/images/user.png')),
                    SizedBox(width: 8),
                    CustomText(
                      text: 'Tabish bin tahir',
                      color: Color.fromRGBO(14, 13, 30, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ],
                ),
                SizedBox(height: 2),
                CustomText(
                  text: 'Challenge Details goes here \nand this is line two',
                  color: Color.fromRGBO(53, 49, 45, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    CustomText(
                      text: 'Tagged',
                      color: Color.fromRGBO(14, 13, 30, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 24,
                      width: 78,
                      child: Image.asset('assets/images/asset_imagesss.png'),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
