// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

UsersModel usersModelFromJson(String str) =>
    UsersModel.fromJson(json.decode(str));

String usersModelToJson(UsersModel data) => json.encode(data.toJson());

class UsersModel {
  String? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? motivationalQuote;
  DateTime? birthDate;
  ProfileImage? profileImage;
  String? role;
  String? status;
  DateTime? lastSeen;
  bool? isEmailVerified;
  DateTime? createdAt;
  DateTime? updatedAt;
  Count? count;

  UsersModel({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.motivationalQuote,
    this.birthDate,
    this.profileImage,
    this.role,
    this.status,
    this.lastSeen,
    this.isEmailVerified,
    this.createdAt,
    this.updatedAt,
    this.count,
  });

  UsersModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    String? motivationalQuote,
    DateTime? birthDate,
    ProfileImage? profileImage,
    String? role,
    String? status,
    DateTime? lastSeen,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    Count? count,
  }) =>
      UsersModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        motivationalQuote: motivationalQuote ?? this.motivationalQuote,
        birthDate: birthDate ?? this.birthDate,
        profileImage: profileImage ?? this.profileImage,
        role: role ?? this.role,
        status: status ?? this.status,
        lastSeen: lastSeen ?? this.lastSeen,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        count: count ?? this.count,
      );

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        email: json["email"],
        motivationalQuote: json["motivationalQuote"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        profileImage: json["profileImage"] == null
            ? null
            : ProfileImage.fromJson(json["profileImage"]),
        role: json["role"],
        status: json["status"],
        lastSeen:
            json["lastSeen"] == null ? null : DateTime.parse(json["lastSeen"]),
        isEmailVerified: json["isEmailVerified"],
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
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "email": email,
        "motivationalQuote": motivationalQuote,
        "birthDate": birthDate?.toIso8601String(),
        "profileImage": profileImage?.toJson(),
        "role": role,
        "status": status,
        "lastSeen": lastSeen?.toIso8601String(),
        "isEmailVerified": isEmailVerified,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "_count": count?.toJson(),
      };
}

class Count {
  int? books;
  int? assets;
  int? challengesCreated;
  int? questionsCreated;
  int? relatives;
  int? taggedInAssets;
  int? taggedInQuestions;
  int? taggedInChallenges;
  int? membersInCommunities;
  int? communitiesCreated;

  Count({
    this.books,
    this.assets,
    this.challengesCreated,
    this.questionsCreated,
    this.relatives,
    this.taggedInAssets,
    this.taggedInQuestions,
    this.taggedInChallenges,
    this.membersInCommunities,
    this.communitiesCreated,
  });

  Count copyWith({
    int? books,
    int? assets,
    int? challengesCreated,
    int? questionsCreated,
    int? relatives,
    int? taggedInAssets,
    int? taggedInQuestions,
    int? taggedInChallenges,
    int? membersInCommunities,
    int? communitiesCreated,
  }) =>
      Count(
        books: books ?? this.books,
        assets: assets ?? this.assets,
        challengesCreated: challengesCreated ?? this.challengesCreated,
        questionsCreated: questionsCreated ?? this.questionsCreated,
        relatives: relatives ?? this.relatives,
        taggedInAssets: taggedInAssets ?? this.taggedInAssets,
        taggedInQuestions: taggedInQuestions ?? this.taggedInQuestions,
        taggedInChallenges: taggedInChallenges ?? this.taggedInChallenges,
        membersInCommunities: membersInCommunities ?? this.membersInCommunities,
        communitiesCreated: communitiesCreated ?? this.communitiesCreated,
      );

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        books: json["books"],
        assets: json["assets"],
        challengesCreated: json["challengesCreated"],
        questionsCreated: json["questionsCreated"],
        relatives: json["relatives"],
        taggedInAssets: json["taggedInAssets"],
        taggedInQuestions: json["taggedInQuestions"],
        taggedInChallenges: json["taggedInChallenges"],
        membersInCommunities: json["membersInCommunities"],
        communitiesCreated: json["communitiesCreated"],
      );

  Map<String, dynamic> toJson() => {
        "books": books,
        "assets": assets,
        "challengesCreated": challengesCreated,
        "questionsCreated": questionsCreated,
        "relatives": relatives,
        "taggedInAssets": taggedInAssets,
        "taggedInQuestions": taggedInQuestions,
        "taggedInChallenges": taggedInChallenges,
        "membersInCommunities": membersInCommunities,
        "communitiesCreated": communitiesCreated,
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
