import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/components/family_member_cont.dart';
import 'package:book_app_m2m/screens/assets/assets_screen.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/dashboard/dashboard_screen.dart';
import 'package:book_app_m2m/screens/family/add_family_screen.dart';
import 'package:book_app_m2m/screens/family/build_family_screen.dart';
import 'package:book_app_m2m/screens/family/inspired_community_screen.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/question/answer_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/community/community_controller.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  // Your existing categories and questions lists remain the same
  final List<Map<String, String>> questions = [
    {
      'image': 'assets/images/homeimage1.png',
      'title': 'Parenting',
      'author': '30 Questions',
    },
    {
      'image': 'assets/images/home_voca.png',
      'title': 'Vocational',
      'author': '30 Questions',
    },
    {
      'image': 'assets/images/home_Edu.png',
      'title': 'Educational',
      'author': '30 Questions',
    },
    {
      'image': 'assets/images/homeimage1.png',
      'title': 'Parenting',
      'author': '30 Questions',
    },
  ];

  final List<Map<String, String>> popQuestion = [
    {
      'image': 'assets/images/parentbig.png',
      'title': 'Parenting',
      'author': '30 Questions',
    },
    {
      'image': 'assets/images/vocabig.png',
      'title': 'Vocational',
      'author': '30 Questions',
    },
    {
      'image': 'assets/images/parentbig.png',
      'title': 'Educational',
      'author': '30 Questions',
    },
    {
      'image': 'assets/images/vocabig.png',
      'title': 'Parenting',
      'author': '30 Questions',
    },
  ];
  final List<Map<String, String>> weekChall = [
    {
      'image': 'assets/images/weeklyimage.png',
      'title': 'Family Exploration',
      'author': 'Ask three family members',
    },
    {
      'image': 'assets/images/weeklyimage.png',
      'title': 'Mission Statement',
      'author': 'Create your own',
    },
    {
      'image': 'assets/images/weeklyimage.png',
      'title': 'Educational',
      'author': '10 Questions',
    },
  ];
  final List<Map<String, String>> categories = [
    {
      'icon': 'assets/icons/community_icon.svg',
      'text': 'Get inspired',
      'title': 'Community',
    },
    {
      'icon': 'assets/icons/community_icon.svg',
      'text': 'Inspire Others',
      'title': 'Community',
    },
    {
      'icon': 'assets/icons/love_svg.svg',
      'text': 'Add Family',
      'title': 'Family',
    },
    {
      'icon': 'assets/icons/love_svg.svg',
      'text': 'View Family',
      'title': 'Family',
    },
  ];

  String? selectedValue;
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final communityState = ref.watch(communityControllerProvider);
    var media = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: 393,
            child: Image.asset(
              'assets/images/family.png',
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 140.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Welcome to your community',
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          // Bottom Section
          Positioned(
            bottom: 0,
            child: Container(
              height: media.height * 0.655,
              width: media.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromRGBO(67, 184, 136, 1),
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Community',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromRGBO(67, 184, 136, 1),
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Family',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 113,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return _buildCategoryBox(categories[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: 'Get inspired by others',
                            color: Color.fromRGBO(41, 42, 44, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InspiredCommunityScreen(),
                                ),
                              );
                            },
                            child: const CustomText(
                              text: 'View',
                              color: Color.fromRGBO(69, 184, 136, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 282,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Container(
                                  height: 282,
                                  width: 219,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(228, 228, 235, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                          'assets/images/inspiredbig.png'),
                                      Positioned(
                                          top: 110,
                                          left: 18.61,
                                          child: SvgPicture.asset(
                                              'assets/icons/commun_icon.svg')),
                                      Positioned(
                                        top: 140,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.61),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 20),
                                              CustomText(
                                                text: 'Parenting Inspiration',
                                                color: Color.fromRGBO(
                                                    41, 42, 44, 1),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              const SizedBox(height: 8),
                                              CustomText(
                                                text:
                                                    'Question for every parent \nneeding help...',
                                                color: Color.fromRGBO(
                                                    41, 42, 44, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              const SizedBox(height: 14),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/icons/inspired_like.svg'),
                                                      SizedBox(width: 8),
                                                      CustomText(
                                                        text: ' 13 Likes',
                                                        color: Color.fromRGBO(
                                                            41, 42, 44, 1),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 20),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/icons/inspired_share.svg'),
                                                      SizedBox(width: 8),
                                                      CustomText(
                                                        text: '12 Shares',
                                                        color: Color.fromRGBO(
                                                            41, 42, 44, 1),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(height: 30),
                      const CustomText(
                        text: 'Questions by topic',
                        color: Color.fromRGBO(41, 42, 44, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 2,
                        ),
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          final question = questions[index];
                          return Row(
                            children: [
                              question['image']!.endsWith('.svg')
                                  ? SvgPicture.asset(question['image']!)
                                  : Image.asset(
                                      question['image']!,
                                      width: 40,
                                      height: 40,
                                    ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: question['title']!,
                                      color:
                                          const Color.fromRGBO(53, 49, 45, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    const SizedBox(height: 4),
                                    CustomText(
                                      text: question['author']!,
                                      color: const Color.fromRGBO(
                                          119, 119, 121, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                        text: 'Family Members',
                        color: Color.fromRGBO(53, 49, 51, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: FamilyMemberCont(
                              image: 'assets/icons/add_family_icon.svg',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddFamilyScreen(),
                                  ),
                                );
                              },
                              title: 'Add Family',
                              text:
                                  'Add family members and \nthen lag the questions you \nwant them to answer',
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: FamilyMemberCont(
                              image: 'assets/icons/view_family_icon.svg',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddFamilyScreen(),
                                  ),
                                );
                              },
                              title: 'View all Family',
                              text:
                                  'Check out all the family \nmembers you have added',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
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

  // ignore: unused_element
  Widget _buildBookCard(String title, String description) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 2,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 246, 247, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image.asset('assets/images/homebook1.png'),
          const SizedBox(height: 8),
          CustomText(
            text: title,
            color: const Color.fromRGBO(41, 42, 44, 1),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 8),
          CustomText(
            text: description,
            color: const Color.fromRGBO(119, 119, 121, 1),
            fontSize: 10,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBox(Map<String, String> category) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        height: 110,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(246, 246, 247, 1)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CustomText(
                      text: category['title']!,
                      color: const Color.fromRGBO(53, 49, 45, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  SvgPicture.asset(
                    category['icon']!,
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: CustomText(
                      text: category['text']!,
                      color: const Color.fromRGBO(119, 119, 121, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
