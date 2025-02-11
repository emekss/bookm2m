import 'package:flutter/material.dart';

class OrderPageIconTextfield extends StatelessWidget {
  final String hintText;
  const OrderPageIconTextfield({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        scrollPadding: EdgeInsets.zero,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(41, 42, 44, 0.61),
          ),
          suffixIcon: Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromRGBO(110, 109, 121, 1),
          ),
        ),
      ),
    );
  }
}
