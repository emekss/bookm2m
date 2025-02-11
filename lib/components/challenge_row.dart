import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';

class ChallengeRow extends StatefulWidget {
  const ChallengeRow({super.key});

  @override
  State<ChallengeRow> createState() => _ChallengeRowState();
}

class _ChallengeRowState extends State<ChallengeRow> {
  int selectedIndex = 2;
  final List<String> categories = [
    'All',
    'Published',
    'Draft',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) {
            bool isSelected = selectedIndex == index;
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 0 : 10.0,
                right: index == categories.length - 1 ? 0 : 0,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isSelected
                        ? const Color.fromRGBO(67, 184, 136, 1)
                        : const Color.fromRGBO(246, 246, 247, 1),
                  ),
                  child: CustomText(
                    text: categories[index],
                    color: isSelected
                        ? Colors.white
                        : const Color.fromRGBO(67, 184, 136, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
