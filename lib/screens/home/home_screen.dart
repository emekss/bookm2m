import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/assets/assets_screen.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/challenge_screen/challenge_screen.dart';
import 'package:book_app_m2m/screens/dashboard/dashboard_screen.dart';
import 'package:book_app_m2m/screens/family/build_family_screen.dart';
import 'package:book_app_m2m/screens/family/inspired_community_screen.dart';
import 'package:book_app_m2m/screens/home/components/book_section.dart';
import 'package:book_app_m2m/screens/home/widgets/category_box.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/question/answer_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/questions/questions_controller.dart';
import '../../api/topic/topic_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
    final topicState = ref.watch(topicControllerProvider);
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
                  // TODO: Implement actual logging out
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
                      return CategoryBox(
                        category: categories[index],
                        onPressed: () => _navigateToCategory(
                            context, categories[index]['route']),
                      );
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
                      const BookSection(),
                      const SizedBox(height: 40),
                      const CustomText(
                        text: 'Questions by topic',
                        color: Color.fromRGBO(41, 42, 44, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      topicState.when(
                          data: (data) {
                            return data.isEmpty
                                ? Text('No Questions')
                                : GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1,
                                      childAspectRatio: 2,
                                    ),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      final question = data[index];
                                      return Row(
                                        children: [
                                          SizedBox(
                                            height: 48,
                                            width: 48,
                                            child: question.coverImage !=
                                                        null &&
                                                    question.coverImage!.url !=
                                                        null
                                                ? Image.network(
                                                    question.coverImage!.url!)
                                                : Image.asset(
                                                    'assets/images/homeimage1.png',
                                                    width: 40,
                                                    height: 40,
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
                                                  text: question.name!,
                                                  color: const Color.fromRGBO(
                                                      53, 49, 45, 1),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                const SizedBox(height: 4),
                                                CustomText(
                                                  text: question
                                                      .count!.questions
                                                      .toString(),
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
                                  );
                            // ListView.builder(
                            //     itemCount: data.length,
                            //     shrinkWrap: true,
                            //     physics:
                            //         const NeverScrollableScrollPhysics(),
                            //     itemBuilder: (context, index) {
                            //       final question = data[index];
                            //       return Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 8.0),
                            //         child: Column(
                            //           children: [
                            //             Container(
                            //               padding:
                            //                   const EdgeInsets.all(20),
                            //               decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 border: Border.all(
                            //                     color: const Color
                            //                         .fromRGBO(
                            //                         67, 184, 136, 1)),
                            //                 borderRadius:
                            //                     BorderRadius.circular(
                            //                         8),
                            //               ),
                            //               child: Column(
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment
                            //                         .start,
                            //                 children: [
                            //                   CustomText(
                            //                     fontStyle:
                            //                         FontStyle.italic,
                            //                     text:
                            //                         'Question ${index + 1} / Topic',
                            //                     fontSize: 12,
                            //                     fontWeight:
                            //                         FontWeight.w400,
                            //                     color: const Color
                            //                         .fromRGBO(
                            //                         119, 119, 121, 1),
                            //                   ),
                            //                   const SizedBox(height: 4),
                            //                   CustomText(
                            //                     text:
                            //                         '${question.help}',
                            //                     fontSize: 15,
                            //                     fontWeight:
                            //                         FontWeight.w400,
                            //                     color: const Color
                            //                         .fromRGBO(
                            //                         53, 49, 45, 1),
                            //                   ),
                            //                   const SizedBox(
                            //                       height: 10),
                            //                   Row(
                            //                     children: [
                            //                       GestureDetector(
                            //                         onTap: () {
                            //                           Navigator.push(
                            //                             context,
                            //                             MaterialPageRoute(
                            //                               builder:
                            //                                   (context) =>
                            //                                       EditQuestionScreen(
                            //                                 topicId:
                            //                                     question
                            //                                         .topicId!,
                            //                                 prompt: question
                            //                                     .prompt!,
                            //                                 help: question
                            //                                     .help!,
                            //                                 questionId:
                            //                                     question
                            //                                         .id!,
                            //                               ),
                            //                             ),
                            //                           );
                            //                         },
                            //                         child: Container(
                            //                           padding:
                            //                               const EdgeInsets
                            //                                   .symmetric(
                            //                             horizontal: 16,
                            //                             vertical: 8,
                            //                           ),
                            //                           decoration:
                            //                               BoxDecoration(
                            //                             border:
                            //                                 Border.all(
                            //                               color: const Color
                            //                                   .fromRGBO(
                            //                                   67,
                            //                                   184,
                            //                                   136,
                            //                                   1),
                            //                             ),
                            //                             borderRadius:
                            //                                 BorderRadius
                            //                                     .circular(
                            //                                         30),
                            //                           ),
                            //                           child: Row(
                            //                             children: [
                            //                               SvgPicture.asset(
                            //                                   'assets/icons/edit_icon.svg'),
                            //                               SizedBox(
                            //                                   width: 4),
                            //                               const CustomText(
                            //                                 text:
                            //                                     'Edit',
                            //                                 fontSize:
                            //                                     14,
                            //                                 fontWeight:
                            //                                     FontWeight
                            //                                         .w400,
                            //                                 color: Color
                            //                                     .fromRGBO(
                            //                                         67,
                            //                                         184,
                            //                                         136,
                            //                                         1),
                            //                               ),
                            //                             ],
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       const SizedBox(
                            //                           width: 8),
                            //                       GestureDetector(
                            //                         onTap: () async {
                            //                           final shouldDelete =
                            //                               await showDialog<
                            //                                   bool>(
                            //                             context:
                            //                                 context,
                            //                             builder:
                            //                                 (context) {
                            //                               return AlertDialog(
                            //                                 title: Text(
                            //                                     "Confirm Delete"),
                            //                                 content: Text(
                            //                                     "Are you sure you want to delete this question?"),
                            //                                 actions: [
                            //                                   TextButton(
                            //                                     onPressed: () => Navigator.pop(
                            //                                         context,
                            //                                         false), // Cancel
                            //                                     child: Text(
                            //                                         "Cancel"),
                            //                                   ),
                            //                                   TextButton(
                            //                                     onPressed: () => Navigator.pop(
                            //                                         context,
                            //                                         true), // Confirm
                            //                                     child: Text(
                            //                                         "Delete",
                            //                                         style:
                            //                                             TextStyle(color: Colors.red)),
                            //                                   ),
                            //                                 ],
                            //                               );
                            //                             },
                            //                           );

                            //                           if (shouldDelete ==
                            //                               true) {
                            //                             final messenger =
                            //                                 ScaffoldMessenger.of(
                            //                                     context); // Store before pop
                            //                             final message = await ref
                            //                                 .read(questionsControllerProvider
                            //                                     .notifier)
                            //                                 .deleteQuestion(

                            //                                     question
                            //                                         .id!);

                            //                             messenger.showSnackBar(
                            //                                 SnackBar(
                            //                                     content:
                            //                                         Text(message)));
                            //                           }
                            //                         },
                            //                         child: Container(
                            //                           padding:
                            //                               const EdgeInsets
                            //                                   .symmetric(
                            //                             horizontal: 16,
                            //                             vertical: 8,
                            //                           ),
                            //                           decoration:
                            //                               BoxDecoration(
                            //                             color: Color
                            //                                 .fromRGBO(
                            //                                     251,
                            //                                     5,
                            //                                     108,
                            //                                     1),
                            //                             borderRadius:
                            //                                 BorderRadius
                            //                                     .circular(
                            //                                         30),
                            //                           ),
                            //                           child:
                            //                               const CustomText(
                            //                             text: 'Delete',
                            //                             fontSize: 14,
                            //                             fontWeight:
                            //                                 FontWeight
                            //                                     .w400,
                            //                             color: Colors
                            //                                 .white,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             SizedBox(height: 20),
                            //             CustomButton(
                            //                 buttonTitle: 'Add Answer',
                            //                 onTap: () {
                            //                   Navigator.push(
                            //                     context,
                            //                     MaterialPageRoute(
                            //                       builder: (context) =>
                            //                           AddAnswerScreen(
                            //                         question: question
                            //                             .prompt!,
                            //                         questionId:
                            //                             question.id!,
                            //                         userId: question
                            //                             .userId!,
                            //                       ),
                            //                     ),
                            //                   );
                            //                 }),
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   );
                          },
                          error: (error, st) =>
                              Center(child: Text("Error: $error")),
                          loading: () => const Center(
                              child: CupertinoActivityIndicator())),
                      // GridView.builder(
                      //   padding: EdgeInsets.zero,
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   gridDelegate:
                      //       const SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2,
                      //     crossAxisSpacing: 1,
                      //     mainAxisSpacing: 1,
                      //     childAspectRatio: 2,
                      //   ),
                      //   itemCount: questions.length,
                      //   itemBuilder: (context, index) {
                      //     final question = questions[index];
                      //     return Row(
                      //       children: [
                      //         SizedBox(
                      //           height: 48,
                      //           width: 48,
                      //           child: question['image']!.endsWith('.svg')
                      //               ? SvgPicture.asset(question['image']!)
                      //               : Image.asset(
                      //                   question['image']!,
                      //                   width: 40,
                      //                   height: 40,
                      //                 ),
                      //         ),
                      //         const SizedBox(width: 12),
                      //         Expanded(
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               CustomText(
                      //                 text: question['title']!,
                      //                 color:
                      //                     const Color.fromRGBO(53, 49, 45, 1),
                      //                 fontSize: 16,
                      //                 fontWeight: FontWeight.w400,
                      //               ),
                      //               const SizedBox(height: 4),
                      //               CustomText(
                      //                 text: question['author']!,
                      //                 color: const Color.fromRGBO(
                      //                     119, 119, 121, 1),
                      //                 fontSize: 12,
                      //                 fontWeight: FontWeight.w400,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),
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
}
