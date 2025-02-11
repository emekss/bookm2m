import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/auth/verification_screen.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _obscureText = true;
  bool _obscurePasswordText = true;
  bool _isChecked = false;
  bool _isLoading = false;

//Controllers

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      print('Form validation failed');
      return;
    }

    if (!_isChecked) {
      _showErrorSnackBar('Please accept the Terms & Conditions to continue');
      print('Terms not accepted'); // Debug log
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorSnackBar('Passwords do not match');
      print('Password mismatch'); // Debug log
      return;
    }

    setState(() {
      _isLoading = true;
    });
    print('First Name: ${_firstNameController.text}');
    print('Last Name: ${_lastNameController.text}');
    print('Email: ${_emailController.text}');
    print(
        'Password: ${_passwordController.text}'); // Check if password is present
    print('Confirm Password: ${_confirmPasswordController.text}');

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      final result = await authService.signUp(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      print('SignUp API response: $result'); // Debug log

      if (result['success']) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              email: _emailController.text,
              verificationType: VerificationType.registration,
            ),
          ),
        );
      } else {
        // Handle specific error messages from the server
        String errorMessage = result['message'];
        if (errorMessage.contains('Please check your information')) {
          // Parse the specific validation errors
          final List<String> errors = errorMessage.split('\n');
          errorMessage =
              errors.first; // Show only the first error for simplicity
        }
        _showErrorSnackBar(errorMessage);
      }
    } catch (e) {
      print('SignUp error: $e'); // Debug log
      _showErrorSnackBar('Unable to create account. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
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
          // Logo and Create Account Text Section
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
                  SizedBox(height: media.height * 0.065),
                  CustomText(
                    text: 'Create an account',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: media.height * 0.01),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        CustomText(
                          text: 'Already have an account?',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          text: ' Sign in',
                          color: const Color.fromRGBO(67, 184, 136, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
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
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // First Name TextField
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(246, 246, 247, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            scrollPadding: EdgeInsets.zero,
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'First Name*',
                              hintStyle: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color.fromRGBO(110, 109, 121, 1),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: media.height * 0.02),
                        // Last Name TextField
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(246, 246, 247, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            scrollPadding: EdgeInsets.zero,
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last Name*',
                              hintStyle: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color.fromRGBO(110, 109, 121, 1),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: media.height * 0.02),
                        // Email TextField
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(246, 246, 247, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            scrollPadding: EdgeInsets.zero,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email*',
                              hintStyle: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color.fromRGBO(110, 109, 121, 1),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: media.height * 0.02),
                        // Password TextField
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(246, 246, 247, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            scrollPadding: EdgeInsets.zero,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password*',
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
                                  size: 20,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              // Add this to debug password changes
                              print('Password changed to: $value');
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: media.height * 0.02),
                        // Confirm Password TextField
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(246, 246, 247, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            scrollPadding: EdgeInsets.zero,
                            obscureText: _obscurePasswordText,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password*',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: media.height * 0.02),
                        // Terms and Conditions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: media.width * 0.05,
                              height: media.width * 0.05,
                              child: Checkbox(
                                value: _isChecked,
                                onChanged: _handleCheckboxChange,
                                activeColor:
                                    const Color.fromRGBO(67, 184, 136, 1),
                                side: WidgetStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                    width: 1.0,
                                    color: states.contains(WidgetState.selected)
                                        ? const Color.fromRGBO(67, 184, 136, 1)
                                        : const Color.fromRGBO(
                                            242, 242, 244, 1),
                                  ),
                                ),
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return const Color.fromRGBO(
                                          67, 184, 136, 1);
                                    }
                                    return const Color.fromRGBO(
                                        242, 242, 244, 1);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: media.width * 0.02),
                            CustomText(
                              text: 'I agree to the ',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(119, 119, 121, 1),
                            ),
                            CustomText(
                              text: 'Terms & Conditions',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(67, 184, 136, 1),
                            ),
                          ],
                        ),
                        SizedBox(height: media.height * 0.03),
                        // Create Account Button
                        CustomButton(
                          buttonTitle: _isLoading
                              ? 'Creating Account...'
                              : 'Create an account',
                          onTap: () {
                            if (!_isLoading) {
                              _handleSignUp();
                            }
                          },
                        ),
                      ],
                    ),
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
