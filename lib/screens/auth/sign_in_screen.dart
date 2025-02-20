import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/auth/create_account_screen.dart';
import 'package:book_app_m2m/screens/auth/forgot_password_screen.dart';
import 'package:book_app_m2m/screens/maintabview/main_tabview.dart';
import 'package:book_app_m2m/screens/pricing/pricing_screen.dart';
import 'package:book_app_m2m/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/auth/auth_controller.dart';
// import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final authController = ref.read(authControllerProvider.notifier);
      authController.login(
          _emailController.text, _passwordController.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
          ),
        ),
      );
    });

    var media = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildHeader(context, media),
          _buildSignInForm(media, authState),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return SizedBox(
      height: 393,
      width: double.infinity,
      child: Image.asset(
        'assets/images/auth_bckgrnd.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Size media) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 63,
                width: 122,
                child: Image.asset(
                  'assets/images/auth_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: media.height * 0.06),
            CustomText(
              text: 'Sign in',
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: media.height * 0.01),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAccountScreen()),
              ),
              child: Row(
                children: [
                  CustomText(
                    text: 'New User?',
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    text: ' Create an account',
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
    );
  }

  Widget _buildSignInForm(Size media, AsyncValue<void> authState) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: media.height * 0.65,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildInputField(
                      controller: _emailController,
                      hintText: 'Email',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your email' : null,
                    ),
                    SizedBox(height: media.height * 0.02),
                    _buildInputField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: _obscureText,
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
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your password' : null,
                    ),
                  ],
                ),
              ),
              _buildForgotPassword(context),
              SizedBox(height: media.height * 0.03),
              _buildSignInButton(authState),
              _buildFooter(context, media),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 246, 247, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 15,
            color: Color.fromRGBO(110, 109, 121, 1),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
        ),
        child: CustomText(
          text: 'Forgot Password?',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color.fromRGBO(67, 184, 136, 1),
        ),
      ),
    );
  }

  Widget _buildSignInButton(AsyncValue<void> authState) {
    return CustomButton(
      buttonTitle: authState.isLoading ? 'Signing in...' : 'Sign in',
      onTap: authState.isLoading ? () {} : _login,
    );
  }

  Widget _buildFooter(BuildContext context, Size media) {
    return Padding(
      padding: EdgeInsets.only(bottom: media.height * 0.02),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PricingScreen()),
        ),
        child: CustomText(
          text: 'Pricing - Blog - About',
          fontSize: 14,
          color: const Color.fromRGBO(53, 49, 45, 1),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
