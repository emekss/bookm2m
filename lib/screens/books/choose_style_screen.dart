import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/screens/books/book_cover_style_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:svg_flutter/svg.dart';

class ChooseStyleScreen extends StatefulWidget {
  const ChooseStyleScreen({super.key});

  @override
  State<ChooseStyleScreen> createState() => _ChooseStyleScreenState();
}

class _ChooseStyleScreenState extends State<ChooseStyleScreen> {
  int selectPage = 0;
  List bookArr = [
    {
      'image': 'assets/images/bookcover1.png',
    },
    {
      'image': 'assets/images/bookcover1.png',
    },
    {
      'image': 'assets/images/bookcover1.png',
    },
    {
      'image': 'assets/images/bookcover1.png',
    }
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
          text: 'Preview Book',
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
                      children: const [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Book Title Here',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Book Cover',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(53, 49, 45, 1),
                        ),
                        CustomText(
                          text: 'Choose Style',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(67, 184, 136, 1),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 350,
                        height: 247,
                        child: Image.asset(
                          'assets/images/book_cover.png',
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomText(
                      text: 'Book Interior',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(53, 49, 45, 1),
                    ),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: bookArr.length,
                        itemBuilder: (context, index) {
                          var pObj = bookArr[index] as Map? ?? {};
                          return SizedBox(
                              height: 218,
                              width: 271,
                              child: Image.asset(pObj['image'].toString()));
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: bookArr.map(
                        (e) {
                          var index = bookArr.indexOf(e);

                          return Container(
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 6,
                            decoration: BoxDecoration(
                              color: index == selectPage
                                  ? Color.fromRGBO(67, 184, 136, 1)
                                  : Color.fromRGBO(244, 244, 245, 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      buttonTitle: 'Order the Book',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookCoverStyleScreen(),
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
