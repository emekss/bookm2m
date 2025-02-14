import 'package:book_app_m2m/models/topic.dart';
import 'package:book_app_m2m/utils/util_functions.dart';

class Question {
  final String id;
  final String prompt;
  final String help;
  final String topicId;
  final String userId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SmallTopic topic;
  final QuestionCounts counts;

  Question({
    required this.id,
    required this.prompt,
    required this.help,
    required this.topicId,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.topic,
    required this.counts,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prompt': prompt,
      'help': help,
      'topicId': topicId,
      'userId': userId,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'topic': topic,
      'counts': counts.toMap(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      prompt: map['prompt'] as String,
      help: map['help'] as String,
      topicId: map['topicId'] as String,
      userId: map['userId'] as String,
      status: map['status'] as String,
      createdAt: UtilFunctions.parseDateTime(map['createdAt']),
      updatedAt: UtilFunctions.parseDateTime(map['updatedAt']),
      topic: SmallTopic.fromMap(map['topic']),
      counts: QuestionCounts.fromMap(map['_count']),
    );
  }

  @override
  String toString() {
    return 'Question{id: $id, prompt: $prompt, help: $help, topicId: $topicId, '
        'userId: $userId, status: $status, createdAt: $createdAt, '
        'updatedAt: $updatedAt, topic: $topic, counts: $counts}';
  }
}

class QuestionCounts {
  final int answers;
  final int likes;
  final int taggedUsers;
  final int books;

  QuestionCounts({
    required this.answers,
    required this.likes,
    required this.taggedUsers,
    required this.books,
  });

  Map<String, dynamic> toMap() {
    return {
      'answers': answers,
      'likes': likes,
      'taggedUsers': taggedUsers,
      'books': books,
    };
  }

  factory QuestionCounts.fromMap(Map<String, dynamic> map) {
    return QuestionCounts(
      answers: map['answers'] as int,
      likes: map['likes'] as int,
      taggedUsers: map['taggedUsers'] as int,
      books: map['books'] as int,
    );
  }

  @override
  String toString() {
    return 'QuestionCounts{answers: $answers, likes: $likes, '
        'taggedUsers: $taggedUsers, books: $books}';
  }
}
