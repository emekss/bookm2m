import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/maintabview/main_tabview.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(67, 184, 136, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 663,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomText(
                      text: 'Order #5913',
                      fontSize: 21,
                      color: Color.fromRGBO(5, 33, 65, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CustomText(
                      textAlign: TextAlign.center,
                      text: 'Your order has been confirmed \nsuccessfully.',
                      color: Color.fromRGBO(52, 58, 69, 1),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            textAlign: TextAlign.center,
                            text: 'Total Cost',
                            fontSize: 14,
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
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            textAlign: TextAlign.center,
                            text: 'Order Date',
                            fontSize: 14,
                            color: Color.fromRGBO(119, 119, 121, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          CustomText(
                            textAlign: TextAlign.center,
                            text: '14 Jan 2024, 15:43:22',
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
                            textAlign: TextAlign.center,
                            text: 'Address',
                            fontSize: 14,
                            color: Color.fromRGBO(119, 119, 121, 1),
                            fontWeight: FontWeight.w400,
                          ),
                          Column(
                            children: [
                              CustomText(
                                textAlign: TextAlign.center,
                                text: 'Address Line Goes here',
                                fontSize: 16,
                                color: Color.fromRGBO(53, 49, 45, 1),
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                textAlign: TextAlign.center,
                                text: 'Address Line Goes here',
                                fontSize: 16,
                                color: Color.fromRGBO(53, 49, 45, 1),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Divider()
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Order Tracking',
                        fontSize: 21,
                        color: Color.fromRGBO(5, 33, 65, 1),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 20),
                              SvgPicture.asset('assets/icons/orderdotgrey.svg'),
                              SvgPicture.asset('assets/icons/orderline.svg'),
                              SvgPicture.asset(
                                  'assets/icons/orderdotgreen.svg'),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  CustomText(
                                    textAlign: TextAlign.center,
                                    text: 'Product Shipped',
                                    fontSize: 16,
                                    color: Color.fromRGBO(53, 49, 45, 1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  CustomText(
                                    textAlign: TextAlign.center,
                                    text: '14 Jan 2024, 15:43:22',
                                    fontSize: 14,
                                    color: Color.fromRGBO(119, 119, 121, 1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  CustomText(
                                    textAlign: TextAlign.center,
                                    text: 'Product Packaging',
                                    fontSize: 16,
                                    color: Color.fromRGBO(67, 184, 136, 1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      CustomText(
                        textAlign: TextAlign.center,
                        text: '14 Jan 2024, 15:43:22',
                        fontSize: 14,
                        color: Color.fromRGBO(119, 119, 121, 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                      buttonTitle: 'Go Back',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainTabview(),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
