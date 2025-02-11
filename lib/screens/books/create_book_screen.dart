import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/components/custom_textfield.dart';
import 'package:book_app_m2m/screens/books/choose_book_name_screen.dart';
import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class CreateBookScreen extends StatefulWidget {
  const CreateBookScreen({super.key});

  @override
  State<CreateBookScreen> createState() => _CreateBookScreenState();
}

class _CreateBookScreenState extends State<CreateBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/icons/back_icon.svg'),
          ),
        ),
        centerTitle: false,
        title: const CustomText(
          text: 'Create a Book',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
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
              SizedBox(height: 60),
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
                          text: 'Upload cover',
                          color: Color.fromRGBO(67, 184, 136, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextfield(hintText: 'Book Title'),
              SizedBox(height: 20),
              CustomTextfield(hintText: 'Dedication of Name of Person'),
              SizedBox(height: 20),
              CustomTextfield(hintText: 'Volume Number'),
              SizedBox(height: 60),
              CustomButton(
                buttonTitle: 'Next',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseBookNameScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
