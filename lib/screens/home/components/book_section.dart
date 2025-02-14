import 'package:book_app_m2m/screens/books/create_book_screen.dart';
import 'package:book_app_m2m/screens/books/view_books_screen.dart';
import 'package:book_app_m2m/screens/home/widgets/book_card.dart';
import 'package:flutter/material.dart';

class BookSection extends StatelessWidget {
  const BookSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateBookScreen(),
                ),
              );
            },
            child: BookCard(
              title: 'Create a book',
              description:
                  'Make a book with your favourite legacy questions or create your own',
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewBooksScreen(),
                ),
              );
            },
            child: BookCard(
              title: 'View all books',
              description: 'Check out all the family members you have added',
            ),
          ),
        ),
      ],
    );
  }
}
