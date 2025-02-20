// To parse this JSON data, do
//
//     final answers = answersFromJson(jsonString);

import 'dart:convert';

Answers answersFromJson(String str) => Answers.fromJson(json.decode(str));

String answersToJson(Answers data) => json.encode(data.toJson());

class Answers {
    String? id;
    String? prompt;
    String? questionId;
    String? userId;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Count? count;

    Answers({
        this.id,
        this.prompt,
        this.questionId,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.count,
    });

    Answers copyWith({
        String? id,
        String? prompt,
        String? questionId,
        String? userId,
        bool? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        Count? count,
    }) => 
        Answers(
            id: id ?? this.id,
            prompt: prompt ?? this.prompt,
            questionId: questionId ?? this.questionId,
            userId: userId ?? this.userId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            count: count ?? this.count,
        );

    factory Answers.fromJson(Map<String, dynamic> json) => Answers(
        id: json["id"],
        prompt: json["prompt"],
        questionId: json["questionId"],
        userId: json["userId"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
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

class Count {
    int? appearInBooks;
    int? likes;

    Count({
        this.appearInBooks,
        this.likes,
    });

    Count copyWith({
        int? appearInBooks,
        int? likes,
    }) => 
        Count(
            appearInBooks: appearInBooks ?? this.appearInBooks,
            likes: likes ?? this.likes,
        );

    factory Count.fromJson(Map<String, dynamic> json) => Count(
        appearInBooks: json["appearInBooks"],
        likes: json["likes"],
    );

    Map<String, dynamic> toJson() => {
        "appearInBooks": appearInBooks,
        "likes": likes,
    };
}
