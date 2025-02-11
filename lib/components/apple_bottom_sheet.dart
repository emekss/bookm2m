import 'package:book_app_m2m/screens/order/order_confirmed_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:svg_flutter/svg.dart';

class ApplePayBottomSheet extends StatelessWidget {
  final String bookTitle;
  final String price;
  final String email;
  final VoidCallback onCancel;

  const ApplePayBottomSheet({
    Key? key,
    required this.bookTitle,
    required this.price,
    required this.email,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(38, 38, 38, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Apple Pay',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: onCancel,
                    child: const CustomText(
                      text: 'Cancel',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 122, 255, 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // App Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/logo_icon.png'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        CustomText(
                          text: 'Gen12App',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        CustomText(
                          text: 'Your App — Description',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(125, 125, 125, 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Divider(
                color: Colors.white.withOpacity(0.12),
              ),
              const SizedBox(height: 10),
              // Details Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(-20, 5),
                          child: const _SectionHeader(title: 'DETAILS'),
                        ),
                        SizedBox(width: 10),
                        const CustomText(
                          text:
                              'For testing purposes only. You will not \nbe charged for confirming this \npurchase.',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    color: Colors.white.withOpacity(0.12),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: Offset(-30, 5),
                          child: const _SectionHeader(title: 'ACCOUNT'),
                        ),
                        SizedBox(width: 10),
                        Transform.translate(
                          offset: Offset(-13, 0),
                          child: CustomText(
                            text: email,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    color: Colors.white.withOpacity(0.12),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(0, 5),
                          child: const _SectionHeader(title: 'Item'),
                        ),
                        SizedBox(width: 20),
                        Transform.translate(
                          offset: Offset(8, 0),
                          child: CustomText(
                            text: bookTitle,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(0, 5),
                          child: const _SectionHeader(title: 'PRICE'),
                        ),
                        SizedBox(width: 10),
                        Transform.translate(
                          offset: Offset(8, 0),
                          child: CustomText(
                            text: '\$$price',
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Divider(
                color: Colors.white.withOpacity(0.12),
              ),
              const SizedBox(height: 10),

              // Confirmation UI
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderConfirmedScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset('assets/icons/apple_icon.svg'),
              ),
              const SizedBox(height: 8),
              const CustomText(
                text: 'Confirm with Side Button',
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CustomText(
        text: title,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: const Color.fromRGBO(151, 151, 151, 1),
      ),
    );
  }
}
