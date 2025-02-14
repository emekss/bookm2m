import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? enabled;
  final bool allowsOnlyNumber;

  const CustomTextfield({
    super.key,
    required this.hintText,
    this.controller,
    this.enabled,
    this.allowsOnlyNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromRGBO(246, 246, 247, 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        enabled: enabled,
        scrollPadding: EdgeInsets.zero,
        keyboardType: allowsOnlyNumber ? TextInputType.number : null,
        inputFormatters:
            allowsOnlyNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(110, 109, 121, 1),
          ),
        ),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
