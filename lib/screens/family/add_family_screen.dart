import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class AddFamilyScreen extends StatefulWidget {
  const AddFamilyScreen({super.key});

  @override
  State<AddFamilyScreen> createState() => _AddFamilyScreenState();
}

class _AddFamilyScreenState extends State<AddFamilyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Add Family',
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(53, 49, 45, 1),
              ),
              SizedBox(height: 40),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 119,
                      width: 119,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(248, 249, 250, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/icons/person_icon.svg'),
                      ),
                    ),
                    SvgPicture.asset('assets/icons/camera_icon.svg'),
                  ],
                ),
              ),
              SizedBox(height: 50),
              CustomTextfield(hintText: 'Full Name'),
              SizedBox(height: 20),
              CustomTextfield(hintText: 'tabish@m2m.com'),
              SizedBox(height: 20),
              CustomTextfield(hintText: '+12345678901'),
              SizedBox(height: 20),
              CustomTextfield(hintText: 'Relation'),
              SizedBox(height: 20),
              CustomTextfield(hintText: 'Birthday'),
              SizedBox(height: 20),
              CustomButton(
                buttonTitle: 'Add Family',
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
