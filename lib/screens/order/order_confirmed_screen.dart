import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/order/order_tracking.dart';
import 'package:flutter/material.dart';

class OrderConfirmedScreen extends StatefulWidget {
  const OrderConfirmedScreen({super.key});

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(67, 184, 136, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 545,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                      height: 54.54,
                      width: 54.54,
                      child: Image.asset('assets/icons/success_icon.png')),
                  SizedBox(height: 16),
                  CustomText(
                    text: 'Order Confirmed',
                    fontSize: 21,
                    color: Color.fromRGBO(5, 33, 65, 1),
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    textAlign: TextAlign.center,
                    text: 'Your order has been confirmed \nsuccessfully.',
                    fontSize: 17,
                    color: Color.fromRGBO(52, 58, 69, 1),
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            textAlign: TextAlign.center,
                            text: 'Book Subtotal',
                            fontSize: 17,
                            color: Color.fromRGBO(119, 119, 121, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            textAlign: TextAlign.center,
                            text: '135.90 USD',
                            fontSize: 16,
                            color: Color.fromRGBO(53, 49, 45, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider()
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            textAlign: TextAlign.center,
                            text: 'Shipping & Handling',
                            fontSize: 17,
                            color: Color.fromRGBO(119, 119, 121, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            textAlign: TextAlign.center,
                            text: '149.90 USD',
                            fontSize: 16,
                            color: Color.fromRGBO(53, 49, 45, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider()
                    ],
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            textAlign: TextAlign.left,
                            text:
                                'Subtotal (Excluding tax and \napplicable fees)',
                            fontSize: 17,
                            color: Color.fromRGBO(119, 119, 121, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            textAlign: TextAlign.center,
                            text: '13.90 USD',
                            fontSize: 15,
                            color: Color.fromRGBO(53, 49, 45, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Divider()
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            textAlign: TextAlign.center,
                            text: 'Per print book',
                            fontSize: 17,
                            color: Color.fromRGBO(119, 119, 121, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            textAlign: TextAlign.center,
                            text: '\$13.42 USD',
                            fontSize: 22,
                            color: Color.fromRGBO(53, 49, 45, 1),
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    buttonTitle: 'Continue',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderTrackingScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
