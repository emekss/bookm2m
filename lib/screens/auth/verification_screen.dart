import 'dart:async';

import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/auth/verification_success_screen.dart';
import 'package:book_app_m2m/screens/auth/reset_password_screen.dart';
import 'package:book_app_m2m/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

enum VerificationType { registration, passwordReset }

class VerificationScreen extends StatefulWidget {
  final String email;
  final VerificationType verificationType;

  const VerificationScreen({
    required this.email,
    required this.verificationType,
    super.key,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _isLoading = false;

  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  void _verifyOTP() async {
    try {
      // Show loading indicator
      setState(() {
        _isLoading = true;
      });

      String otp = _otpControllers.map((controller) => controller.text).join();
      if (otp.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter the full OTP")),
        );
        return;
      }

      if (widget.verificationType == VerificationType.passwordReset) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(
              email: widget.email,
              otp: otp,
            ),
          ),
        );
        return;
      }

      final authService = Provider.of<AuthService>(context, listen: false);
      final result = await authService.verifyEmail(
        email: widget.email,
        otp: otp,
      );

      if (!mounted) return;

      if (result['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const VerificationSuccessScreen(),
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Verification failed'),
            backgroundColor: Colors.red,
          ),
        );

        // Clear OTP fields on error
        for (var controller in _otpControllers) {
          controller.clear();
        }
        FocusScope.of(context).requestFocus(FocusNode());
      }
    } catch (e) {
      print('Error during verification: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _canResend = false;
  int _timeLeft = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _canResend = false;
      _timeLeft = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _handleResendOTP() async {
    if (!_canResend) return;

    final authService = Provider.of<AuthService>(context, listen: false);
    final result = await authService.resendOtp(email: widget.email);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }

    if (result['success']) {
      _startTimer();
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset('assets/icons/back_icon.svg'),
                  ),
                  SizedBox(height: media.height * 0.06),
                  CustomText(
                    text: 'Verification Code',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: media.height * 0.01),
                  CustomText(
                    text: 'Enter the code sent to ${widget.email}',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return Container(
                          height: 62,
                          width: 51,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(244, 244, 244, 1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color.fromRGBO(231, 231, 232, 1),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: _otpControllers[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: media.height * 0.03),
                    CustomButton(
                        buttonTitle: 'Continue',
                        onTap: () {
                          _isLoading ? null : _verifyOTP();
                        }),
                    SizedBox(height: media.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Didn't get the code?",
                          color: const Color.fromRGBO(14, 13, 30, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        GestureDetector(
                          onTap: _canResend ? _handleResendOTP : null,
                          child: Row(
                            children: [
                              CustomText(
                                text: ' Resend',
                                color: _canResend
                                    ? const Color.fromRGBO(67, 185, 137, 1)
                                    : Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              if (!_canResend)
                                CustomText(
                                  text: ' (${_timeLeft}s)',
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
