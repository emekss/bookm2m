import 'package:book_app_m2m/components/apple_bottom_sheet.dart';
import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/components/order_double_container.dart';
import 'package:book_app_m2m/components/order_page_container.dart';
import 'package:book_app_m2m/components/order_page_icon_textfield.dart';
import 'package:book_app_m2m/components/order_page_textfield.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class OrderPageScreen extends StatefulWidget {
  const OrderPageScreen({super.key});

  @override
  State<OrderPageScreen> createState() => _OrderPageScreenState();
}

class _OrderPageScreenState extends State<OrderPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/icons/back_icon.svg')),
        ),
        title: const CustomText(
          text: 'Order Page',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      height: 13,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(248, 249, 250, 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    Container(
                      height: 13,
                      width: 89,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(67, 184, 136, 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Book Size',
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(53, 49, 45, 1),
                        ),
                        CustomText(
                          text: '125 pages',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(67, 184, 136, 1),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: 'US Trade 6x9 in/ 152 x 229 mm',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(119, 119, 121, 1),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: Color.fromRGBO(228, 228, 235, 1),
                ),
                SizedBox(height: 20),
                OrderPageContainer(
                    detail: 'Hardcover Case Wrap', title: 'Binding Type'),
                SizedBox(height: 20),
                OrderDoubleContainer(
                    title: 'Interior Color', detail: 'Hardcover Case Wrap'),
                SizedBox(height: 20),
                OrderPageContainer(
                    detail: '80# White - Coated', title: 'Paper Type'),
                SizedBox(height: 20),
                OrderDoubleContainer(
                    title: 'Cover Finish', detail: 'Glossy or Matte'),
                SizedBox(height: 30),
                Container(
                  height: 745,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.from(
                        alpha: 1, red: 0.965, green: 0.965, blue: 0.969),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CustomText(
                            text: 'Quantity & Shipping Estimates',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(53, 49, 45, 1),
                          ),
                        ),
                        SizedBox(height: 10),
                        OrderPageTextfield(hintText: 'Number of Copies'),
                        SizedBox(height: 10),
                        OrderPageTextfield(hintText: 'Destination Zipcode'),
                        SizedBox(height: 10),
                        OrderPageIconTextfield(hintText: 'Country'),
                        SizedBox(height: 10),
                        OrderPageIconTextfield(hintText: 'City'),
                        SizedBox(height: 10),
                        OrderPageIconTextfield(hintText: 'Shipping Method'),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CustomText(
                              text: 'Book Size',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(53, 49, 45, 1),
                            ),
                            SizedBox(height: 10),
                            CustomText(
                              text: '135.90 USD',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(119, 119, 121, 1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Color.fromRGBO(228, 228, 235, 1),
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CustomText(
                              text: 'Shipping & Handling',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(53, 49, 45, 1),
                            ),
                            SizedBox(height: 10),
                            CustomText(
                              text: '13.90 USD',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(119, 119, 121, 1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Color.fromRGBO(228, 228, 235, 1),
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CustomText(
                              text:
                                  'Subtotal(Excluding tax and applicable fees)',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(53, 49, 45, 1),
                            ),
                            SizedBox(height: 10),
                            CustomText(
                              text: '149.90 USD',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(119, 119, 121, 1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Color.fromRGBO(228, 228, 235, 1),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CustomText(
                              text: '\$13.42 USD',
                              fontSize: 29,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(53, 49, 45, 1),
                            ),
                            SizedBox(width: 10),
                            CustomText(
                              text: 'per print book',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(119, 119, 121, 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                CustomButton(
                    buttonTitle: 'Purchase Book',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ApplePayBottomSheet(
                          bookTitle: "Book Title goes here",
                          price: "13.42",
                          email: "subs@mail.com",
                          onCancel: () => Navigator.pop(context),
                        ),
                      );
                    }),
                SizedBox(height: 10),
                Center(
                  child: CustomText(
                    text: 'Save book without purchasing',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(119, 119, 121, 1),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
