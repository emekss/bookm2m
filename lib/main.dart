import 'package:book_app_m2m/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'providers/auth_controller.dart';
import 'screens/auth/main_screen_loader.dart';
import 'screens/maintabview/main_tabview.dart';
import 'services/token_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenManager.getInstance(); // Ensure SharedPreferences is initialized

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: authState.when(
              data: (isAuthenticated) {
                print(isAuthenticated);
                return isAuthenticated ? MainTabview() : SplashScreen();
              },
              loading: () => const LoadingScreen(),
              error: (_, __) => SplashScreen()
              // Fallback
              ),
        );
      },
    );
  }
}
