import 'dart:io';

import 'package:book_app_m2m/api/book/book_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/books.dart';
import '../../widgets/snackbars.dart';
import '../asset/asset_controller.dart';

class BooksController extends StateNotifier<AsyncValue<List<Books>>> {
  final BooksRepository repository;
  BooksController(this.repository) : super(const AsyncValue.loading()) {
    fetchBooks();
  }

  List<Books> _allBooks = [];

  /// Fetch all questions
  Future<void> fetchBooks() async {
    try {
      state = const AsyncValue.loading();
      final books = await repository.fetchBooks();
      _allBooks = books;
      state = AsyncValue.data(books);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> createBooks({
    required BuildContext context,
    required String title,
    required String dedication,
    required File coverImage,
    required num volumeNumber,
    required List<String> questions,
    required List<String> answers,
  }) async {
    state = const AsyncValue.loading();
    try {
      final rowId = await repository.uploadAsset(coverImage);
      showSuccessSnackBar(context, "✅ File uploaded successfully");
      print("✅ File uploaded successfully");

      final message = await repository.createBooks(
          title: title,
          dedication: dedication,
          coverImageId: rowId,
          volumeNumber: volumeNumber,
          questions: questions,
          answers: answers);
      showSuccessSnackBar(context, message);
      print("✅ Book created successfully: $message");
      Navigator.pop(context);
      await fetchBooks();
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Update an existing question and refresh the list
  Future<String> updateBooks({
    required String bookId,
    required String title,
    required String dedication,
    required String coverImageId,
    required num volumeNumber,
    required String status,
    required List<String> questions,
    required List<String> answers,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateBooks(
          bookId: bookId,
          title: title,
          dedication: dedication,
          coverImageId: coverImageId,
          volumeNumber: volumeNumber,
          status: status,
          questions: questions,
          answers: answers);
      await fetchBooks(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deleteBooks(String booksId) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.deleteBooks(booksId);
      await fetchBooks(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);

      return e.toString();
    }
  }

  /// Search functionality
  void searchBooks(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allBooks);
    } else {
      final filteredBooks = _allBooks
          .where(
              (q) => q.description!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredBooks);
    }
  }
}

// Provider for QuestionsController
final bookControllerProvider =
    StateNotifierProvider.autoDispose<BooksController, AsyncValue<List<Books>>>(
  (ref) => BooksController(ref.watch(bookModelRepositoryProvider)),
);

// Provider for QuestionsRepository
final bookModelRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return BooksRepository(dioClient: dioClient);
});
