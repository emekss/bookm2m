import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/assets/assets_screen.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/books/create_book_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/challenge_screen/challenge_screen.dart';
import 'package:book_app_m2m/screens/dashboard/dashboard_screen.dart';
import 'package:book_app_m2m/screens/family/build_family_screen.dart';
import 'package:book_app_m2m/screens/family/inspired_community_screen.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/question/answer_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  final List<Map<String, dynamic>> categories = [
    {
      'icon': 'assets/icons/home_question.svg',
      'text': 'Questions',
      'image': 'assets/icons/questions_bg.png',
      'route': '/questions',
    },
    {
      'icon': 'assets/icons/challenge_icon.svg',
      'text': 'Challenges',
      'image': 'assets/icons/books_bg.png',
      'route': '/challenges',
    },
    {
      'icon': 'assets/icons/books_icons.svg',
      'text': 'Books',
      'image': 'assets/icons/family_bg.png',
      'route': '/books',
    },
    {
      'icon': 'assets/icons/assets_icon.svg',
      'text': 'Assets',
      'image': 'assets/icons/memories_bg.png',
      'route': '/assets',
    },
    {
      'icon': 'assets/icons/com_icon.svg',
      'text': 'Community',
      'image': 'assets/icons/legacy_bg.png',
      'route': '/community',
    },
    {
      'icon': 'assets/icons/fam_icon.svg',
      'text': 'Family',
      'image': 'assets/icons/stories_bg.png',
      'route': '/family',
    },
  ];

  void _navigateToCategory(BuildContext context, String route) {
    // You can replace these with your actual screen widgets
    switch (route) {
      case '/questions':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuestionScreen()));
        break;
      case '/challenges':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChallengeScreen()));
        break;
      case '/books':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewBooksScreen()));
        break;
      case '/assets':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AssetsScreen()));
        break;
      case '/community':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InspiredCommunityScreen()));
        break;
      case '/family':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BuildFamilyScreen()));
        break;
    }
  }

  String? selectedValue;
  bool isDropdownOpen = false;
  @override
  Widget build(BuildContext context) {
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
              'assets/images/auth_bckgrnd.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 95.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromRGBO(64, 184, 136, 1),
                  ),
                  child: const CustomText(
                    text: 'Daily Inspiration',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                const CustomText(
                  text: 'Spending Time with Family',
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 86,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return _buildCategoryBox(categories[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Bottom Section
          Positioned(
            bottom: 0,
            child: Container(
              height: media.height * 0.51,
              width: media.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/quotes_icon.svg'),
                          const SizedBox(width: 5),
                          const CustomText(
                            text: 'WILLIAM JAMES',
                            color: Color.fromRGBO(41, 42, 44, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: CustomText(
                          text:
                              '"The greatest purpose of life is to live it for \nsomething that last longer than you"',
                          color: Color.fromRGBO(41, 42, 44, 1),
                          fontSize: 15,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateBookScreen(),
                                  ),
                                );
                              },
                              child: _buildBookCard(
                                'Create a book',
                                'Make a book with your \nfavourite legacy questions or \ncreate your own',
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewBooksScreen(),
                                  ),
                                );
                              },
                              child: _buildBookCard(
                                'View All book',
                                'Check out all the family \nmembers you have added',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
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
                              SizedBox(
                                height: 48,
                                width: 48,
                                child: question['image']!.endsWith('.svg')
                                    ? SvgPicture.asset(question['image']!)
                                    : Image.asset(
                                        question['image']!,
                                        width: 40,
                                        height: 40,
                                      ),
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
                      const SizedBox(height: 40),
                      const CustomText(
                        text: 'Most Popular Questions',
                        color: Color.fromRGBO(41, 42, 44, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: popQuestion.length,
                          itemBuilder: (context, index) {
                            final popQuestions = popQuestion[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 81,
                                    width: 124,
                                    child:
                                        popQuestions['image']!.endsWith('.svg')
                                            ? SvgPicture.asset(
                                                popQuestions['image']!)
                                            : Image.asset(
                                                popQuestions['image']!,
                                                height: 81,
                                                width: 124,
                                              ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: popQuestions['title']!,
                                          color: const Color.fromRGBO(
                                              53, 49, 45, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const SizedBox(height: 4),
                                        CustomText(
                                          text: popQuestions['author']!,
                                          color: const Color.fromRGBO(
                                              119, 119, 121, 1),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CustomText(
                        text: 'Get inspired by others',
                        color: Color.fromRGBO(41, 42, 44, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 282,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 20),
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
                                      SizedBox(
                                        height: 131,
                                        width: 219,
                                        child: Image.asset(
                                            'assets/images/inspiredbig.png'),
                                      ),
                                      Positioned(
                                          top: 110,
                                          left: 18.61,
                                          child: SizedBox(
                                            height: 43,
                                            width: 43,
                                            child: Image.asset(
                                                'assets/images/inspireduser.png'),
                                          )),
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
                                                        text: 'Likes',
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
                                                        text: 'Shares',
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
                      const SizedBox(height: 40),
                      const CustomText(
                        text: 'Weekly Legacy Challenges',
                        color: Color.fromRGBO(41, 42, 44, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weekChall.length,
                          itemBuilder: (context, index) {
                            final weekChalls = weekChall[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 81,
                                    width: 152,
                                    child: weekChalls['image']!.endsWith('.svg')
                                        ? SvgPicture.asset(weekChalls['image']!)
                                        : Image.asset(
                                            weekChalls['image']!,
                                          ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: weekChalls['title']!,
                                          color: const Color.fromRGBO(
                                              53, 49, 45, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        CustomText(
                                          text: weekChalls['author']!,
                                          color: const Color.fromRGBO(
                                              119, 119, 121, 1),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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

  Widget _buildBookCard(String title, String description) {
    return Container(
      height: 252,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 246, 247, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 189,
            child: Image.asset('assets/images/homebook1.png'),
          ),
          const SizedBox(height: 12),
          CustomText(
            text: title,
            color: const Color.fromRGBO(41, 42, 44, 1),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 12),
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

  Widget _buildCategoryBox(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () => _navigateToCategory(context, category['route']),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        height: 86,
        width: 101,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      category['icon']!,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: category['text']!,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
