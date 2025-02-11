import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/challenge_screen/challenge_screen.dart';
import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class CreateChallengeScreen extends StatefulWidget {
  const CreateChallengeScreen({super.key});

  @override
  State<CreateChallengeScreen> createState() => _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends State<CreateChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          text: 'Create a challenge',
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
              SizedBox(height: 40),
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
                          text: 'Upload image',
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromRGBO(246, 246, 247, 1),
                ),
                padding: EdgeInsets.only(left: 10, bottom: 80),
                child: TextField(
                  scrollPadding: EdgeInsets.zero,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Challenge description',
                    hintStyle: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(41, 42, 44, 0.61),
                    ),
                  ),
                ),
              ),
              Spacer(),
              CustomButton(
                buttonTitle: 'Add Challenge',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChallengeScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
