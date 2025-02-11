import 'package:flutter/material.dart';

class OrderPageTextfield extends StatelessWidget {
  final String hintText;
  const OrderPageTextfield({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        scrollPadding: EdgeInsets.zero,
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
      ),
    );
  }
}
