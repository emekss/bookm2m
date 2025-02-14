import 'package:book_app_m2m/models/book.dart';
import 'package:book_app_m2m/utils/util_functions.dart';

class Answer {
  final String id;
  final String prompt;
  final String? contentUrl;
  final String mediaType;
  final String userId;
  final String questionId;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;
  // TODO: Confirm whats in this list
  final List<Book> appearInBooks;
  final AnswerCounts counts;

  Answer({
    required this.id,
    required this.prompt,
    this.contentUrl,
    required this.mediaType,
    required this.userId,
    required this.questionId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.appearInBooks,
    required this.counts,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prompt': prompt,
      'contentUrl': contentUrl,
      'mediaType': mediaType,
      'userId': userId,
      'questionId': questionId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'appearInBooks': appearInBooks.map((book) => book.toMap()).toList(),
      'counts': counts.toMap(),
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id'] as String,
      prompt: map['prompt'] as String,
      contentUrl: map['contentUrl'] as String?,
      mediaType: map['mediaType'] as String,
      userId: map['userId'] as String,
      questionId: map['questionId'] as String,
      status: map['status'] as bool,
      createdAt: UtilFunctions.parseDateTime(map['createdAt']),
      updatedAt: UtilFunctions.parseDateTime(map['updatedAt']),
      appearInBooks: List<Map<String, dynamic>>.from(map['appearInBooks'])
          .map((map) => Book.fromMap(map))
          .toList(),
      counts: AnswerCounts.fromMap(map['counts']),
    );
  }
}

class AnswerCounts {
  final int appearInBooks;
  final int likes;

  AnswerCounts({required this.appearInBooks, required this.likes});

  Map<String, dynamic> toMap() {
    return {
      'appearInBooks': appearInBooks,
      'likes': likes,
    };
  }

  factory AnswerCounts.fromMap(Map<String, dynamic> map) {
    return AnswerCounts(
      appearInBooks: map['appearInBooks'] as int,
      likes: map['likes'] as int,
    );
  }

  @override
  String toString() {
    return 'AnswerCounts{appearInBooks: $appearInBooks, likes: $likes}';
  }
}
