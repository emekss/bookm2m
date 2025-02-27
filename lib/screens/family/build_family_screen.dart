import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/components/family_container.dart';
import 'package:book_app_m2m/screens/assets/assets_screen.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/dashboard/dashboard_screen.dart';
import 'package:book_app_m2m/screens/family/view_members_screen.dart';
import 'package:book_app_m2m/screens/family/view_topics_screen.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/question/answer_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/family/family_controller.dart';

class BuildFamilyScreen extends ConsumerStatefulWidget {
  const BuildFamilyScreen({super.key});

  @override
  ConsumerState<BuildFamilyScreen> createState() => _BuildFamilyScreenState();
}

class _BuildFamilyScreenState extends ConsumerState<BuildFamilyScreen> {
  String? selectedValue;
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final familyState = ref.watch(familyControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/icons/back_icon.svg')),
        ),
        actions: [
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            color: Colors.white,
            onSelected: (String value) {
              switch (value) {
                case 'Dashboard':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()));
                  break;
                case 'Account':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                  break;
                case 'Family':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuildFamilyScreen()));
                  break;
                case 'Assets':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AssetsScreen()));
                  break;
                case 'Questions':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuestionScreen()));
                  break;
                case 'Answers':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AnswerScreen()));
                  break;
                case 'Books':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewBooksScreen()));
                  break;
                case 'Log out':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                  break;
              }
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset('assets/icons/menu_icon.svg'),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                value: 'Dashboard',
                child: CustomText(text: 'Dashboard'),
              ),
              const PopupMenuItem<String>(
                value: 'Account',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Account'),
              ),
              const PopupMenuItem<String>(
                value: 'Family',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Family'),
              ),
              const PopupMenuItem<String>(
                value: 'Assets',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Assets'),
              ),
              const PopupMenuItem<String>(
                value: 'Questions',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Questions'),
              ),
              const PopupMenuItem<String>(
                value: 'Answers',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Answers'),
              ),
              const PopupMenuItem<String>(
                value: 'Books',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Books'),
              ),
              const PopupMenuItem<String>(
                value: 'Log out',
                padding: EdgeInsets.only(left: 20, top: 10, right: 60),
                child: CustomText(text: 'Logout'),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/family.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 140.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Build your family',
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: media.height * 0.78,
              width: media.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ViewMembersScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 38,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          const Color.fromRGBO(67, 184, 136, 1),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        text: 'Members',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ViewtopicsScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 38,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:
                                          const Color.fromRGBO(67, 184, 136, 1),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        text: 'Topics',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 47,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(246, 246, 247, 1),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/search_icon.svg',
                                  fit: BoxFit.scaleDown,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    scrollPadding: EdgeInsets.zero,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search here',
                                      hintStyle: TextStyle(
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(41, 42, 44, 0.61),
                                      ),
                                    ),
                                    onChanged: (query) {
                                      ref
                                          .read(
                                              familyControllerProvider.notifier)
                                          .searchQuestions(query);
                                    },
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/filter_icon.svg',
                                  fit: BoxFit.scaleDown,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          familyState.when(
                            data: (families) => families.isEmpty
                                ? const Center(child: Text("No Family found"))
                                : ListView.builder(
                                    itemCount: families.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final family = families[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: SizedBox(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  height: 111,
                                                  width: 111,
                                                  child: Image.asset(
                                                      'assets/images/family_image.png')),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          height: 22,
                                                          width: 22,
                                                          child: family
                                                                      .profileImage !=
                                                                  null
                                                              ? Image.network(family
                                                                  .profileImage!)
                                                              : Image.asset(
                                                                  'assets/images/user.png')),
                                                      SizedBox(width: 8),
                                                      CustomText(
                                                        text:
                                                            '${family.fullName!}',
                                                        color: Color.fromRGBO(
                                                            14, 13, 30, 1),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                    ],
                                                  ),
                                                  CustomText(
                                                    text:
                                                        'Date time stamp, Topic',
                                                    color: Color.fromRGBO(
                                                        119, 119, 121, 1),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                  CustomText(
                                                    text:
                                                        family.relation!.name!,
                                                    color: Color.fromRGBO(
                                                        53, 49, 45, 1),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                  ),
                                                  SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/icons/love_icon.svg'),
                                                      SizedBox(width: 8),
                                                      CustomText(
                                                        text: '112',
                                                        color: Color.fromRGBO(
                                                            14, 13, 30, 1),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            loading: () => const Center(
                                child: CupertinoActivityIndicator()),
                            error: (e, _) => Center(child: Text("Error: $e")),
                          ),
                          const SizedBox(height: 34),
                        ],
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
