import 'package:book_app_m2m/models/relationship.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../api/family/family_controller.dart';
import '../../api/relationship/relationship_controller.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../assets/assets_screen.dart';
import '../auth/sign_in_screen.dart';
import '../books/view_books_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../profile/profile_screen.dart';
import '../question/answer_screen.dart';
import '../question/question_screen.dart';
import 'build_family_screen.dart';

class EditFamilyScreen extends ConsumerStatefulWidget {
  const EditFamilyScreen({super.key, required this.familyId});

  final String familyId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditFamilyScreenState();
}

class _EditFamilyScreenState extends ConsumerState<EditFamilyScreen> {
  String? selectedValue;
  bool isDropdownOpen = false;

  final TextEditingController prompt = TextEditingController();
  final TextEditingController help = TextEditingController();

  String? selectedTopic; // Store the selected topic name
  String? selectedTopicId;

  bool selectedStatus = true;

  @override
  Widget build(BuildContext context) {
    final relState = ref.watch(relationshipControllerProvider);
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
          text: 'Edit member',
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
                  if (relState is AsyncLoading) {
                    _showLoadingSnackBar(context);
                  } else if (relState is AsyncError) {
                    _showErrorSnackBar(context, relState.error.toString());
                  } else {
                    _showRelSelection(context);
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
                        hintText: selectedTopic ?? 'Relation',
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromRGBO(246, 246, 247, 1),
                ),
                child: DropdownButton<bool>(
                  value: selectedStatus,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromRGBO(110, 109, 121, 1),
                  ),
                  underline: SizedBox(),
                  items: [
                    DropdownMenuItem(
                        value: true,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          text: 'True',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromRGBO(53, 49, 45, 1),
                        )),
                    DropdownMenuItem(
                        value: false,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          text: 'False',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromRGBO(53, 49, 45, 1),
                        )),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedStatus = value;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              CustomButton(
                buttonTitle: relState is AsyncLoading ? 'Editing...' : 'Edit',
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
                        .read(familyControllerProvider.notifier).updateFamily(familyId: widget.familyId, relationId: selectedTopicId!, status: selectedStatus);
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

  void _showRelSelection(BuildContext context) {
    final relState = ref.read(relationshipControllerProvider);
    if (relState is AsyncData) {
      List<Relationship> rels = relState.value!;

      showModalBottomSheet(
        context: context,
        builder: (context) {
          return rels.isEmpty
              ? Center(
                  child: Text('No relations found'),
                )
              : ListView.builder(
                  itemCount: rels.length,
                  itemBuilder: (context, index) {
                    final rel = rels[index];
                    return ListTile(
                      title: Text(rel.name ?? "Unknown"),
                      onTap: () {
                        setState(() {
                          selectedTopic = rel.name; // Display in dropdown
                          selectedTopicId = rel.id; // Send this to backend
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
