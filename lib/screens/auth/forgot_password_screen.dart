import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/auth/verification_screen.dart';
import 'package:book_app_m2m/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _handleForgotPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      final result = await authService.forgotPassword(
        email: _emailController.text,
      );

      if (result['success']) {
        _showSuccessSnackBar(result['message']);
        // Navigate to verification screen with password reset type
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              email: _emailController.text,
              verificationType: VerificationType.passwordReset,
            ),
          ),
        );
      } else {
        _showErrorSnackBar(result['message']);
      }
    } catch (e) {
      print('Error during password reset request: $e');
      _showErrorSnackBar('An unexpected error occurred. Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: 393,
            width: double.infinity,
            child: Image.asset(
              'assets/images/auth_bckgrnd.png',
              fit: BoxFit.cover,
            ),
          ),
          // Back button and text section
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: media.height * 0.01,
                left: 24,
                right: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/back_icon.svg',
                    ),
                  ),
                  SizedBox(height: media.height * 0.06),
                  CustomText(
                    text: 'Forgot Password',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: media.height * 0.01),
                  CustomText(
                    text:
                        'Please enter your email or phone number to get reset password.',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
          // White Container
          Positioned(
            bottom: 0,
            child: Container(
              height: media.height * 0.66,
              width: media.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: media.width * 0.06,
                  vertical: media.height * 0.03,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email TextField
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(246, 246, 247, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          scrollPadding: EdgeInsets.zero,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'tabish@m2m.com',
                            hintStyle: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 15,
                              color: Color.fromRGBO(110, 109, 121, 1),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: media.height * 0.03),
                      // Send Reset Link Button
                      CustomButton(
                        buttonTitle:
                            _isLoading ? 'Sending...' : 'Send reset link',
                        onTap: () {
                          if (!_isLoading) {
                            _handleForgotPassword();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
