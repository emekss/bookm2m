import 'package:book_app_m2m/components/custom_text.dart';
import 'package:book_app_m2m/screens/order/order_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  // Sample data for demonstration
  final List<Map<String, dynamic>> purchaseItems = [
    {
      'title': 'Book Title 1',
      'author': 'Tabish Bin Tahir',
      'price': 75,
    },
    {
      'title': 'Book Title 2',
      'author': 'John Doe',
      'price': 60,
    },
    {
      'title': 'Book Title 3',
      'author': 'Jane Smith',
      'price': 85,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: CustomText(
          text: 'Purchases',
          fontSize: 23,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(53, 49, 45, 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: purchaseItems.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  height: 108,
                                  width: 87,
                                  child: Image.asset(
                                      'assets/images/purchaseimage.png')),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: purchaseItems[index]['title'],
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(53, 49, 45, 1),
                                  ),
                                  CustomText(
                                    text: purchaseItems[index]['author'],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(119, 119, 121, 1),
                                  ),
                                  SizedBox(height: 8),
                                  CustomText(
                                    text: '\$${purchaseItems[index]['price']}',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(53, 49, 45, 1),
                                  ),
                                  SizedBox(height: 5),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderPageScreen()),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/refresh_icon.svg'),
                                            SizedBox(width: 6),
                                            CustomText(
                                              text: 'Buy Again',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  67, 184, 136, 1),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(67, 184, 136, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/edit_icon.svg'),
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
                              SizedBox(height: 40),
                              SvgPicture.asset('assets/icons/buy_icon.svg'),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
