import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(34.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 66,
                width: 66,
                child: Image.asset('assets/icons/success_icon.png')),
            SizedBox(height: 24),
            CustomText(
              textAlign: TextAlign.center,
              text:
                  'Verification Success, \nAccount has been created Successfully!',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 24),
            CustomButton(
              buttonTitle: 'Continue',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
