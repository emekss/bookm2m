import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class QuestionCard extends StatefulWidget {
  final String topic;
  final String question;
  final bool isHighlighted;

  const QuestionCard({
    super.key,
    required this.topic,
    required this.question,
    this.isHighlighted = false,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool _isCheckedMain = false;

  void _handleCheckboxChangeMain(bool? value) {
    setState(() {
      _isCheckedMain = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.isHighlighted ? Colors.white : Colors.white,
        border: Border.all(
          color: widget.isHighlighted
              ? const Color.fromRGBO(67, 184, 136, 1)
              : const Color.fromRGBO(233, 233, 233, 1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                  height: 27,
                  width: 27,
                  child: Image.asset('assets/images/user.png')),
              SizedBox(width: 10),
              CustomText(
                text: 'Tabish Bin Tahir',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(41, 42, 44, 1),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                fontStyle: FontStyle.italic,
                text: widget.topic,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(119, 119, 121, 1),
              ),
              SizedBox(
                width: 21,
                height: 21,
                child: Checkbox(
                  value:
                      _isCheckedMain, // Use the state variable instead of hardcoded true
                  onChanged: _handleCheckboxChangeMain,
                  activeColor: const Color.fromRGBO(67, 184, 136, 1),
                  side: WidgetStateBorderSide.resolveWith(
                    (states) => BorderSide(
                      width: 1.0,
                      color: states.contains(WidgetState.selected)
                          ? const Color.fromRGBO(67, 184, 136, 1)
                          : const Color.fromRGBO(67, 184, 136, 1),
                    ),
                  ),
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return const Color.fromRGBO(67, 184, 136, 1);
                      }
                      return const Color.fromRGBO(242, 242, 244, 1);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          CustomText(
            text: widget.question,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(53, 49, 45, 1),
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(67, 184, 136, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: CustomText(
                    text: 'Answer (23)',
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 247, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/share_icon.svg',
                      ),
                      SizedBox(width: 5),
                      CustomText(
                        text: 'Share',
                        fontSize: 14,
                        color: const Color.fromRGBO(67, 184, 136, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
