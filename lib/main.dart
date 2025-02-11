import 'package:book_app_m2m/screens/splash_screen.dart';
import 'package:book_app_m2m/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = await AuthService.init();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => authService,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
