import 'dart:io';

import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../api/topic/topic_controller.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';

class AddTopicScreen extends ConsumerStatefulWidget {
  const AddTopicScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTopicScreenState();
}

class _AddTopicScreenState extends ConsumerState<AddTopicScreen> {
  final TextEditingController topicNameController = TextEditingController();
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
    if (_selectedImage == null || topicNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a file and enter a topic name")),
      );
      return;
    }

    ref.read(topicControllerProvider.notifier).createTopic(
          context: context,
          file: _selectedImage!,
          name: topicNameController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final topicState = ref.watch(topicControllerProvider);
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
                      controller: topicNameController,
                      hintText: 'Topic Name',
                    ),
                    SizedBox(height: 60),
                    CustomButton(
                      buttonTitle: topicState is AsyncLoading
                          ? 'Creating Topic'
                          : 'Next',
                      onTap: () =>
                          topicState is AsyncLoading ? null : submitForm(),
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
}
