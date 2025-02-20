// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    String? id;
    String? firstName;
    String? lastName;
    String? status;
    DateTime? lastSeen;
    ProfileImage? profileImage;
    Books? books;
    DateTime? createdAt;
    Count? count;

    UserProfile({
        this.id,
        this.firstName,
        this.lastName,
        this.status,
        this.lastSeen,
        this.profileImage,
        this.books,
        this.createdAt,
        this.count,
    });

    UserProfile copyWith({
        String? id,
        String? firstName,
        String? lastName,
        String? status,
        DateTime? lastSeen,
        ProfileImage? profileImage,
        Books? books,
        DateTime? createdAt,
        Count? count,
    }) => 
        UserProfile(
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            status: status ?? this.status,
            lastSeen: lastSeen ?? this.lastSeen,
            profileImage: profileImage ?? this.profileImage,
            books: books ?? this.books,
            createdAt: createdAt ?? this.createdAt,
            count: count ?? this.count,
        );

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        status: json["status"],
        lastSeen: json["lastSeen"] == null ? null : DateTime.parse(json["lastSeen"]),
        profileImage: json["profileImage"] == null ? null : ProfileImage.fromJson(json["profileImage"]),
        books: json["books"] == null ? null : Books.fromJson(json["books"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "status": status,
        "lastSeen": lastSeen?.toIso8601String(),
        "profileImage": profileImage?.toJson(),
        "books": books?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "_count": count?.toJson(),
    };
}

class Books {
    String? id;
    String? title;
    String? coverImageId;

    Books({
        this.id,
        this.title,
        this.coverImageId,
    });

    Books copyWith({
        String? id,
        String? title,
        String? coverImageId,
    }) => 
        Books(
            id: id ?? this.id,
            title: title ?? this.title,
            coverImageId: coverImageId ?? this.coverImageId,
        );

    factory Books.fromJson(Map<String, dynamic> json) => Books(
        id: json["id"],
        title: json["title"],
        coverImageId: json["coverImageId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "coverImageId": coverImageId,
    };
}

class Count {
    int? books;

    Count({
        this.books,
    });

    Count copyWith({
        int? books,
    }) => 
        Count(
            books: books ?? this.books,
        );

    factory Count.fromJson(Map<String, dynamic> json) => Count(
        books: json["books"],
    );

    Map<String, dynamic> toJson() => {
        "books": books,
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
