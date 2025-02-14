import 'package:book_app_m2m/screens/splash_screen.dart';
import 'package:book_app_m2m/services/auth_service.dart';
import 'package:book_app_m2m/services/book_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = await AuthService.init();
  final bookRepo = await BookRepo.init();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => authService),
        Provider<BookRepo>(create: (_) => bookRepo)
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return child!;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // home: MainTabview(),
      ),
    );
  }
}
