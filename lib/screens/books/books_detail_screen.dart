import 'package:book_app_m2m/screens/assets/assets_screen.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/dashboard/dashboard_screen.dart';
import 'package:book_app_m2m/screens/family/build_family_screen.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/question/answer_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/book/book_controller.dart';
import '../../models/books.dart';

class BooksDetailScreen extends ConsumerStatefulWidget {
  const BooksDetailScreen({super.key, required this.books});

  final Books books;

  @override
  ConsumerState<BooksDetailScreen> createState() => _BooksDetailScreenState();
}

class _BooksDetailScreenState extends ConsumerState<BooksDetailScreen> {
  String? selectedValue;
  bool isDropdownOpen = false;
  @override
  Widget build(BuildContext context) {
    final book = widget.books;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/icons/back_icon.svg'),
          ),
        ),
        centerTitle: false,
        title: const CustomText(
          text: 'Book Details',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    height: 272,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: book.coverImage != null
                            ? NetworkImage(book.coverImage!.url!)
                            : AssetImage('assets/images/book2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                            height: 210,
                            width: 168,
                            child: book.coverImage != null
                                ? Image.network(book.coverImage!.url!)
                                : Image.asset('assets/images/book2.png'))),
                  ),
                  Positioned(
                    top: 230,
                    right: 20,
                    child: Image.asset('assets/icons/love_icon.png'),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: book.title ?? 'Book Title',
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(53, 49, 45, 1),
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              text: book.dedication ?? 'Tabish bin Tahir',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(119, 119, 121, 1),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(67, 184, 136, 1),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Color.fromRGBO(67, 184, 136, 1),
                                    size: 15,
                                  ),
                                  SizedBox(width: 4),
                                  const CustomText(
                                    text: 'Edit',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(67, 184, 136, 1),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () async {
                                final shouldDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Confirm Delete"),
                                      content: Text(
                                          "Are you sure you want to delete this book?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context, false), // Cancel
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context, true), // Confirm
                                          child: Text("Delete",
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (shouldDelete == true) {
                                  final messenger = ScaffoldMessenger.of(
                                      context); // Store before pop
                                  final message = await ref
                                      .read(bookControllerProvider.notifier)
                                      .deleteBooks(book.id!);

                                  messenger.showSnackBar(
                                      SnackBar(content: Text(message)));
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(251, 5, 108, 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const CustomText(
                                  text: 'Delete',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Color.fromRGBO(226, 228, 242, 1),
                    height: 1,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Total Questions',
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                CustomText(
                                  text: book.questions != null
                                      ? book.questions!.length.toString()
                                      : '20',
                                  color: Color.fromRGBO(53, 49, 45, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Divider(
                              color: Color.fromRGBO(228, 228, 235, 1),
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Answered - Questions',
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                CustomText(
                                  text:
                                      // book.questions != null
                                      //     ? book.questions!
                                      //         .contains('answers') ? ''
                                      //     :
                                      '17',
                                  color: Color.fromRGBO(53, 49, 45, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Divider(
                              color: Color.fromRGBO(228, 228, 235, 1),
                            )
                          ],
                        ),
                        SizedBox(height: 6),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Unanswered - Questions',
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                CustomText(
                                  text: '0',
                                  color: Color.fromRGBO(53, 49, 45, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Divider(
                              color: Color.fromRGBO(228, 228, 235, 1),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(67, 184, 136, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_download_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                CustomText(
                                  text: 'Download PDF',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        const CustomText(
                          text: 'Description',
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(53, 49, 45, 1),
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          text: book.description ??
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem psum has been the industry\'s standard dummy text ever since the 1500s,',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(119, 119, 121, 1),
                        ),

                        const SizedBox(height: 24),
                        // Questions Section
                        const CustomText(
                          text: 'Questions',
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(53, 49, 45, 1),
                        ),
                        const SizedBox(height: 16),

                        ListView.builder(
                            itemCount: book.questions!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final question = book.questions![index];
                              return _buildQuestionCard(
                                'Question 1 | Topic',
                                question.prompt!,
                                question.answers!.length.toString(),
                                book.dedication ?? '',
                                isHighlighted: true,
                              );
                            }),

                        // Question Cards
                        // _buildQuestionCard(
                        //   'Question 1 | Topic',
                        //   'How would you describe our family\'s humour as if to a stranger?',
                        //   isHighlighted: true,
                        // ),

                        // const SizedBox(height: 16),
                        // _buildQuestionCard(
                        //   'Question 1 | Topic',
                        //   'How would you describe our family\'s humour as if to a stranger?',
                        //   isHighlighted: true,
                        // ),
                        // const SizedBox(height: 16),
                        // _buildQuestionCard(
                        //   'Question 1 | Topic',
                        //   'How would you describe our family\'s humour as if to a stranger?',
                        //   isHighlighted: true,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
      String topic, String question, String answers, String author,
      {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isHighlighted
              ? const Color.fromRGBO(67, 184, 136, 1)
              : const Color.fromRGBO(233, 233, 233, 1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                  height: 27,
                  width: 27,
                  child: Image.asset('assets/images/user.png')),
              SizedBox(width: 10),
              CustomText(
                text: author ?? 'Tabish Bin Tahir',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(41, 42, 44, 1),
              ),
            ],
          ),
          SizedBox(height: 8),
          CustomText(
            fontStyle: FontStyle.italic,
            text: topic,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(119, 119, 121, 1),
          ),
          const SizedBox(height: 4),
          CustomText(
            text: question,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(53, 49, 45, 1),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(67, 184, 136, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: CustomText(
                    text: 'Answer ($answers)',
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 247, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/share_icon.svg',
                      ),
                      SizedBox(width: 5),
                      CustomText(
                        text: 'Share',
                        fontSize: 14,
                        color: const Color.fromRGBO(67, 184, 136, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
