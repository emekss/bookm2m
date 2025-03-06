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
    bool? isFavorite;
    int? shares;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? status;
    Topic? topic;
    List<dynamic>? answers;
    List<Book>? books;
    List<dynamic>? likes;
    Count? count;

    Questions({
        this.id,
        this.prompt,
        this.help,
        this.topicId,
        this.userId,
        this.isFavorite,
        this.shares,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.topic,
        this.answers,
        this.books,
        this.likes,
        this.count,
    });

    Questions copyWith({
        String? id,
        String? prompt,
        String? help,
        String? topicId,
        String? userId,
        bool? isFavorite,
        int? shares,
        DateTime? createdAt,
        DateTime? updatedAt,
        bool? status,
        Topic? topic,
        List<dynamic>? answers,
        List<Book>? books,
        List<dynamic>? likes,
        Count? count,
    }) => 
        Questions(
            id: id ?? this.id,
            prompt: prompt ?? this.prompt,
            help: help ?? this.help,
            topicId: topicId ?? this.topicId,
            userId: userId ?? this.userId,
            isFavorite: isFavorite ?? this.isFavorite,
            shares: shares ?? this.shares,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            status: status ?? this.status,
            topic: topic ?? this.topic,
            answers: answers ?? this.answers,
            books: books ?? this.books,
            likes: likes ?? this.likes,
            count: count ?? this.count,
        );

    factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        id: json["id"],
        prompt: json["prompt"],
        help: json["help"],
        topicId: json["topicId"],
        userId: json["userId"],
        isFavorite: json["isFavorite"],
        shares: json["shares"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        status: json["status"],
        topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
        answers: json["answers"] == null ? [] : List<dynamic>.from(json["answers"]!.map((x) => x)),
        books: json["books"] == null ? [] : List<Book>.from(json["books"]!.map((x) => Book.fromJson(x))),
        likes: json["likes"] == null ? [] : List<dynamic>.from(json["likes"]!.map((x) => x)),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "prompt": prompt,
        "help": help,
        "topicId": topicId,
        "userId": userId,
        "isFavorite": isFavorite,
        "shares": shares,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "status": status,
        "topic": topic?.toJson(),
        "answers": answers == null ? [] : List<dynamic>.from(answers!.map((x) => x)),
        "books": books == null ? [] : List<dynamic>.from(books!.map((x) => x.toJson())),
        "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x)),
        "_count": count?.toJson(),
    };
}

class Book {
    String? id;
    String? title;
    int? volumeNumber;
    String? coverImageId;

    Book({
        this.id,
        this.title,
        this.volumeNumber,
        this.coverImageId,
    });

    Book copyWith({
        String? id,
        String? title,
        int? volumeNumber,
        String? coverImageId,
    }) => 
        Book(
            id: id ?? this.id,
            title: title ?? this.title,
            volumeNumber: volumeNumber ?? this.volumeNumber,
            coverImageId: coverImageId ?? this.coverImageId,
        );

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        volumeNumber: json["volumeNumber"],
        coverImageId: json["coverImageId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "volumeNumber": volumeNumber,
        "coverImageId": coverImageId,
    };
}

class Count {
    int? answers;
    int? likes;
    int? taggedUsers;
    int? books;

    Count({
        this.answers,
        this.likes,
        this.taggedUsers,
        this.books,
    });

    Count copyWith({
        int? answers,
        int? likes,
        int? taggedUsers,
        int? books,
    }) => 
        Count(
            answers: answers ?? this.answers,
            likes: likes ?? this.likes,
            taggedUsers: taggedUsers ?? this.taggedUsers,
            books: books ?? this.books,
        );

    factory Count.fromJson(Map<String, dynamic> json) => Count(
        answers: json["answers"],
        likes: json["likes"],
        taggedUsers: json["taggedUsers"],
        books: json["books"],
    );

    Map<String, dynamic> toJson() => {
        "answers": answers,
        "likes": likes,
        "taggedUsers": taggedUsers,
        "books": books,
    };
}

class Topic {
    String? id;
    String? name;
    dynamic coverImageId;
    dynamic user;

    Topic({
        this.id,
        this.name,
        this.coverImageId,
        this.user,
    });

    Topic copyWith({
        String? id,
        String? name,
        dynamic coverImageId,
        dynamic user,
    }) => 
        Topic(
            id: id ?? this.id,
            name: name ?? this.name,
            coverImageId: coverImageId ?? this.coverImageId,
            user: user ?? this.user,
        );

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        name: json["name"],
        coverImageId: json["coverImageId"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coverImageId": coverImageId,
        "user": user,
    };
}
