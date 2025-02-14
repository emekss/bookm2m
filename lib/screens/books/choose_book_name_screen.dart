import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/books/choose_style_screen.dart';
import 'package:book_app_m2m/screens/books/widgets/question_card.dart';
import 'package:book_app_m2m/screens/question/add_question_screen.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class ChooseBookNameScreen extends StatefulWidget {
  final String bookTitle;
  final String bookDedication;
  final int bookVolume;
  final String bookImageUrl;

  const ChooseBookNameScreen({
    super.key,
    required this.bookTitle,
    required this.bookDedication,
    required this.bookVolume,
    required this.bookImageUrl,
  });

  @override
  State<ChooseBookNameScreen> createState() => _ChooseBookNameScreenState();
}

class _ChooseBookNameScreenState extends State<ChooseBookNameScreen> {
  bool _isChecked = false;

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          children: const [
                            CustomText(
                              text: 'Book Name',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        // Question Cards
                        QuestionCard(
                          topic: 'Question 1 | Topic',
                          question:
                              'How would you describe our family\'s humour as if to a stranger?',
                          isHighlighted: true,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(248, 249, 250, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                          height: 27,
                                          width: 27,
                                          child: Image.asset(
                                              'assets/images/user.png')),
                                      SizedBox(width: 10),
                                      CustomText(
                                        text: 'Tabish Bin Tahir',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            const Color.fromRGBO(41, 42, 44, 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 21,
                                    height: 21,
                                    child: Checkbox(
                                      value:
                                          _isChecked, // Use the state variable instead of hardcoded true
                                      onChanged: _handleCheckboxChange,
                                      activeColor:
                                          const Color.fromRGBO(67, 184, 136, 1),
                                      side: WidgetStateBorderSide.resolveWith(
                                        (states) => BorderSide(
                                          width: 1.0,
                                          color: states.contains(
                                                  WidgetState.selected)
                                              ? const Color.fromRGBO(
                                                  67, 184, 136, 1)
                                              : const Color.fromRGBO(
                                                  67, 184, 136, 1),
                                        ),
                                      ),
                                      fillColor: WidgetStateProperty
                                          .resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                          if (states
                                              .contains(WidgetState.selected)) {
                                            return const Color.fromRGBO(
                                                67, 184, 136, 1);
                                          }
                                          return const Color.fromRGBO(
                                              242, 242, 244, 1);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              CustomText(
                                text:
                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem psum has been the industry\'s standard dummy text ever since the 1500s,',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(119, 119, 121, 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        QuestionCard(
                          topic: 'Question 1 | Topic',
                          question:
                              'How would you describe our family\'s humour as if to a stranger?',
                        ),
                        const SizedBox(height: 16),
                        QuestionCard(
                          topic: 'Question 1 | Topic',
                          question:
                              'How would you describe our family\'s humour as if to a stranger?',
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      buttonTitle: 'Choose Style',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseStyleScreen(),
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
                              color: const Color.fromRGBO(67, 184, 136, 1)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: CustomText(
                            text: 'Save draft',
                            color: const Color.fromRGBO(67, 184, 136, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
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
