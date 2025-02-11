import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';

class OrderPageContainer extends StatelessWidget {
  final String title;
  final String detail;
  const OrderPageContainer({
    super.key,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(53, 49, 45, 1),
                ),
                SizedBox(height: 10),
                CustomText(
                  text: detail,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(119, 119, 121, 1),
                ),
              ],
            ),
            SizedBox(width: 40),
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 246, 247, 1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: Color.fromRGBO(67, 184, 136, 1), width: 2)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Divider(
          color: Color.fromRGBO(228, 228, 235, 1),
        ),
      ],
    );
  }
}
