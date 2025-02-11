import 'package:book_app_m2m/components/custom_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset('assets/icons/back_icon.svg'),
                ),
                SizedBox(height: 16),
                Center(
                  child: CustomText(
                    text: 'PRICING - UNITED STATES',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(41, 42, 44, 1),
                  ),
                ),
                SizedBox(height: 14),
                Center(
                  child: CustomText(
                    text: 'Legacy Plan',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(41, 42, 44, 1),
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: Container(
                    height: 631,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(67, 184, 136, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 32,
                            width: 185,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: Center(
                              child: CustomText(
                                text: 'START HERE (free trial)',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              CustomText(
                                text: '\$7.99',
                                color: Colors.white,
                                fontSize: 31,
                                fontWeight: FontWeight.w700,
                              ),
                              CustomText(
                                text: '/month',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            text: 'Available for 2 weeks',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            text:
                                'Take a walk through your past to pull out the pillars that will shape your loved one\'s future.',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          SizedBox(height: 20),
                          DottedLine(
                            dashColor: Colors.white.withOpacity(0.3),
                          ),
                          SizedBox(height: 20),
                          CustomText(
                            text: 'Origin Story Includes',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text: 'Weekly Legacy Questions(70+)',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text:
                                    'Access to digitally store your \nmemories',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text:
                                    'Send advice and gifts (triggered by \ndates)',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text:
                                    'Create Hardbound Book(extra cost \nto print)',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text:
                                    '300 GB of storage (more storage \navailable)',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 47,
                            width: 291,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: CustomText(
                                text: 'Buy Now',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(67, 184, 136, 1),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: Container(
                    height: 631,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 32,
                            width: 115,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: Center(
                              child: CustomText(
                                text: 'BUY BOOKS',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              CustomText(
                                text: '\$79.95',
                                color: Colors.white,
                                fontSize: 31,
                                fontWeight: FontWeight.w700,
                              ),
                              CustomText(
                                text: '/ month',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            text:
                                'Once subscribed to the monthly plan, answer our legacy questions and print them as books.',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          SizedBox(height: 20),
                          DottedLine(
                            dashColor: Colors.white.withOpacity(0.3),
                          ),
                          SizedBox(height: 20),
                          CustomText(
                            text: 'Hardbound Books Specs (unlimited)',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_black_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text: 'Hardbound Book/Full Color',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_black_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text: 'Size: 8.3 x 8.3 in',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_black_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text:
                                    'Paper: Mohawk Superfine Eggsgell \nUltrawhite',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_black_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text: 'Binding: Perfect bound',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/icons/price_black_icon.png'),
                              SizedBox(width: 8),
                              CustomText(
                                text: 'Up to 300 pages',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 47,
                            width: 291,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(67, 184, 136, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: CustomText(
                                text: 'Buy Now',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
