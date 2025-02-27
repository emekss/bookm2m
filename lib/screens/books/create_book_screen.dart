import 'dart:io';

import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/components/custom_textfield.dart';
import 'package:book_app_m2m/screens/books/choose_book_name_screen.dart';
import 'package:book_app_m2m/services/book_repo.dart';
import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/answer/answer_controller.dart';
import '../../api/book/book_controller.dart';
import '../../api/questions/questions_controller.dart';
import '../../models/answers.dart';
import '../../models/questions.dart';
import 'widgets/question_card.dart';

class CreateBookScreen extends ConsumerStatefulWidget {
  const CreateBookScreen({super.key});

  @override
  ConsumerState<CreateBookScreen> createState() => _CreateBookScreenState();
}

class _CreateBookScreenState extends ConsumerState<CreateBookScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dedicationController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  Uint8List? image;

  bool isLoading = false;

  @override
  void dispose() {
    titleController.dispose();
    dedicationController.dispose();
    volumeController.dispose();
    super.dispose();
  }

  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> submitForm() async {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please input a title")),
      );
    } else if (dedicationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please input a dedication")),
      );
    } else if (volumeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please input a volume number")),
      );
    } else {
      ref.read(bookControllerProvider.notifier).createBooks(
          context: context,
          title: titleController.text,
          dedication: dedicationController.text,
          coverImage: _selectedImage!,
          volumeNumber: int.parse(volumeController.text),
          questions: selectedQuestionsIds,
          answers: selectedAnswersIds);
    }
  }

  String? selectedQuestion; // Store the selected topic name
  List<String> selectedQuestionsIds = [];
  List<String> selectedAnswersIds = [];

  String? selectedAnswer; // Store the selected topic name
  String? selectedAnswerId;

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionsControllerProvider);
    final answerState = ref.watch(answerControllerProvider);
    final bookState = ref.watch(bookControllerProvider);
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
          text: 'Create a Book',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                    SizedBox(height: 60),
                    GestureDetector(
                      onTap: () => _pickImage(),
                      child: DashedRect(
                        gap: 8,
                        strokeWidth: 2,
                        color: Color.fromRGBO(67, 184, 136, 1),
                        child: Container(
                          height: 218,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(246, 246, 247, 1),
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset('assets/icons/upload.png'),
                                ),
                                CustomText(
                                  text: 'Upload cover',
                                  color: Color.fromRGBO(67, 184, 136, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextfield(
                      controller: titleController,
                      hintText: 'Book Title',
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        if (questionState is AsyncLoading) {
                          _showLoadingSnackBar(context);
                        } else if (questionState is AsyncError) {
                          _showErrorSnackBar(
                              context, questionState.error.toString());
                        } else {
                          _showQuestionSelection(
                              context,
                              titleController.text.isEmpty
                                  ? 'Book Name'
                                  : titleController.text);
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
                              hintText: selectedQuestionsIds.isNotEmpty
                                  ? '${selectedQuestionsIds.length} question(s) selected'
                                  : 'Questions',
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
                    InkWell(
                      onTap: () {
                        if (answerState is AsyncLoading) {
                          _showLoadingSnackBar(context);
                        } else if (answerState is AsyncError) {
                          _showErrorSnackBar(
                              context, answerState.error.toString());
                        } else {
                          _showAnsSelection(context);
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
                              hintText: selectedAnswersIds.isNotEmpty
                                  ? '${selectedAnswersIds.length} answer(s) selected'
                                  : 'Answers',
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
                    CustomTextfield(
                      controller: dedicationController,
                      hintText: 'Dedication of Name of Person',
                    ),
                    SizedBox(height: 20),
                    CustomTextfield(
                      controller: volumeController,
                      hintText: 'Volume Number',
                      allowsOnlyNumber: true,
                    ),
                    SizedBox(height: 60),
                    CustomButton(
                      buttonTitle: bookState is AsyncLoading
                          ? 'Creating book...'
                          : 'Create',
                      onTap: () => submitForm(),
                    )
                  ],
                ),
              ),
            ),
          ),
          isLoading == true
              ? Positioned.fill(
                  child: Container(
                    color: Colors.white.withAlpha(50),
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void _showQuestionSelection(BuildContext context, String bookName) {
    final questionState = ref.read(questionsControllerProvider);
    final TextEditingController _searchController = TextEditingController();
    final bool isSelected = false;

    if (questionState is AsyncData) {
      List<Questions> questions = questionState.value!;

      // Temporary list to store selected users during selection
      List<String> tempSelectedquestionIds = List.from(selectedQuestionsIds);

      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows full-screen modal
        builder: (context) {
          return StatefulBuilder(
            // Allows modal to update state
            builder: (context, setModalState) {
              return questions.isEmpty
                  ? const Center(child: Text('No questions found'))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: bookName,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(53, 49, 45, 1),
                                          ),
                                          SizedBox(height: 10),
                                          CustomText(
                                            text:
                                                'Choose between the questions below:',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(53, 49, 45, 1),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    height: 47,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                                color: Color.fromRGBO(
                                                    41, 42, 44, 0.61),
                                              ),
                                            ),
                                            onChanged: (query) {
                                              ref
                                                  .read(
                                                      questionsControllerProvider
                                                          .notifier)
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: 'Tap to select',
                                            fontWeight: FontWeight.bold,
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      // Question Cards
                                      ListView.builder(
                                        itemCount: questions.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final question = questions[index];
                                          final isSelected =
                                              tempSelectedquestionIds
                                                  .contains(question.id);

                                          return InkWell(
                                            onTap: () {
                                              setModalState(() {
                                                if (isSelected) {
                                                  tempSelectedquestionIds
                                                      .remove(question.id);
                                                } else {
                                                  tempSelectedquestionIds
                                                      .add(question.id!);
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: QuestionCard(
                                                topic:
                                                    'Question ${index + 1} | Topic',
                                                question: question.prompt ??
                                                    "Unknown",
                                                isHighlighted: isSelected,
                                                answerLength: question
                                                    .answers!.length
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                          // ListTile(
                                          //   title: Text(
                                          //     question.prompt ?? "Unknown",
                                          //     style: TextStyle(color: Colors.black),
                                          //   ),
                                          //   trailing: isSelected
                                          //       ? const Icon(Icons.check_circle,
                                          //           color: Colors.green)
                                          //       : const Icon(Icons.circle_outlined,
                                          //           color: Colors.grey),
                                          //   onTap: () {
                                          //     setModalState(() {
                                          //       if (isSelected) {
                                          //         tempSelectedquestionIds.remove(question.id);
                                          //       } else {
                                          //         tempSelectedquestionIds.add(question.id!);
                                          //       }
                                          //     });
                                          //   },
                                          // );
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedQuestionsIds =
                                            List.from(tempSelectedquestionIds);
                                      });
                                      print(tempSelectedquestionIds);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 47,
                                      padding: EdgeInsets.only(
                                          top: 13,
                                          bottom: 13,
                                          left: 10,
                                          right: 10),
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
                                          text: 'Save',
                                          color: const Color.fromRGBO(
                                              67, 184, 136, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 30),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       selectedQuestionsIds =
                        //           List.from(tempSelectedquestionIds);
                        //     });
                        //     Navigator.pop(context);
                        //   },
                        //   child: const Text("Confirm Selection"),
                        // ),
                      ],
                    );
            },
          );
        },
      );
    }
  }

  // void _showQuestioSelection(BuildContext context) {
  //   final answerState = ref.read(answerControllerProvider);

  //   if (answerState is AsyncData) {
  //     List<Answers> answers = answerState.value!;

  //     // Temporary list to store selected users during selection
  //     List<String> tempSelectedAnswerIds = List.from(selectedAnswersIds);

  //     showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true, // Allows full-screen modal
  //       builder: (context) {
  //         return StatefulBuilder(
  //           // Allows modal to update state
  //           builder: (context, setModalState) {
  //             return answers.isEmpty
  //                 ? const Center(child: Text('No Questions found'))
  //                 : Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             horizontal: 20, vertical: 10),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             SizedBox(height: 10),
  //                             Stack(
  //                               children: [
  //                                 Container(
  //                                   height: 13,
  //                                   decoration: BoxDecoration(
  //                                     color: Color.fromRGBO(248, 249, 250, 1),
  //                                     borderRadius: BorderRadius.circular(40),
  //                                   ),
  //                                 ),
  //                                 Container(
  //                                   height: 13,
  //                                   width: 89,
  //                                   decoration: BoxDecoration(
  //                                     color: Color.fromRGBO(67, 184, 136, 1),
  //                                     borderRadius: BorderRadius.circular(40),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             const SizedBox(height: 20),
  //                             Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Column(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       children: const [
  //                                         CustomText(
  //                                           text: 'Book Name',
  //                                           fontSize: 22,
  //                                           fontWeight: FontWeight.w500,
  //                                           color:
  //                                               Color.fromRGBO(53, 49, 45, 1),
  //                                         ),
  //                                         SizedBox(height: 10),
  //                                         CustomText(
  //                                           text:
  //                                               'Choose between the questions below:',
  //                                           fontSize: 17,
  //                                           fontWeight: FontWeight.w500,
  //                                           color:
  //                                               Color.fromRGBO(53, 49, 45, 1),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 const SizedBox(height: 24),
  //                                 Container(
  //                                   height: 47,
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 10),
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(8),
  //                                     color: Color.fromRGBO(246, 246, 247, 1),
  //                                   ),
  //                                   child: Row(
  //                                     children: [
  //                                       SvgPicture.asset(
  //                                         'assets/icons/search_icon.svg',
  //                                         fit: BoxFit.scaleDown,
  //                                       ),
  //                                       SizedBox(width: 10),
  //                                       Expanded(
  //                                         child: TextField(
  //                                           decoration: InputDecoration(
  //                                             border: InputBorder.none,
  //                                             hintText: 'Search here',
  //                                             hintStyle: TextStyle(
  //                                               fontFamily: 'PlusJakartaSans',
  //                                               fontSize: 15,
  //                                               fontWeight: FontWeight.w400,
  //                                               color: Color.fromRGBO(
  //                                                   41, 42, 44, 0.61),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       SvgPicture.asset(
  //                                         'assets/icons/filter_icon.svg',
  //                                         fit: BoxFit.scaleDown,
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     const SizedBox(height: 24),
  //                                     // Question Cards
  //                                     QuestionCard(
  //                                       topic: 'Question 1 | Topic',
  //                                       question:
  //                                           'How would you describe our family\'s humour as if to a stranger?',
  //                                       isHighlighted: true,
  //                                     ),
  //                                     const SizedBox(height: 16),
  //                                     Container(
  //                                       padding: const EdgeInsets.all(16),
  //                                       decoration: BoxDecoration(
  //                                         color: const Color.fromRGBO(
  //                                             248, 249, 250, 1),
  //                                         borderRadius:
  //                                             BorderRadius.circular(8),
  //                                       ),
  //                                       child: Column(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           Row(
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment
  //                                                     .spaceBetween,
  //                                             children: [
  //                                               Row(
  //                                                 children: [
  //                                                   SizedBox(
  //                                                       height: 27,
  //                                                       width: 27,
  //                                                       child: Image.asset(
  //                                                           'assets/images/user.png')),
  //                                                   SizedBox(width: 10),
  //                                                   CustomText(
  //                                                     text: 'Tabish Bin Tahir',
  //                                                     fontSize: 14,
  //                                                     fontWeight:
  //                                                         FontWeight.w500,
  //                                                     color:
  //                                                         const Color.fromRGBO(
  //                                                             41, 42, 44, 1),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                               // SizedBox(
  //                                               //   width: 21,
  //                                               //   height: 21,
  //                                               //   child: Checkbox(
  //                                               //     value:
  //                                               //         _isChecked, // Use the state variable instead of hardcoded true
  //                                               //     onChanged: _handleCheckboxChange,
  //                                               //     activeColor:
  //                                               //         const Color.fromRGBO(67, 184, 136, 1),
  //                                               //     side: WidgetStateBorderSide.resolveWith(
  //                                               //       (states) => BorderSide(
  //                                               //         width: 1.0,
  //                                               //         color: states.contains(
  //                                               //                 WidgetState.selected)
  //                                               //             ? const Color.fromRGBO(
  //                                               //                 67, 184, 136, 1)
  //                                               //             : const Color.fromRGBO(
  //                                               //                 67, 184, 136, 1),
  //                                               //       ),
  //                                               //     ),
  //                                               //     fillColor: WidgetStateProperty
  //                                               //         .resolveWith<Color>(
  //                                               //       (Set<WidgetState> states) {
  //                                               //         if (states
  //                                               //             .contains(WidgetState.selected)) {
  //                                               //           return const Color.fromRGBO(
  //                                               //               67, 184, 136, 1);
  //                                               //         }
  //                                               //         return const Color.fromRGBO(
  //                                               //             242, 242, 244, 1);
  //                                               //       },
  //                                               //     ),
  //                                               //   ),
  //                                               // ),
  //                                             ],
  //                                           ),
  //                                           SizedBox(height: 8),
  //                                           CustomText(
  //                                             text:
  //                                                 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem psum has been the industry\'s standard dummy text ever since the 1500s,',
  //                                             fontSize: 15,
  //                                             fontWeight: FontWeight.w400,
  //                                             color: const Color.fromRGBO(
  //                                                 119, 119, 121, 1),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     const SizedBox(height: 16),
  //                                     QuestionCard(
  //                                       topic: 'Question 1 | Topic',
  //                                       question:
  //                                           'How would you describe our family\'s humour as if to a stranger?',
  //                                     ),
  //                                     const SizedBox(height: 16),
  //                                     QuestionCard(
  //                                       topic: 'Question 1 | Topic',
  //                                       question:
  //                                           'How would you describe our family\'s humour as if to a stranger?',
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 30),
  //                                 CustomButton(
  //                                   buttonTitle: 'Choose Style',
  //                                   onTap: () {
  //                                     // Navigator.push(
  //                                     //   context,
  //                                     //   MaterialPageRoute(
  //                                     //     builder: (context) => ChooseStyleScreen(),
  //                                     //   ),
  //                                     // );
  //                                   },
  //                                 ),
  //                                 SizedBox(height: 20),
  //                                 GestureDetector(
  //                                   onTap: () {},
  //                                   child: Container(
  //                                     height: 47,
  //                                     padding: EdgeInsets.only(
  //                                         top: 13,
  //                                         bottom: 13,
  //                                         left: 10,
  //                                         right: 10),
  //                                     width: double.infinity,
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.white,
  //                                       border: Border.all(
  //                                           color: const Color.fromRGBO(
  //                                               67, 184, 136, 1)),
  //                                       borderRadius: BorderRadius.circular(8),
  //                                     ),
  //                                     child: Center(
  //                                       child: CustomText(
  //                                         text: 'Save draft',
  //                                         color: const Color.fromRGBO(
  //                                             67, 184, 136, 1),
  //                                         fontSize: 14,
  //                                         fontWeight: FontWeight.w400,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 SizedBox(height: 30),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       ListView.builder(
  //                         itemCount: answers.length,
  //                         shrinkWrap: true,
  //                         itemBuilder: (context, index) {
  //                           final answer = answers[index];
  //                           final isSelected =
  //                               tempSelectedAnswerIds.contains(answer.id);

  //                           return ListTile(
  //                             title: Text(
  //                               answer.prompt ?? "Unknown",
  //                               style: TextStyle(color: Colors.black),
  //                             ),
  //                             trailing: isSelected
  //                                 ? const Icon(Icons.check_circle,
  //                                     color: Colors.green)
  //                                 : const Icon(Icons.circle_outlined,
  //                                     color: Colors.grey),
  //                             onTap: () {
  //                               setModalState(() {
  //                                 if (isSelected) {
  //                                   tempSelectedAnswerIds.remove(answer.id);
  //                                 } else {
  //                                   tempSelectedAnswerIds.add(answer.id!);
  //                                 }
  //                               });
  //                             },
  //                           );
  //                         },
  //                       ),
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           setState(() {
  //                             selectedAnswersIds =
  //                                 List.from(tempSelectedAnswerIds);
  //                           });
  //                           Navigator.pop(context);
  //                         },
  //                         child: const Text("Confirm Selection"),
  //                       ),
  //                     ],
  //                   );
  //           },
  //         );
  //       },
  //     );
  //   }
  // }

  void _showAnsSelection(BuildContext context) {
    final answerState = ref.read(answerControllerProvider);

    if (answerState is AsyncData) {
      List<Answers> answers = answerState.value!;

      // Temporary list to store selected users during selection
      List<String> tempSelectedAnsIds = List.from(selectedAnswersIds);

      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows full-screen modal
        builder: (context) {
          return StatefulBuilder(
            // Allows modal to update state
            builder: (context, setModalState) {
              return answers.isEmpty
                  ? const Center(child: Text('No Answers found'))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          itemCount: answers.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final answer = answers[index];
                            final isSelected =
                                tempSelectedAnsIds.contains(answer.id);

                            return ListTile(
                              title: Text(
                                answer.prompt ?? "Unknown",
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: isSelected
                                  ? const Icon(Icons.check_circle,
                                      color: Colors.green)
                                  : const Icon(Icons.circle_outlined,
                                      color: Colors.grey),
                              onTap: () {
                                setModalState(() {
                                  if (isSelected) {
                                    tempSelectedAnsIds.remove(answer.id);
                                  } else {
                                    tempSelectedAnsIds.add(answer.id!);
                                  }
                                });
                              },
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedAnswersIds =
                                  List.from(tempSelectedAnsIds);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Confirm Selection"),
                        ),
                      ],
                    );
            },
          );
        },
      );
    }
  }

  void _showAnswerSelection(BuildContext context) {
    final answerState = ref.read(answerControllerProvider);
    if (answerState is AsyncData) {
      List<Answers> answers = answerState.value!;

      showModalBottomSheet(
        context: context,
        builder: (context) {
          return answers.isEmpty
              ? Center(
                  child: Text('No answers found'),
                )
              : ListView.builder(
                  itemCount: answers.length,
                  itemBuilder: (context, index) {
                    final answer = answers[index];
                    return ListTile(
                      title: Text(answer.prompt ?? "Unknown"),
                      onTap: () {
                        setState(() {
                          selectedAnswer = answer.prompt; // Display in dropdown
                          selectedAnswer = answer.id; // Send this to backend
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

  Future<String> _uploadImageAndGetUrl() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'https://acmosmalcaskczacsjmocsclkmcslc.com';
  }

  Future<void> _onNextPressed(BuildContext context) async {
    print(await context.read<BookRepo>().fetchAllBooks());

    if (titleController.text.isEmpty ||
        dedicationController.text.isEmpty ||
        volumeController.text.isEmpty ||
        image == null ||
        isLoading == true) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    final String imageUrl = await _uploadImageAndGetUrl();
    setState(() {
      isLoading = false;
    });

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChooseBookNameScreen(
            bookTitle: titleController.text,
            bookDedication: dedicationController.text,
            bookImageUrl: imageUrl,
            bookVolume: int.parse(volumeController.text),
          ),
        ),
      );
    }
  }
}
