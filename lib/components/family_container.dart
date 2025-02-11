import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class FamilyContainer extends StatelessWidget {
  const FamilyContainer({super.key});

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
                CustomText(
                  text: 'Date time stamp, Topic',
                  color: Color.fromRGBO(119, 119, 121, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                CustomText(
                  text:
                      'How would you describe our \nfamily’s humour as if to a stranger?',
                  color: Color.fromRGBO(53, 49, 45, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/love_icon.svg'),
                    SizedBox(width: 8),
                    CustomText(
                      text: '112',
                      color: Color.fromRGBO(14, 13, 30, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
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
