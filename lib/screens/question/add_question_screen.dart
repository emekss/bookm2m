import 'package:book_app_m2m/api/questions/questions_controller.dart';
import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/assets/assets_screen.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/dashboard/dashboard_screen.dart';
import 'package:book_app_m2m/screens/family/build_family_screen.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/question/answer_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/topic/topic_controller.dart';
import '../../models/topic_model.dart';

class AddQuestionScreen extends ConsumerStatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  ConsumerState<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends ConsumerState<AddQuestionScreen> {
  String? selectedValue;
  bool isDropdownOpen = false;

  final TextEditingController prompt = TextEditingController();
  final TextEditingController help = TextEditingController();

  String? selectedTopic; // Store the selected topic name
  String? selectedTopicId;

  @override
  Widget build(BuildContext context) {
    final topicState = ref.watch(topicControllerProvider);
    final questionState = ref.watch(questionsControllerProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/icons/back_icon.svg'),
          ),
        ),
        centerTitle: false,
        title: const CustomText(
          text: 'Add Question',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  if (topicState is AsyncLoading) {
                    _showLoadingSnackBar(context);
                  } else if (topicState is AsyncError) {
                    _showErrorSnackBar(context, topicState.error.toString());
                  } else {
                    _showTopicSelection(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(246, 246, 247, 1),
                    ),
                    child: TextField(
                      scrollPadding: EdgeInsets.zero,
                      decoration: InputDecoration(
                        enabled: false,
                        border: InputBorder.none,
                        hintText: selectedTopic ?? 'Topic',
                        hintStyle: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(41, 42, 44, 0.61),
                        ),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color.fromRGBO(110, 109, 121, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromRGBO(246, 246, 247, 1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  scrollPadding: EdgeInsets.zero,
                  controller: prompt,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type Here',
                    hintStyle: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(41, 42, 44, 0.61),
                    ),
                    suffixIcon: SizedBox(
                      child: SvgPicture.asset(
                        'assets/icons/mic_icon.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromRGBO(246, 246, 247, 1),
                ),
                padding: EdgeInsets.only(left: 10, bottom: 80),
                child: TextField(
                  controller: help,
                  scrollPadding: EdgeInsets.zero,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Question Help',
                    hintStyle: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(41, 42, 44, 0.61),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomButton(
                buttonTitle:
                    questionState is AsyncLoading ? 'Adding...' : 'Add',
                onTap: () {
                  if (prompt.text.isEmpty) {
                    _showErrorSnackBar(context, 'enter a prompt');
                  } else if (help.text.isEmpty) {
                    _showErrorSnackBar(context, 'enter help');
                  } else if (selectedTopic == null) {
                    _showErrorSnackBar(
                        context, 'select a question from the dropdown');
                  } else {
                    ref
                        .read(questionsControllerProvider.notifier)
                        .createQuestion(
                            prompt: prompt.text.trim(),
                            help: help.text.trim(),
                            topicId: selectedTopicId!,
                            context: context);
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => QuestionScreen(),
                  //   ),
                  // );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showTopicSelection(BuildContext context) {
    final topicState = ref.read(topicControllerProvider);
    if (topicState is AsyncData) {
      List<TopicModel> topics = topicState.value!;

      showModalBottomSheet(
        context: context,
        builder: (context) {
          return topics.isEmpty
              ? Center(
                  child: Text('No topics found'),
                )
              : ListView.builder(
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    final topic = topics[index];
                    return ListTile(
                      title: Text(topic.name ?? "Unknown"),
                      onTap: () {
                        setState(() {
                          selectedTopic = topic.name; // Display in dropdown
                          selectedTopicId = topic.id; // Send this to backend
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                );
        },
      );
    }
  }

  void _showLoadingSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(width: 10),
            Text("Loading topics..."),
          ],
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $errorMessage"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
