import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';

class AssetsPdfContainer extends StatelessWidget {
  const AssetsPdfContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 167,
              width: 167,
              decoration:
                  BoxDecoration(color: Color.fromRGBO(248, 249, 250, 1)),
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: SizedBox(
                  height: 72,
                  width: 72,
                  child: Image.asset(
                    'assets/images/Pdf.png',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                CustomText(
                  text: 'Image',
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(119, 119, 121, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                SizedBox(height: 6),
                CustomText(
                  text: 'Image Tile goes here',
                  color: Color.fromRGBO(53, 49, 45, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                SizedBox(height: 6),
                CustomText(
                  text: 'Download',
                  color: Color.fromRGBO(67, 184, 136, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                SizedBox(height: 6),
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
                        child: Image.asset('assets/images/asset_imagesss.png'))
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
