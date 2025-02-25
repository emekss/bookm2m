// To parse this JSON data, do
//
//     final topicModel = topicModelFromJson(jsonString);

import 'dart:convert';

TopicModel topicModelFromJson(String str) =>
    TopicModel.fromJson(json.decode(str));

String topicModelToJson(TopicModel data) => json.encode(data.toJson());

class TopicModel {
  String? id;
  String? name;
  String? coverImageId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? status;
  String? userId;
  CoverImage? coverImage;
  Count? count;

  TopicModel({
    this.id,
    this.name,
    this.coverImageId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.userId,
    this.coverImage,
    this.count,
  });

  TopicModel copyWith({
    String? id,
    String? name,
    String? coverImageId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? status,
    String? userId,
    CoverImage? coverImage,
    Count? count,
  }) =>
      TopicModel(
        id: id ?? this.id,
        name: name ?? this.name,
        coverImageId: coverImageId ?? this.coverImageId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        userId: userId ?? this.userId,
        coverImage: coverImage ?? this.coverImage,
        count: count ?? this.count,
      );

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
        id: json["id"],
        name: json["name"],
        coverImageId: json["coverImageId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        status: json["status"],
        userId: json["userId"],
        coverImage: json["coverImage"] == null
            ? null
            : CoverImage.fromJson(json["coverImage"]),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coverImageId": coverImageId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "status": status,
        "userId": userId,
        "coverImage": coverImage?.toJson(),
        "_count": count?.toJson(),
      };
}

class Count {
  int? questions;

  Count({
    this.questions,
  });

  Count copyWith({
    int? questions,
  }) =>
      Count(
        questions: questions ?? this.questions,
      );

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        questions: json["questions"],
      );

  Map<String, dynamic> toJson() => {
        "questions": questions,
      };
}

class CoverImage {
  String? id;
  String? title;
  String? description;
  String? url;
  String? key;
  String? type;
  dynamic fileExtension;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? status;

  CoverImage({
    this.id,
    this.title,
    this.description,
    this.url,
    this.key,
    this.type,
    this.fileExtension,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  CoverImage copyWith({
    String? id,
    String? title,
    String? description,
    String? url,
    String? key,
    String? type,
    dynamic fileExtension,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? status,
  }) =>
      CoverImage(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        key: key ?? this.key,
        type: type ?? this.type,
        fileExtension: fileExtension ?? this.fileExtension,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
      );

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        key: json["key"],
        type: json["type"],
        fileExtension: json["fileExtension"],
        userId: json["userId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "key": key,
        "type": type,
        "fileExtension": fileExtension,
        "userId": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "status": status,
      };
}
