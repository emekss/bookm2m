import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/community/community_screen.dart';
import 'package:book_app_m2m/screens/home/home_screen.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/purchase/purchase_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

class MainTabview extends StatefulWidget {
  const MainTabview({super.key});

  @override
  State<MainTabview> createState() => _MainTabviewState();
}

class _MainTabviewState extends State<MainTabview> {
  int selectedTab = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const QuestionScreen(),
    const CommunityScreen(),
    const PurchaseScreen(),
    const ProfileScreen(),
  ];

  final List<Map<String, dynamic>> navItems = [
    {
      'icon': 'assets/icons/home_icon.svg',
      'activeIcon': 'assets/icons/home_active_icon.svg',
      'label': 'Home',
      'isJpg': false
    },
    {
      'icon': 'assets/icons/question_icon.png',
      'activeIcon': 'assets/icons/question_active_icon.png',
      'label': 'Questions',
      'isJpg': true
    },
    {
      'icon': 'assets/icons/community_icon.svg',
      'activeIcon': 'assets/icons/community_activeIcon.svg',
      'label': 'Community',
      'isJpg': false
    },
    {
      'icon': 'assets/icons/purchase_icon.png',
      'activeIcon': 'assets/icons/purchase_active_icon.png',
      'label': 'Purchases',
      'isJpg': true
    },
    {
      'icon': 'assets/icons/me_icon.svg',
      'activeIcon': 'assets/icons/profile_active_icon.svg',
      'label': 'Me',
      'isJpg': false
    },
  ];

  Widget _buildIcon(Map<String, dynamic> item, bool isSelected) {
    if (item['isJpg']) {
      return Image.asset(
        isSelected ? item['activeIcon'] : item['icon'],
        width: 22,
        height: 22,
      );
    } else {
      return SvgPicture.asset(
        isSelected ? item['activeIcon'] : item['icon'],
        width: 22,
        height: 22,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: screens[selectedTab],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 80.h,
        surfaceTintColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              navItems.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = index;
                  });
                },
                child: Container(
                  color: Colors.white,
                  height: 70.w,
                  width: 70.w,
                  child: Column(
                    children: [
                      _buildIcon(navItems[index], selectedTab == index),
                      const SizedBox(height: 8),
                      FittedBox(
                        child: CustomText(
                          text: navItems[index]['label']!,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: selectedTab == index
                              ? const Color.fromRGBO(41, 42, 44, 1)
                              : const Color.fromRGBO(119, 119, 121, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
