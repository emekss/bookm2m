import 'dart:io';

import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/books/choose_style_screen.dart';
import 'package:book_app_m2m/screens/books/widgets/question_card.dart';
import 'package:book_app_m2m/screens/question/add_question_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/questions/questions_controller.dart';
import '../../models/books.dart';
import '../../models/questions.dart';

class AddEditBookNameScreen extends ConsumerStatefulWidget {
  final String bookTitle;
  final String bookDedication;
  final String coverImgId;
  final String bookId;
  final int bookVolume;
  final File bookImage;
  final List<Question> preselectedQuestions;

  final String? editedImage;

  const AddEditBookNameScreen(
      {super.key,
      required this.bookTitle,
      required this.bookDedication,
      required this.coverImgId,
      required this.bookId,
      required this.bookVolume,
      required this.bookImage,
      required this.preselectedQuestions,
      this.editedImage});

  @override
  ConsumerState<AddEditBookNameScreen> createState() =>
      _AddEditBookNameScreenState();
}

class _AddEditBookNameScreenState extends ConsumerState<AddEditBookNameScreen> {
  bool _isChecked = false;

  List<Questions> questionList = [];

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  final Set<int> _selectedIndexes = {};

  final TextEditingController _searchController = TextEditingController();
  late Set<int> selectedQuestionIds;

  @override
  Widget build(BuildContext context) {
    final questionState = ref.read(questionsControllerProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: CircleBorder(),
        backgroundColor: const Color.fromRGBO(67, 184, 136, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuestionScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
          text: 'Add Questions',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      height: 13,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(248, 249, 250, 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    Container(
                      height: 13,
                      width: 89,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(67, 184, 136, 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: '${widget.bookTitle}',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(53, 49, 45, 1),
                            ),
                            SizedBox(height: 10),
                            CustomText(
                              text: 'Choose between the questions below:',
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(53, 49, 45, 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
                              controller: _searchController,
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
                                    .read(questionsControllerProvider.notifier)
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
                    SizedBox(
                      height: 20,
                    ),
                    questionState.when(
                        data: (questions) {
                          return Column(
                            children: [
                              questions.isEmpty
                                  ? const Center(
                                      child: Text('No questions found'))
                                  : ListView.builder(
                                      itemCount: questions.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final question = questions[index];
                                        final isSelected =
                                            _selectedIndexes.contains(index);
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                _selectedIndexes.remove(index);
                                              } else {
                                                _selectedIndexes.add(index);
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: QuestionCard(
                                              topic:
                                                  'Question ${index + 1} | Topic',
                                              question:
                                                  question.prompt ?? "Unknown",
                                              isHighlighted: isSelected,
                                              answerLength: question
                                                  .answers!.length
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              SizedBox(height: 30),
                              CustomButton(
                                buttonTitle: 'Choose Style',
                                onTap: () {
                                  final selectedQuestions = _selectedIndexes
                                      .map((index) => questions[index])
                                      .toList();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChooseStyleScreen(
                                        questionList: selectedQuestions,
                                        bookTitle: widget.bookTitle,
                                        bookDedication: widget.bookDedication,
                                        coverImgId: widget.coverImgId,
                                        bookId: widget.bookId,
                                        bookVolume: widget.bookVolume,
                                        bookImage: widget.bookImage,
                                        networkImgUrl: widget.editedImage,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 47,
                                  padding: EdgeInsets.only(
                                      top: 13, bottom: 13, left: 10, right: 10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            67, 184, 136, 1)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: 'Save draft',
                                      color:
                                          const Color.fromRGBO(67, 184, 136, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          );
                        },
                        error: (error, st) => Text(error.toString()),
                        loading: () => const CupertinoActivityIndicator()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
