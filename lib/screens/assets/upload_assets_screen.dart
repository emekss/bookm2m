import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/assets/assets_screen.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/dashboard/dashboard_screen.dart';
import 'package:book_app_m2m/screens/family/build_family_screen.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/question/answer_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class UploadAssetsScreen extends StatefulWidget {
  const UploadAssetsScreen({super.key});

  @override
  State<UploadAssetsScreen> createState() => _UploadAssetsScreenState();
}

class _UploadAssetsScreenState extends State<UploadAssetsScreen> {
  String? selectedValue;
  bool isDropdownOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/icons/back_icon.svg')),
        ),
        actions: [
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            color: Colors.white,
            onSelected: (String value) {
              switch (value) {
                case 'Dashboard':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()));
                  break;
                case 'Account':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                  break;
                case 'Family':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuildFamilyScreen()));
                  break;
                case 'Assets':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AssetsScreen()));
                  break;
                case 'Questions':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuestionScreen()));
                  break;
                case 'Answers':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AnswerScreen()));
                  break;
                case 'Books':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewBooksScreen()));
                  break;
                case 'Log out':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                  break;
              }
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset('assets/icons/menu_icon.svg'),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                value: 'Dashboard',
                child: CustomText(text: 'Dashboard'),
              ),
              const PopupMenuItem<String>(
                value: 'Account',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Account'),
              ),
              const PopupMenuItem<String>(
                value: 'Family',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Family'),
              ),
              const PopupMenuItem<String>(
                value: 'Assets',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Assets'),
              ),
              const PopupMenuItem<String>(
                value: 'Questions',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Questions'),
              ),
              const PopupMenuItem<String>(
                value: 'Answers',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Answers'),
              ),
              const PopupMenuItem<String>(
                value: 'Books',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Books'),
              ),
              const PopupMenuItem<String>(
                value: 'Log out',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Logout'),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const CustomText(
          text: 'Upload Assets',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                DashedRect(
                  gap: 8,
                  strokeWidth: 2,
                  color: Color.fromRGBO(67, 184, 136, 1),
                  child: Container(
                    height: 218,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(246, 246, 247, 1),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.asset('assets/icons/upload.png'),
                          ),
                          CustomText(
                            text: 'Upload',
                            color: Color.fromRGBO(67, 184, 136, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 4),
                          CustomText(
                            text: '(Files/images)',
                            color: Color.fromRGBO(119, 119, 121, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(246, 246, 247, 1),
                  ),
                  child: TextField(
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(41, 42, 44, 0.61),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(246, 246, 247, 1),
                  ),
                  child: TextField(
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tag People',
                        hintStyle: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(41, 42, 44, 0.61),
                        ),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color.fromRGBO(110, 109, 121, 1),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(246, 246, 247, 1),
                  ),
                  child: TextField(
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type of Asset',
                        hintStyle: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(41, 42, 44, 0.61),
                        ),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color.fromRGBO(110, 109, 121, 1),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(246, 246, 247, 1),
                  ),
                  padding: EdgeInsets.only(left: 20, bottom: 80),
                  child: TextField(
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(41, 42, 44, 0.61),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(246, 246, 247, 1),
                  ),
                  child: TextField(
                    scrollPadding: EdgeInsets.zero,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type here or hold mic to speak',
                      hintStyle: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(41, 42, 44, 0.61),
                      ),
                      suffixIcon: SvgPicture.asset(
                        'assets/icons/mic_icon.svg',
                        height: 31,
                        width: 31,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomButton(
                  buttonTitle: 'Add',
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
