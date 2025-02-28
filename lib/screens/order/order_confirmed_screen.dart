import 'dart:io';

import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/order/order_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/book/book_controller.dart';
import '../../api/questions/questions_controller.dart';
import '../../models/questions.dart';

class OrderConfirmedScreen extends ConsumerStatefulWidget {
  const OrderConfirmedScreen(
      {super.key,
      required this.questionList,
      required this.bookTitle,
      required this.bookDedication,
      required this.coverImgId,
      required this.bookId,
      required this.bookVolume,
      required this.bookImage,
      this.editedImage});

  final List<Questions> questionList;
  final String bookTitle;
  final String bookDedication;
  final String coverImgId, bookId;
  final int bookVolume;
  final File bookImage;

  final String? editedImage;

  @override
  ConsumerState<OrderConfirmedScreen> createState() =>
      _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends ConsumerState<OrderConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    final bookState = ref.watch(bookControllerProvider);
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
                    buttonTitle: bookState is AsyncLoading
                        ? 'please wait..'
                        : 'Continue',
                    onTap: () {
                      if (widget.coverImgId != 'create') {
                        // print(
                        //     "bookId: ${widget.bookId} , title: ${widget.bookTitle}, dedication: ${widget.bookDedication}, coverImageId: ${widget.coverImgId}, volumeNumber: ${widget.bookVolume}, qlist: ${widget.questionList.map((e) => e.id!).toList()}, alist: ${widget.questionList.expand((question) => question.answers!.map((answer) => answer.id!)).toList()}");
                        ref
                            .read(bookControllerProvider.notifier)
                            .updateBooks(
                              context: context,
                              bookId: widget.bookId,
                              title: widget.bookTitle,
                              dedication: widget.bookDedication,
                              coverImageId: widget.coverImgId,
                              volumeNumber: widget.bookVolume,
                              status: "PUBLISHED",
                              questions: widget.questionList
                                  .map((e) => e.id!)
                                  .toList(),
                              answers: widget.questionList
                                  .expand((question) => question.answers!
                                      .map((answer) => answer.id!))
                                  .toList(),
                            )
                            .then((_) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderTrackingScreen(),
                                  ),
                                ));
                      } else {
                        ref
                            .read(bookControllerProvider.notifier)
                            .createBooks(
                              context: context,
                              title: widget.bookTitle,
                              dedication: widget.bookDedication,
                              coverImage: widget.bookImage,
                              volumeNumber: widget.bookVolume,
                              questions: widget.questionList
                                  .map((e) => e.id!)
                                  .toList(),
                              answers: widget.questionList
                                  .expand((question) => question.answers!
                                      .map((answer) => answer.id!))
                                  .toList(),
                            )
                            .then((_) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderTrackingScreen(),
                                  ),
                                ));
                      }
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
