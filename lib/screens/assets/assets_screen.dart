import 'package:book_app_m2m/components/assets_container.dart';
import 'package:book_app_m2m/components/assets_pdf_container.dart';
import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/assets/upload_assets_screen.dart';
import 'package:book_app_m2m/screens/auth/sign_in_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/dashboard/dashboard_screen.dart';
import 'package:book_app_m2m/screens/family/build_family_screen.dart';
import 'package:book_app_m2m/screens/profile/profile_screen.dart';
import 'package:book_app_m2m/screens/question/answer_screen.dart';
import 'package:book_app_m2m/screens/question/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:svg_flutter/svg.dart';

import '../../api/asset/asset_controller.dart';

class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key});

  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String? selectedValue;
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    final assetState = ref.watch(assetControllerProvider);
    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      ),
      floatingActionButton: SizedBox(
        height: 52,
        width: 52,
        child: FloatingActionButton(
          elevation: 0,
          shape: const CircleBorder(),
          backgroundColor: const Color.fromRGBO(67, 184, 136, 1),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadAssetsScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            height: 393,
            child: Image.asset(
              'assets/images/family.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 140.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Assets',
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),

          // White container with form
          Positioned(
            bottom: 0,
            child: Container(
              height: media.height * 0.77,
              width: media.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
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
                                    scrollPadding: EdgeInsets.zero,
                                    onChanged: (query) {
                                      ref
                                          .read(
                                              assetControllerProvider.notifier)
                                          .searchAssets(query);
                                    },
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
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/filter_icon.svg',
                                  fit: BoxFit.scaleDown,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          assetState.when(
                            data: (assets) => assets.isEmpty
                                ? const Center(child: Text("No assets found"))
                                : ListView.builder(
                                    itemCount: assets.length,
                                    itemBuilder: (context, index) {
                                      final asset = assets[index];
                                      return ListTile(
                                        leading: Image.network(asset.url!,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover),
                                        title: Text(asset.title!), 
                                        subtitle: Text(asset.description ??
                                            "No description"),
                                      );
                                    },
                                  ),
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (e, _) => Center(child: Text("Error: $e")),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AssetsContainer(),
                              AssetsContainer(),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AssetsPdfContainer(),
                              AssetsPdfContainer(),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
