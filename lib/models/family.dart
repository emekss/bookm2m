// To parse this JSON data, do
//
//     final families = familiesFromJson(jsonString);

import 'dart:convert';

Families familiesFromJson(String str) => Families.fromJson(json.decode(str));

String familiesToJson(Families data) => json.encode(data.toJson());

class Families {
  String? familyId;
  String? fullName;
  String? email;
  String? phoneNumber;
  DateTime? birthDate;
  ProfileImage? profileImage;
  String? userId;
  Relation? relation;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Families({
    this.familyId,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.birthDate,
    this.profileImage,
    this.userId,
    this.relation,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Families copyWith({
    String? familyId,
    String? fullName,
    String? email,
    String? phoneNumber,
    DateTime? birthDate,
    ProfileImage? profileImage,
    String? userId,
    Relation? relation,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Families(
        familyId: familyId ?? this.familyId,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        birthDate: birthDate ?? this.birthDate,
        profileImage: profileImage ?? this.profileImage,
        userId: userId ?? this.userId,
        relation: relation ?? this.relation,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Families.fromJson(Map<String, dynamic> json) => Families(
        familyId: json["familyId"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        profileImage: json["profileImage"] == null
            ? null
            : ProfileImage.fromJson(json["profileImage"]),
        userId: json["userId"],
        relation: json["relation"] == null
            ? null
            : Relation.fromJson(json["relation"]),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "familyId": familyId,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "birthDate": birthDate?.toIso8601String(),
        "profileImage": profileImage?.toJson(),
        "userId": userId,
        "relation": relation?.toJson(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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
  bool? status;
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
    bool? status,
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

class Relation {
  String? id;
  String? name;
  String? reverseId;

  Relation({
    this.id,
    this.name,
    this.reverseId,
  });

  Relation copyWith({
    String? id,
    String? name,
    String? reverseId,
  }) =>
      Relation(
        id: id ?? this.id,
        name: name ?? this.name,
        reverseId: reverseId ?? this.reverseId,
      );

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        id: json["id"],
        name: json["name"],
        reverseId: json["reverseId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "reverseId": reverseId,
      };
}
