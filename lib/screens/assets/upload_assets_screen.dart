import 'dart:io';

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
import 'package:dashed_rect/dashed_rect.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/asset/asset_controller.dart';
import '../../api/users/user_controller.dart';
import '../../models/users_model.dart';

class UploadAssetsScreen extends ConsumerStatefulWidget {
  const UploadAssetsScreen({super.key});

  @override
  ConsumerState<UploadAssetsScreen> createState() => _UploadAssetsScreenState();
}

class _UploadAssetsScreenState extends ConsumerState<UploadAssetsScreen> {
  String? selectedUserId;

  List<String> selectedUserIds = [];
  String? selectedValue;
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  bool isDropdownOpen = false;

  File? _selectedFile;
  bool? isLoading;
  String? _fileExtension;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Allows selection of specific file types
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
        'doc',
        'docx',
        'txt'
      ], // Add more as needed
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      String fileName = result.files.single.name; // Gets file name
      String? fileExtension =
          result.files.single.extension; // Gets file extension

      setState(() {
        _selectedFile = File(filePath);
        _fileExtension = fileExtension; // Store the file extension
      });

      print("Picked File: $fileName");
      print("File Extension: $fileExtension");
    }
  }

  Future<void> submitForm() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a file")),
      );
    } else if (desc.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a description")),
      );
    } else if (title.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a title")),
      );
    } else if (selectedUserIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a user")),
      );
    } else {
      ref.read(assetControllerProvider.notifier).createAssets(
          context: context,
          file: _selectedFile!,
          description: desc.text,
          type: _fileExtension!,
          taggedUsers: selectedUserIds);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(usersControllerProvider);
    final assetState = ref.watch(assetControllerProvider);
    return Scaffold(
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
          text: 'Upload Assets',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickFile,
                  child: DashedRect(
                    gap: 8,
                    strokeWidth: 2,
                    color: Color.fromRGBO(67, 184, 136, 1),
                    child: Container(
                      height: 218,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 246, 247, 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _selectedFile != null
                                ? Row(
                                    children: [
                                      _getFileIcon(
                                          _fileExtension), // Show icon based on extension
                                      SizedBox(width: 10),
                                      Text(_selectedFile!.path
                                          .split('/')
                                          .last), // Show file name
                                    ],
                                  )
                                : SizedBox(
                                    height: 40,
                                    width: 40,
                                    child:
                                        Image.asset('assets/icons/upload.png'),
                                  ),
                            CustomText(
                              text: 'Upload',
                              color: Color.fromRGBO(67, 184, 136, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              text: '(Files/images)',
                              color: Color.fromRGBO(119, 119, 121, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(246, 246, 247, 1),
                  ),
                  child: TextField(
                    controller: title,
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(41, 42, 44, 0.61),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if (userState is AsyncLoading) {
                      _showLoadingSnackBar(context);
                    } else if (userState is AsyncError) {
                      _showErrorSnackBar(context, userState.error.toString());
                    } else {
                      _showUsersSelection(context);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(246, 246, 247, 1),
                    ),
                    child: TextField(
                      enabled: false,
                      scrollPadding: EdgeInsets.zero,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: selectedUserIds.isNotEmpty
                              ? '${selectedUserIds.length} users selected'
                              : 'Tag People',
                          hintStyle: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(41, 42, 44, 0.61),
                          ),
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Color.fromRGBO(110, 109, 121, 1),
                          )),
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     color: Color.fromRGBO(246, 246, 247, 1),
                //   ),
                //   child: TextField(
                //     scrollPadding: EdgeInsets.zero,
                //     decoration: InputDecoration(
                //         border: InputBorder.none,
                //         hintText: 'Type of Asset',
                //         hintStyle: TextStyle(
                //           fontFamily: 'PlusJakartaSans',
                //           fontSize: 15,
                //           fontWeight: FontWeight.w400,
                //           color: Color.fromRGBO(41, 42, 44, 0.61),
                //         ),
                //         suffixIcon: Icon(
                //           Icons.keyboard_arrow_down,
                //           color: Color.fromRGBO(110, 109, 121, 1),
                //         )),
                //   ),
                // ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(246, 246, 247, 1),
                  ),
                  padding: EdgeInsets.only(left: 20, bottom: 80),
                  child: TextField(
                    controller: desc,
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(41, 42, 44, 0.61),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                // Container(
                //   padding: EdgeInsets.only(left: 20, right: 20),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     color: Color.fromRGBO(246, 246, 247, 1),
                //   ),
                //   child: TextField(
                //     scrollPadding: EdgeInsets.zero,
                //     maxLines: 2,
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       hintText: 'Type here or hold mic to speak',
                //       hintStyle: TextStyle(
                //         fontFamily: 'PlusJakartaSans',
                //         fontSize: 15,
                //         fontWeight: FontWeight.w400,
                //         color: Color.fromRGBO(41, 42, 44, 0.61),
                //       ),
                //       suffixIcon: SvgPicture.asset(
                //         'assets/icons/mic_icon.svg',
                //         height: 31,
                //         width: 31,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                CustomButton(
                  buttonTitle: assetState is AsyncLoading ? 'Adding...' : 'Add',
                  onTap: () => assetState is AsyncLoading ? null : submitForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFileIcon(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icon(Icons.image, color: Colors.blue, size: 40);
      case 'pdf':
        return Icon(Icons.picture_as_pdf, color: Colors.red, size: 40);
      case 'doc':
      case 'docx':
        return Icon(Icons.description, color: Colors.blueAccent, size: 40);
      case 'txt':
        return Icon(Icons.text_snippet, color: Colors.grey, size: 40);
      default:
        return Icon(Icons.insert_drive_file, color: Colors.black, size: 40);
    }
  }

  void _showUsersSelection(BuildContext context) {
    final userState = ref.read(usersControllerProvider);

    if (userState is AsyncData) {
      List<UsersModel> users = userState.value!;

      // Temporary list to store selected users during selection
      List<String> tempSelectedUserIds = List.from(selectedUserIds);

      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows full-screen modal
        builder: (context) {
          return StatefulBuilder(
            // Allows modal to update state
            builder: (context, setModalState) {
              return users.isEmpty
                  ? const Center(child: Text('No users found'))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          itemCount: users.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            final isSelected =
                                tempSelectedUserIds.contains(user.id);

                            return ListTile(
                              title: Text(
                                user.firstName ?? "Unknown",
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
                                    tempSelectedUserIds.remove(user.id);
                                  } else {
                                    tempSelectedUserIds.add(user.id!);
                                  }
                                });
                              },
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedUserIds = List.from(tempSelectedUserIds);
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
