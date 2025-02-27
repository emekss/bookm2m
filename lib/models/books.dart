// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'dart:convert';

Books booksFromJson(String str) => Books.fromJson(json.decode(str));

String booksToJson(Books data) => json.encode(data.toJson());

class Books {
  String? id;
  String? title;
  String? dedication;
  String? description;
  String? coverImageId;
  CoverImage? coverImage;
  String? color;
  int? volumeNumber;
  String? userId;
  List<Question>? questions;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Count? count;

  Books({
    this.id,
    this.title,
    this.dedication,
    this.description,
    this.coverImageId,
    this.coverImage,
    this.color,
    this.volumeNumber,
    this.userId,
    this.questions,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.count,
  });

  Books copyWith({
    String? id,
    String? title,
    String? dedication,
    String? description,
    String? coverImageId,
    CoverImage? coverImage,
    String? color,
    int? volumeNumber,
    String? userId,
    List<Question>? questions,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Count? count,
  }) =>
      Books(
        id: id ?? this.id,
        title: title ?? this.title,
        dedication: dedication ?? this.dedication,
        description: description ?? this.description,
        coverImageId: coverImageId ?? this.coverImageId,
        coverImage: coverImage ?? this.coverImage,
        color: color ?? this.color,
        volumeNumber: volumeNumber ?? this.volumeNumber,
        userId: userId ?? this.userId,
        questions: questions ?? this.questions,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        count: count ?? this.count,
      );

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        id: json["id"],
        title: json["title"],
        dedication: json["dedication"],
        description: json["description"],
        coverImageId: json["coverImageID"],
        coverImage: json["coverImage"] == null
            ? null
            : CoverImage.fromJson(json["coverImage"]),
        color: json["color"],
        volumeNumber: json["volumeNumber"],
        userId: json["userId"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "dedication": dedication,
        "description": description,
        "coverImageID": coverImageId,
        "coverImage": coverImage?.toJson(),
        "color": color,
        "volumeNumber": volumeNumber,
        "userId": userId,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "_count": count?.toJson(),
      };
}

class Count {
  int? questions;
  int? answers;
  int? models;
  int? orders;

  Count({
    this.questions,
    this.answers,
    this.models,
    this.orders,
  });

  Count copyWith({
    int? questions,
    int? answers,
    int? models,
    int? orders,
  }) =>
      Count(
        questions: questions ?? this.questions,
        answers: answers ?? this.answers,
        models: models ?? this.models,
        orders: orders ?? this.orders,
      );

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        questions: json["questions"],
        answers: json["answers"],
        models: json["models"],
        orders: json["orders"],
      );

  Map<String, dynamic> toJson() => {
        "questions": questions,
        "answers": answers,
        "models": models,
        "orders": orders,
      };
}

class CoverImage {
  String? id;
  String? title;
  String? description;
  String? key;
  String? url;
  String? type;
  String? fileExtension;
  String? userId;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  CoverImage({
    this.id,
    this.title,
    this.description,
    this.key,
    this.url,
    this.type,
    this.fileExtension,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CoverImage copyWith({
    String? id,
    String? title,
    String? description,
    String? key,
    String? url,
    String? type,
    String? fileExtension,
    String? userId,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CoverImage(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        key: key ?? this.key,
        url: url ?? this.url,
        type: type ?? this.type,
        fileExtension: fileExtension ?? this.fileExtension,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        key: json["key"],
        url: json["url"],
        type: json["type"],
        fileExtension: json["fileExtension"],
        userId: json["userId"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "key": key,
        "url": url,
        "type": type,
        "fileExtension": fileExtension,
        "userId": userId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Question {
  String? id;
  String? prompt;
  Topic? topic;
  List<Answer>? answers;

  Question({
    this.id,
    this.prompt,
    this.topic,
    this.answers,
  });

  Question copyWith({
    String? id,
    String? prompt,
    Topic? topic,
    List<Answer>? answers,
  }) =>
      Question(
        id: id ?? this.id,
        prompt: prompt ?? this.prompt,
        topic: topic ?? this.topic,
        answers: answers ?? this.answers,
      );

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        prompt: json["prompt"],
        topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
        answers: json["answers"] == null
            ? []
            : List<Answer>.from(
                json["answers"]!.map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prompt": prompt,
        "topic": topic?.toJson(),
        "answers": answers == null
            ? []
            : List<dynamic>.from(answers!.map((x) => x.toJson())),
      };
}

class Answer {
  List<AppearInBook>? appearInBooks;

  Answer({
    this.appearInBooks,
  });

  Answer copyWith({
    List<AppearInBook>? appearInBooks,
  }) =>
      Answer(
        appearInBooks: appearInBooks ?? this.appearInBooks,
      );

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        appearInBooks: json["appearInBooks"] == null
            ? []
            : List<AppearInBook>.from(
                json["appearInBooks"]!.map((x) => AppearInBook.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "appearInBooks": appearInBooks == null
            ? []
            : List<dynamic>.from(appearInBooks!.map((x) => x.toJson())),
      };
}

class AppearInBook {
  String? id;

  AppearInBook({
    this.id,
  });

  AppearInBook copyWith({
    String? id,
  }) =>
      AppearInBook(
        id: id ?? this.id,
      );

  factory AppearInBook.fromJson(Map<String, dynamic> json) => AppearInBook(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Topic {
  String? id;
  String? name;
  String? coverImageId;

  Topic({
    this.id,
    this.name,
    this.coverImageId,
  });

  Topic copyWith({
    String? id,
    String? name,
    String? coverImageId,
  }) =>
      Topic(
        id: id ?? this.id,
        name: name ?? this.name,
        coverImageId: coverImageId ?? this.coverImageId,
      );

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        name: json["name"],
        coverImageId: json["coverImageId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coverImageId": coverImageId,
      };
}
