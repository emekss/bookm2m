import 'dart:ui';

import 'package:book_app_m2m/models/question.dart';
import 'package:book_app_m2m/utils/util_functions.dart';

class Book {
  final String id;
  final String title;
  final String? description;
  final String dedication;
  final String coverImageUrl;
  final Color? color;
  final int volumeNumber;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  // TODO: status should be an enum but I don't know all possible values
  // DRAFT/PRINTED/PUBLISHED/DELETED/ARCHIVED
  final String status;
  final BookCounts counts;
  final List<Question> questions;

  Book({
    required this.id,
    required this.title,
    this.description,
    required this.dedication,
    required this.coverImageUrl,
    this.color,
    required this.volumeNumber,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.counts,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dedication': dedication,
      'coverImageUrl': coverImageUrl,
      'color': color,
      'volumeNumber': volumeNumber,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
      'counts': counts,
      'questions': questions.map((question) => question.toMap()).toList(),
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      dedication: map['dedication'] as String,
      coverImageUrl: map['coverImageUrl'] as String,
      color: map['color'] as Color?,
      volumeNumber: map['volumeNumber'] as int,
      userId: map['userId'] as String,
      createdAt: UtilFunctions.parseDateTime(map['createdAt']),
      updatedAt: UtilFunctions.parseDateTime(map['updatedAt']),
      status: map['status'] as String,
      counts: BookCounts.fromMap(map['_count']),
      questions: List<Map<String, dynamic>>.from(map['questions'])
          .map((map) => Question.fromMap(map))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Book{id: $id, title: $title, description: $description, '
        'dedication: $dedication, coverImageUrl: $coverImageUrl, '
        'color: $color, volumeNumber: $volumeNumber, userId: $userId, '
        'createdAt: $createdAt, updatedAt: $updatedAt, status: $status, '
        'counts: $counts, questions: $questions}';
  }
}

class BookCounts {
  final int orders;
  final int models;
  final int answers;
  final int questions;

  BookCounts({
    required this.orders,
    required this.models,
    required this.answers,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'orders': orders,
      'models': models,
      'answers': answers,
      'questions': questions,
    };
  }

  factory BookCounts.fromMap(Map<String, dynamic> map) {
    return BookCounts(
      orders: map['orders'] as int,
      models: map['models'] as int,
      answers: map['answers'] as int,
      questions: map['questions'] as int,
    );
  }

  @override
  String toString() {
    return 'BookCounts{orders: $orders, models: $models, answers: $answers, '
        'questions: $questions}';
  }
}
