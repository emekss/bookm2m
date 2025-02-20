import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.8, end: 1.2),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Image.asset(
                'assets/icons/logo.png',
                fit: BoxFit.contain,
              ),
            );
          },
          onEnd: () => Future.delayed(const Duration(milliseconds: 500),
              () => Navigator.of(context).pop()),
        ),
      ),
    );
  }
}
