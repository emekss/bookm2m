// To parse this JSON data, do
//
//     final challenges = challengesFromJson(jsonString);

import 'dart:convert';

Challenges challengesFromJson(String str) => Challenges.fromJson(json.decode(str));

String challengesToJson(Challenges data) => json.encode(data.toJson());

class Challenges {
    String? id;
    String? title;
    String? description;
    String? coverImageId;
    Image? coverImage;
    String? userId;
    User? user;
    List<User>? taggedUsers;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Count? count;

    Challenges({
        this.id,
        this.title,
        this.description,
        this.coverImageId,
        this.coverImage,
        this.userId,
        this.user,
        this.taggedUsers,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.count,
    });

    Challenges copyWith({
        String? id,
        String? title,
        String? description,
        String? coverImageId,
        Image? coverImage,
        String? userId,
        User? user,
        List<User>? taggedUsers,
        bool? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        Count? count,
    }) => 
        Challenges(
            id: id ?? this.id,
            title: title ?? this.title,
            description: description ?? this.description,
            coverImageId: coverImageId ?? this.coverImageId,
            coverImage: coverImage ?? this.coverImage,
            userId: userId ?? this.userId,
            user: user ?? this.user,
            taggedUsers: taggedUsers ?? this.taggedUsers,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            count: count ?? this.count,
        );

    factory Challenges.fromJson(Map<String, dynamic> json) => Challenges(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        coverImageId: json["coverImageId"],
        coverImage: json["coverImage"] == null ? null : Image.fromJson(json["coverImage"]),
        userId: json["userId"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        taggedUsers: json["taggedUsers"] == null ? [] : List<User>.from(json["taggedUsers"]!.map((x) => User.fromJson(x))),
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "coverImageId": coverImageId,
        "coverImage": coverImage?.toJson(),
        "userId": userId,
        "user": user?.toJson(),
        "taggedUsers": taggedUsers == null ? [] : List<dynamic>.from(taggedUsers!.map((x) => x.toJson())),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "_count": count?.toJson(),
    };
}

class Count {
    int? taggedUsers;

    Count({
        this.taggedUsers,
    });

    Count copyWith({
        int? taggedUsers,
    }) => 
        Count(
            taggedUsers: taggedUsers ?? this.taggedUsers,
        );

    factory Count.fromJson(Map<String, dynamic> json) => Count(
        taggedUsers: json["taggedUsers"],
    );

    Map<String, dynamic> toJson() => {
        "taggedUsers": taggedUsers,
    };
}

class Image {
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

    Image({
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

    Image copyWith({
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
        Image(
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

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        key: json["key"],
        url: json["url"],
        type: json["type"],
        fileExtension: json["fileExtension"],
        userId: json["userId"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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

class User {
    String? id;
    String? firstName;
    String? lastName;
    Image? profileImage;
    String? email;

    User({
        this.id,
        this.firstName,
        this.lastName,
        this.profileImage,
        this.email,
    });

    User copyWith({
        String? id,
        String? firstName,
        String? lastName,
        Image? profileImage,
        String? email,
    }) => 
        User(
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            profileImage: profileImage ?? this.profileImage,
            email: email ?? this.email,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profileImage: json["profileImage"] == null ? null : Image.fromJson(json["profileImage"]),
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
