import 'package:book_app_m2m/screens/assets/assets_screen.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/dashboard/dashboard_screen.dart';
import 'package:book_app_m2m/screens/family/build_family_screen.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/question/answer_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/family/family_controller.dart';
import 'add_family_screen.dart';

class ViewMembersScreen extends ConsumerStatefulWidget {
  const ViewMembersScreen({super.key});

  @override
  ConsumerState<ViewMembersScreen> createState() => _ViewMembersScreenState();
}

class _ViewMembersScreenState extends ConsumerState<ViewMembersScreen> {
  final List<Map<String, String>> members = [
    {
      'image': 'assets/icons/person_icon.svg',
      'title': 'Tabish bin Tahir',
      'author': '10 posts',
    },
    {
      'image': 'assets/icons/person_icon.svg',
      'title': 'Tabish bin Tahir',
      'author': '10 posts',
    },
    {
      'image': 'assets/icons/person_icon.svg',
      'title': 'Tabish bin Tahir',
      'author': '10 posts',
    },
    {
      'image': 'assets/images/member_image.png',
      'title': 'Tabish bin Tahir',
      'author': '10 posts',
    },
    {
      'image': 'assets/images/member_image.png',
      'title': 'Tabish bin Tahir',
      'author': '10 posts',
    },
    {
      'image': 'assets/icons/person_icon.svg',
      'title': 'Tabish bin Tahir',
      'author': '10 posts',
    },
  ];

  String? selectedValue;
  bool isDropdownOpen = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final familyState = ref.watch(familyControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: const CircleBorder(),
        backgroundColor: const Color.fromRGBO(67, 184, 136, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFamilyScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
        centerTitle: false,
        title: const CustomText(
          text: 'Members',
          fontSize: 21,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Search Bar
              Container(
                height: 47,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(246, 246, 247, 1),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/search_icon.svg',
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        scrollPadding: EdgeInsets.zero,
                        decoration: const InputDecoration(
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
                              .read(familyControllerProvider.notifier)
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
              const SizedBox(height: 20),
              familyState.when(
                data: (families) => families.isEmpty
                    ? const Center(child: Text("No Family found"))
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: families.length,
                          itemBuilder: (context, index) {
                            final family = families[index];
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color.fromRGBO(233, 235, 247, 1),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // family.relative != null &&
                                  //         family.relative!.profileImage !=
                                  //             null &&
                                  //         family.relative!.profileImage!.url!
                                  //             .endsWith('.svg')
                                  //     ? Container(
                                  //         height: 100,
                                  //         width: 100,
                                  //         decoration: const BoxDecoration(
                                  //           shape: BoxShape.circle,
                                  //           color: Color.fromRGBO(
                                  //               248, 249, 250, 1),
                                  //         ),
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.all(14.0),
                                  //           child: SvgPicture.asset(family
                                  //               .relative!.profileImage!.url!),
                                  //         ),
                                  //       )
                                  //     : SizedBox(
                                  //         height: 100,
                                  //         width: 100,
                                  //         child: Image.asset(
                                  //           family.relative!.profileImage!.url!,
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  //       ),
                                  const SizedBox(height: 4),
                                  CustomText(
                                    text:
                                        "${family.relative!.firstName} ${family.relative!.lastName}",
                                    color: const Color.fromRGBO(53, 49, 45, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(height: 4),
                                  CustomText(
                                    text: '10 posts',
                                    color:
                                        const Color.fromRGBO(119, 119, 121, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                                67, 184, 136, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.edit_outlined,
                                              color: Color.fromRGBO(
                                                  67, 184, 136, 1),
                                              size: 15,
                                            ),
                                            SizedBox(width: 4),
                                            CustomText(
                                              text: 'Edit',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  67, 184, 136, 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              251, 5, 108, 1),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const CustomText(
                                          text: 'Remove',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                loading: () =>
                    const Center(child: CupertinoActivityIndicator()),
                error: (e, _) => Center(child: Text("Error: $e")),
              ),
              // Grid View
            ],
          ),
        ),
      ),
    );
  }
}
