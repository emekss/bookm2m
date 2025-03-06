import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/questions/questions_controller.dart';

class QuestionsRow extends ConsumerStatefulWidget {
  const QuestionsRow({super.key});

  @override
  ConsumerState<QuestionsRow> createState() => _QuestionsRowState();
}

class _QuestionsRowState extends ConsumerState<QuestionsRow> {
  int selectedIndex = 0; // Default selection to 'All'
  final List<String> categories = [
    'All',
    'Parenting',
    'Educational',
    'Vocational'
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
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  // Call the filter function when a category is selected
                  ref
                      .read(questionsControllerProvider.notifier)
                      .filterQuestionsByTopic(categories[index]);
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
                        : const Color.fromRGBO(119, 119, 121, 1),
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
