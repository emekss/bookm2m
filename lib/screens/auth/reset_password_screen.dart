import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/auth/password_success_screen.dart';
import 'package:book_app_m2m/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscureText = true;
  bool _obscurePasswordText = true;
  bool _isLoading = false;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorSnackBar('Passwords do not match');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      final result = await authService.resetPassword(
        email: widget.email,
        otp: widget.otp,
        newPassword: _passwordController.text,
      );

      if (result['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PasswordSuccessScreen(),
          ),
        );
      } else {
        _showErrorSnackBar(result['message']);
      }
    } catch (e) {
      print('Error during password reset: $e');
      _showErrorSnackBar('An unexpected error occurred. Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                top: media.height * 0.0,
                left: 20,
                right: 20,
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
                  SizedBox(height: media.height * 0.07),
                  CustomText(
                    text: 'Reset Password',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  // SizedBox(height: media.height * 0.01),
                  // CustomText(
                  //   text: 'Please enter your new password',
                  //   color: Colors.white,
                  //   fontSize: 14,
                  //   fontWeight: FontWeight.w400,
                  // ),
                ],
              ),
            ),
          ),
          // White Container
          Positioned(
            bottom: 0,
            child: Container(
              height: media.height * 0.72,
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
                child: Column(
                  children: [
                    // New Password TextField
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 246, 247, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        scrollPadding: EdgeInsets.zero,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'New Password',
                          hintStyle: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 15,
                            color: Color.fromRGBO(110, 109, 121, 1),
                          ),
                          suffixIcon: IconButton(
                            onPressed: _togglePasswordVisibility,
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromRGBO(110, 109, 121, 1),
                              size: media.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: media.height * 0.02),
                    // Confirm New Password TextField
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 246, 247, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        scrollPadding: EdgeInsets.zero,
                        obscureText: _obscurePasswordText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm New Password',
                          hintStyle: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 15,
                            color: Color.fromRGBO(110, 109, 121, 1),
                          ),
                          suffixIcon: IconButton(
                            onPressed: _toggleConfirmPasswordVisibility,
                            icon: Icon(
                              _obscurePasswordText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromRGBO(110, 109, 121, 1),
                              size: media.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: media.height * 0.03),
                    // Reset Password Button
                    CustomButton(
                      buttonTitle:
                          _isLoading ? 'Resetting...' : 'Reset Password',
                      onTap: () {
                        if (!_isLoading) {
                          _handleResetPassword();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
