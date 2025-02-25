import 'package:book_app_m2m/api/family/family_controller.dart';
import 'package:book_app_m2m/api/relationship/relationship_controller.dart';
import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../models/relationship.dart';

class AddFamilyScreen extends ConsumerStatefulWidget {
  const AddFamilyScreen({super.key});

  @override
  ConsumerState<AddFamilyScreen> createState() => _AddFamilyScreenState();
}

class _AddFamilyScreenState extends ConsumerState<AddFamilyScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();

  String? selectedRelationship; // Store the selected topic name
  String? selectedRelationshipId;

  DateTime? selectedDate;
  //final Dio dio = Dio(); // Initialize Dio for API calls

  /// Function to show Date Picker and format the selected date
  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  /// Convert Date to ISO 8601 format
  String formatToISO8601(DateTime date) {
    return date
        .toUtc()
        .toIso8601String(); // Converts to "2024-12-18T08:57:15.032Z"
  }

  Future<void> submitForm() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a name")),
      );
    } else if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your email")),
      );
    } else if (numberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a number")),
      );
    } else if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a date")),
      );
    } else {
      ref.read(familyControllerProvider.notifier).createFamily(
          context: context,
          fullName: nameController.text,
          phoneNumber: numberController.text,
          email: emailController.text,
          birthDate: formatToISO8601(selectedDate!),
          relationId: selectedRelationshipId!);

      // print(
      //     'fullname: ${nameController.text}, phoneNumber: ${numberController.text}, email: ${emailController.text}, birthDate: ${formatToISO8601(selectedDate!)}, relationId: ${selectedRelationshipId!}');
    }
  }

  /// Send the formatted date to the backend
  Future<void> updateUserBirthday(String userId) async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a date")),
      );
      return;
    }

    String formattedDate = formatToISO8601(selectedDate!);
    print("📅 Sending Birthday: $formattedDate");

    // try {
    //   final response = await dio.post(
    //     "https://yourapi.com/api/users/update-birthday",
    //     data: {
    //       "userId": userId,
    //       "birthday": formattedDate,
    //     },
    //   );

    //   print("✅ Birthday updated successfully: ${response.data}");
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Birthday updated successfully!")),
    //   );
    // } catch (e) {
    //   print("❌ Error updating birthday: $e");
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Error updating birthday")),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final relationshipState = ref.watch(relationshipControllerProvider);
    final familyState = ref.watch(familyControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Add Family',
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(53, 49, 45, 1),
                ),
                SizedBox(height: 40),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 119,
                        width: 119,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(248, 249, 250, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              SvgPicture.asset('assets/icons/person_icon.svg'),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/camera_icon.svg'),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                CustomTextfield(
                  hintText: 'Full Name',
                  controller: nameController,
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: 'tabish@m2m.com',
                  controller: emailController,
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  hintText: '+12345678901',
                  controller: numberController,
                ),
                SizedBox(height: 20),
                InkWell(
                    onTap: () {
                      if (relationshipState is AsyncLoading) {
                        _showLoadingSnackBar(context);
                      } else if (relationshipState is AsyncError) {
                        _showErrorSnackBar(
                            context, relationshipState.error.toString());
                      } else {
                        _showRelationshipSelection(context);
                      }
                    },
                    child: CustomTextfield(
                      hintText: selectedRelationship != null
                          ? selectedRelationship!
                          : 'Relation',
                      enabled: false,
                    )),
                SizedBox(height: 20),
                InkWell(
                    onTap: () => selectDate(context),
                    child: CustomTextfield(
                      hintText: selectedDate != null
                          ? selectedDate.toString()
                          : 'Birthday',
                      enabled: false,
                    )),
                SizedBox(height: 20),
                CustomButton(
                  buttonTitle: familyState is AsyncLoading
                      ? 'Adding Family...'
                      : 'Add Family',
                  onTap: () =>
                      familyState is AsyncLoading ? null : submitForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRelationshipSelection(BuildContext context) {
    final relationshipState = ref.read(relationshipControllerProvider);
    if (relationshipState is AsyncData) {
      List<Relationship> relationships = relationshipState.value!;

      showModalBottomSheet(
        context: context,
        builder: (context) {
          return relationships.isEmpty
              ? Center(
                  child: Text('No relationship found'),
                )
              : ListView.builder(
                  itemCount: relationships.length,
                  itemBuilder: (context, index) {
                    final relationship = relationships[index];
                    return ListTile(
                      title: Text(relationship.name ?? "Unknown"),
                      onTap: () {
                        setState(() {
                          selectedRelationship =
                              relationship.name; // Display in dropdown
                          selectedRelationshipId =
                              relationship.id; // Send this to backend
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
            Text("Loading relationships..."),
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
