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
    String? fullName;
    String? email;
    String? status;
    String? lastSeen;
    dynamic profileImage;
    DateTime? createdAt;
    Map<String, int>? count;
    List<dynamic>? books;

    UserProfile({
        this.id,
        this.firstName,
        this.lastName,
        this.fullName,
        this.email,
        this.status,
        this.lastSeen,
        this.profileImage,
        this.createdAt,
        this.count,
        this.books,
    });

    UserProfile copyWith({
        String? id,
        String? firstName,
        String? lastName,
        String? fullName,
        String? email,
        String? status,
        String? lastSeen,
        dynamic profileImage,
        DateTime? createdAt,
        Map<String, int>? count,
        List<dynamic>? books,
    }) => 
        UserProfile(
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            fullName: fullName ?? this.fullName,
            email: email ?? this.email,
            status: status ?? this.status,
            lastSeen: lastSeen ?? this.lastSeen,
            profileImage: profileImage ?? this.profileImage,
            createdAt: createdAt ?? this.createdAt,
            count: count ?? this.count,
            books: books ?? this.books,
        );

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        email: json["email"],
        status: json["status"],
        lastSeen: json["lastSeen"],
        profileImage: json["profileImage"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        count: Map.from(json["_count"]!).map((k, v) => MapEntry<String, int>(k, v)),
        books: json["books"] == null ? [] : List<dynamic>.from(json["books"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "email": email,
        "status": status,
        "lastSeen": lastSeen,
        "profileImage": profileImage,
        "createdAt": createdAt?.toIso8601String(),
        "_count": Map.from(count!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "books": books == null ? [] : List<dynamic>.from(books!.map((x) => x)),
    };
}
