import 'package:book_app_m2m/utils/util_functions.dart';

class Topic {
  final String id;
  final String name;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool status;
  final String? userId;
  final TopicCounts counts;

  Topic({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.userId,
    required this.counts,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
      'userId': userId,
      'counts': counts.toMap(),
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      createdAt: UtilFunctions.parseDateTime(map['createdAt']),
      updatedAt: UtilFunctions.parseDateTime(map['updatedAt']),
      status: map['status'] as bool,
      userId: map['userId'] as String,
      counts: TopicCounts.fromMap(map['_counts']),
    );
  }

  @override
  String toString() {
    return 'Topic{id: $id, name: $name, imageUrl: $imageUrl, '
        'createdAt: $createdAt, updatedAt: $updatedAt, status: $status, '
        'userId: $userId, counts: $counts}';
  }
}

class TopicCounts {
  final int questions;

  TopicCounts({required this.questions});

  Map<String, dynamic> toMap() {
    return {
      'questions': questions,
    };
  }

  factory TopicCounts.fromMap(Map<String, dynamic> map) {
    return TopicCounts(
      questions: map['questions'] as int,
    );
  }

  @override
  String toString() {
    return 'TopicCounts{questions: $questions}';
  }
}

class SmallTopic {
  final String name;
  final String imageUrl;
  // TODO: It probably shouldn't be string. Confirm
  final String? user;

  SmallTopic({
    required this.name,
    required this.imageUrl,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'user': user,
    };
  }

  factory SmallTopic.fromMap(Map<String, dynamic> map) {
    return SmallTopic(
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      user: map['user'] as String,
    );
  }

  @override
  String toString() {
    return 'SmallTopic{name: $name, imageUrl: $imageUrl, user: $user}';
  }
}
