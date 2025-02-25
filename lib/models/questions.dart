// To parse this JSON data, do
//
//     final questions = questionsFromJson(jsonString);

import 'dart:convert';

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));

String questionsToJson(Questions data) => json.encode(data.toJson());

class Questions {
  String? id;
  String? prompt;
  String? help;
  String? topicId;
  String? userId;
  List<Answer>? answers;
  List<Like>? taggedUsers;
  List<Like>? likes;
  List<Book>? books;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  QuestionsCount? count;

  Questions({
    this.id,
    this.prompt,
    this.help,
    this.topicId,
    this.userId,
    this.answers,
    this.taggedUsers,
    this.likes,
    this.books,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.count,
  });

  Questions copyWith({
    String? id,
    String? prompt,
    String? help,
    String? topicId,
    String? userId,
    List<Answer>? answers,
    List<Like>? taggedUsers,
    List<Like>? likes,
    List<Book>? books,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    QuestionsCount? count,
  }) =>
      Questions(
        id: id ?? this.id,
        prompt: prompt ?? this.prompt,
        help: help ?? this.help,
        topicId: topicId ?? this.topicId,
        userId: userId ?? this.userId,
        answers: answers ?? this.answers,
        taggedUsers: taggedUsers ?? this.taggedUsers,
        likes: likes ?? this.likes,
        books: books ?? this.books,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        count: count ?? this.count,
      );

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        id: json["id"],
        prompt: json["prompt"],
        help: json["help"],
        topicId: json["topicId"],
        userId: json["userId"],
        answers: json["answers"] == null
            ? []
            : List<Answer>.from(
                json["answers"]!.map((x) => Answer.fromJson(x))),
        taggedUsers: json["taggedUsers"] == null
            ? []
            : List<Like>.from(
                json["taggedUsers"]!.map((x) => Like.fromJson(x))),
        likes: json["likes"] == null
            ? []
            : List<Like>.from(json["likes"]!.map((x) => Like.fromJson(x))),
        books: json["books"] == null
            ? []
            : List<Book>.from(json["books"]!.map((x) => Book.fromJson(x))),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        count: json["_count"] == null
            ? null
            : QuestionsCount.fromJson(json["_count"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prompt": prompt,
        "help": help,
        "topicId": topicId,
        "userId": userId,
        "answers": answers == null
            ? []
            : List<dynamic>.from(answers!.map((x) => x.toJson())),
        "taggedUsers": taggedUsers == null
            ? []
            : List<dynamic>.from(taggedUsers!.map((x) => x.toJson())),
        "likes": likes == null
            ? []
            : List<dynamic>.from(likes!.map((x) => x.toJson())),
        "books": books == null
            ? []
            : List<dynamic>.from(books!.map((x) => x.toJson())),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "_count": count?.toJson(),
      };
}

class Answer {
  String? id;
  String? prompt;
  String? questionId;
  String? userId;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  AnswerCount? count;

  Answer({
    this.id,
    this.prompt,
    this.questionId,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.count,
  });

  Answer copyWith({
    String? id,
    String? prompt,
    String? questionId,
    String? userId,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    AnswerCount? count,
  }) =>
      Answer(
        id: id ?? this.id,
        prompt: prompt ?? this.prompt,
        questionId: questionId ?? this.questionId,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        count: count ?? this.count,
      );

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        prompt: json["prompt"],
        questionId: json["questionId"],
        userId: json["userId"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        count: json["_count"] == null
            ? null
            : AnswerCount.fromJson(json["_count"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prompt": prompt,
        "questionId": questionId,
        "userId": userId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "_count": count?.toJson(),
      };
}

class AnswerCount {
  int? appearInBooks;
  int? likes;

  AnswerCount({
    this.appearInBooks,
    this.likes,
  });

  AnswerCount copyWith({
    int? appearInBooks,
    int? likes,
  }) =>
      AnswerCount(
        appearInBooks: appearInBooks ?? this.appearInBooks,
        likes: likes ?? this.likes,
      );

  factory AnswerCount.fromJson(Map<String, dynamic> json) => AnswerCount(
        appearInBooks: json["appearInBooks"],
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "appearInBooks": appearInBooks,
        "likes": likes,
      };
}

class Book {
  String? id;
  String? title;
  int? volumeNumber;

  Book({
    this.id,
    this.title,
    this.volumeNumber,
  });

  Book copyWith({
    String? id,
    String? title,
    int? volumeNumber,
  }) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
        volumeNumber: volumeNumber ?? this.volumeNumber,
      );

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        volumeNumber: json["volumeNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "volumeNumber": volumeNumber,
      };
}

class QuestionsCount {
  int? books;
  int? likes;
  int? taggedUsers;

  QuestionsCount({
    this.books,
    this.likes,
    this.taggedUsers,
  });

  QuestionsCount copyWith({
    int? books,
    int? likes,
    int? taggedUsers,
  }) =>
      QuestionsCount(
        books: books ?? this.books,
        likes: likes ?? this.likes,
        taggedUsers: taggedUsers ?? this.taggedUsers,
      );

  factory QuestionsCount.fromJson(Map<String, dynamic> json) => QuestionsCount(
        books: json["books"],
        likes: json["likes"],
        taggedUsers: json["taggedUsers"],
      );

  Map<String, dynamic> toJson() => {
        "books": books,
        "likes": likes,
        "taggedUsers": taggedUsers,
      };
}

class Like {
  String? id;
  String? firstName;
  String? lastName;
  ProfileImage? profileImage;
  String? email;

  Like({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.email,
  });

  Like copyWith({
    String? id,
    String? firstName,
    String? lastName,
    ProfileImage? profileImage,
    String? email,
  }) =>
      Like(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        profileImage: profileImage ?? this.profileImage,
        email: email ?? this.email,
      );

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profileImage: json["profileImage"] == null
            ? null
            : ProfileImage.fromJson(json["profileImage"]),
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profileImage": profileImage?.toJson(),
        "email": email,
      };
}

class ProfileImage {
  String? id;
  String? title;
  String? description;
  String? key;
  String? url;
  String? type;
  String? fileExtension;
  String? userId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileImage({
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

  ProfileImage copyWith({
    String? id,
    String? title,
    String? description,
    String? key,
    String? url,
    String? type,
    String? fileExtension,
    String? userId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ProfileImage(
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

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
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
