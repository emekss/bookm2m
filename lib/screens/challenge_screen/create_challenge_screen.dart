import 'dart:io';

import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/models/users_model.dart';
import 'package:book_app_m2m/screens/challenge_screen/challenge_screen.dart';
import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/challenge/challenge_controller.dart';
import '../../api/users/user_controller.dart';

class CreateChallengeScreen extends ConsumerStatefulWidget {
  const CreateChallengeScreen({super.key});

  @override
  ConsumerState<CreateChallengeScreen> createState() =>
      _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends ConsumerState<CreateChallengeScreen> {
  String? selectedUser; // Store the selected topic name
  String? selectedUserId;

  List<String> selectedUserIds = [];

  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  File? _selectedImage;
  bool? isLoading;

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
    if (_selectedImage == null) {
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
      ref.read(challengeControllerProvider.notifier).createChallenge(
          context: context,
          file: _selectedImage!,
          title: title.text,
          description: desc.text,
          taggedUsers: selectedUserIds);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(usersControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          text: 'Create a challenge',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
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
                SizedBox(height: 40),
                GestureDetector(
                  onTap: _pickImage,
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
                              text: 'Upload image',
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(246, 246, 247, 1),
                  ),
                  padding: EdgeInsets.only(left: 10, bottom: 80),
                  child: TextField(
                    controller: desc,
                    scrollPadding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Challenge description',
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(246, 246, 247, 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    scrollPadding: EdgeInsets.zero,
                    controller: title,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
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
                          hintText: selectedUserIds.isNotEmpty
                              ? "${selectedUserIds.length} user seleted"
                              : 'Users',
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
                CustomButton(
                  buttonTitle:
                      userState is AsyncLoading ? 'Adding...' : 'Add Challenge',
                  onTap: () => userState is AsyncLoading ? null : submitForm(),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
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
