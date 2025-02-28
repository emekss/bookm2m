import 'dart:io';

import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/screens/order/order_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:svg_flutter/svg.dart';

import '../../models/questions.dart';

class BookCoverStyleScreen extends StatefulWidget {
  const BookCoverStyleScreen({super.key, required this.questionList, required this.bookTitle,
    required this.bookDedication,
    required this.bookVolume,
    required this.bookImage,});

  final List<Questions> questionList;
  final String bookTitle;
  final String bookDedication;
  final int bookVolume;
  final File bookImage;

  @override
  State<BookCoverStyleScreen> createState() => _BookCoverStyleScreenState();
}

class _BookCoverStyleScreenState extends State<BookCoverStyleScreen> {
  int selectPage = 0;
  List bookArr = [
    {
      'image': 'assets/images/bookstyle1.png',
      'title': 'Modern',
    },
    {
      'image': 'assets/images/bookstyle2.png',
      'title': 'Graceful',
    },
    {
      'image': 'assets/images/bookstyle1.png',
      'title': 'Timeless',
    },
  ];

  // Add list of colors
  final List<Color> coverColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
    Colors.brown,
    Colors.indigo,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SvgPicture.asset(
              'assets/icons/back_icon.svg',
            ),
          ),
        ),
        title: CustomText(
          text: 'Book Cover Style',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: '${widget.bookTitle}',
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
                    const SizedBox(height: 20),
                    Divider(
                      color: Color.fromRGBO(228, 228, 235, 1),
                    ),
                    const SizedBox(height: 20),
                    CustomText(
                      text: 'Choose Style',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(53, 49, 45, 1),
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: 'i.e. Modern, Graceful, Timeless',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(119, 119, 121, 1),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: bookArr.length,
                        itemBuilder: (context, index) {
                          var pObj = bookArr[index] as Map? ?? {};
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  height: 215,
                                  width: 159,
                                  child: Image.asset(
                                    pObj['image'].toString(),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomText(
                                text: pObj['title'].toString(),
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(119, 119, 121, 1),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    CustomText(
                      text: 'Choose Colour',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(53, 49, 45, 1),
                    ),
                    SizedBox(height: 8),
                    CustomText(
                      text: 'Cover',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(119, 119, 121, 1),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: coverColors.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 43,
                              width: 43,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: coverColors[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      buttonTitle: 'Preview Book',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPageScreen(
                              questionList: widget.questionList,
                              bookTitle: widget.bookTitle,
                              bookDedication: widget.bookDedication,
                              bookVolume: widget.bookVolume,
                              bookImage: widget.bookImage,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
