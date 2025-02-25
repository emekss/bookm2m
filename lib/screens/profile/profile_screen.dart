import 'package:book_app_m2m/components/custom_button.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/components/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/account/account_controller.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _obscurePasswordText = true;
  bool _isChecked = false;
  bool _isLoading = true;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(accountControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const CustomText(
          text: 'Account',
          fontSize: 23,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: accountState.when(
              data: (profile) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(14),
                                  height: 119,
                                  width: 119,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(248, 249, 250, 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/person_icon.svg',
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                    'assets/icons/camera_icon.svg'),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          CustomTextfield(
                            controller: _firstNameController,
                            hintText: 'First Name - ${profile.firstName}',
                            // enabled: !_isLoading,
                          ),
                          SizedBox(height: 20),
                          CustomTextfield(
                            controller: _lastNameController,
                            hintText: 'Last Name - ${profile.lastName}',
                            // enabled: !_isLoading,
                          ),
                          SizedBox(height: 20),
                          CustomTextfield(
                            controller: _emailController,
                            hintText: 'Email',
                            enabled: false, // Email should not be editable
                          ),
                          SizedBox(height: 20),
                          CustomTextfield(
                            controller: _phoneController,
                            hintText: 'Phone Number',
                            // enabled: !_isLoading,
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(246, 246, 247, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              scrollPadding: EdgeInsets.zero,
                              obscureText: _obscurePasswordText,
                              enabled: !_isLoading,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                hintText: '************',
                                hintStyle: const TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(110, 109, 121, 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(246, 246, 247, 1),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: _toggleConfirmPasswordVisibility,
                                  icon: Icon(
                                    _obscurePasswordText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color:
                                        const Color.fromRGBO(110, 109, 121, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              CustomText(
                                text: 'Join Date: ',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(41, 42, 44, 1),
                              ),
                              CustomText(
                                text: 'February 23, 2024',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(119, 119, 121, 1),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 146,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(248, 249, 250, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 23, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Active Subscription',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(119, 119, 121, 1),
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: '\$10',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(53, 49, 45, 1),
                                      ),
                                      CustomText(
                                        text: '/month',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(53, 49, 45, 1),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              67, 184, 136, 1),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            text: 'Deactivate',
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                                67, 184, 136, 1),
                                          ),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            text: 'Share',
                                            fontSize: 14,
                                            color: const Color.fromRGBO(
                                                67, 184, 136, 1),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value:
                                    _isChecked, // Use the state variable instead of hardcoded true
                                onChanged: _handleCheckboxChange,
                                activeColor:
                                    const Color.fromRGBO(67, 184, 136, 1),
                                side: WidgetStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                    width: 1.0,
                                    color: states.contains(WidgetState.selected)
                                        ? const Color.fromRGBO(67, 184, 136, 1)
                                        : const Color.fromRGBO(
                                            242, 242, 244, 1),
                                  ),
                                ),
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return const Color.fromRGBO(
                                          67, 184, 136, 1);
                                    }
                                    return const Color.fromRGBO(
                                        242, 242, 244, 1);
                                  },
                                ),
                              ),
                              Expanded(
                                child: CustomText(
                                  text:
                                      'Opt into receiving weekly legacy questions to ask your family',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(119, 119, 121, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          CustomButton(
                            buttonTitle: 'Save Details',
                            onTap: () {
                              if (_firstNameController.text.isNotEmpty &&
                                  _lastNameController.text.isNotEmpty &&
                                  _phoneController.text.isNotEmpty) {
                                ref
                                    .read(accountControllerProvider.notifier)
                                    .updateProfile(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        phoneNumber: _phoneController.text,
                                        startDate: "2024-12-28T12:34:56Z",
                                        motivationalQuote: '',
                                        profileImageId: 'profileImageId');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Please input all fields")),
                                );
                              }
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                );
              },
              error: (error, st) => Text(error.toString()),
              loading: () => Center(child: CupertinoActivityIndicator())),
        ),
      ),
    );
  }
}
