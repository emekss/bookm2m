// To parse this JSON data, do
//
//     final assets = assetsFromJson(jsonString);

import 'dart:convert';

Assets assetsFromJson(String str) => Assets.fromJson(json.decode(str));

String assetsToJson(Assets data) => json.encode(data.toJson());

class TaggedUser {
    String? id;
    String? firstName;
    String? lastName;
    String? fullName;
    String? email;
    String? motivationalQuote;
    DateTime? birthDate;
    Assets? profileImage;
    String? role;
    String? status;
    DateTime? lastSeen;
    String? isEmailVerified;
    DateTime? createdAt;
    DateTime? updatedAt;
    TaggedUserCount? count;

    TaggedUser({
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

    TaggedUser copyWith({
        String? id,
        String? firstName,
        String? lastName,
        String? fullName,
        String? email,
        String? motivationalQuote,
        DateTime? birthDate,
        Assets? profileImage,
        String? role,
        String? status,
        DateTime? lastSeen,
        String? isEmailVerified,
        DateTime? createdAt,
        DateTime? updatedAt,
        TaggedUserCount? count,
    }) => 
        TaggedUser(
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

    factory TaggedUser.fromJson(Map<String, dynamic> json) => TaggedUser(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        email: json["email"],
        motivationalQuote: json["motivationalQuote"],
        birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
        profileImage: json["profileImage"] == null ? null : Assets.fromJson(json["profileImage"]),
        role: json["role"],
        status: json["status"],
        lastSeen: json["lastSeen"] == null ? null : DateTime.parse(json["lastSeen"]),
        isEmailVerified: json["isEmailVerified"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        count: json["_count"] == null ? null : TaggedUserCount.fromJson(json["_count"]),
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

class Assets {
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
    List<TaggedUser>? taggedUsers;
    AssetsCount? count;

    Assets({
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
        this.taggedUsers,
        this.count,
    });

    Assets copyWith({
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
        List<TaggedUser>? taggedUsers,
        AssetsCount? count,
    }) => 
        Assets(
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
            taggedUsers: taggedUsers ?? this.taggedUsers,
            count: count ?? this.count,
        );

    factory Assets.fromJson(Map<String, dynamic> json) => Assets(
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
        taggedUsers: json["taggedUsers"] == null ? [] : List<TaggedUser>.from(json["taggedUsers"]!.map((x) => TaggedUser.fromJson(x))),
        count: json["_count"] == null ? null : AssetsCount.fromJson(json["_count"]),
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
        "taggedUsers": taggedUsers == null ? [] : List<dynamic>.from(taggedUsers!.map((x) => x.toJson())),
        "_count": count?.toJson(),
    };
}

class TaggedUserCount {
    int? books;
    int? assets;
    int? challengesCreated;
    int? questionsCreated;
    int? relatives;
    int? taggedInAssets;
    int? taggedInQuestions;
    int? taggedInChallenges;

    TaggedUserCount({
        this.books,
        this.assets,
        this.challengesCreated,
        this.questionsCreated,
        this.relatives,
        this.taggedInAssets,
        this.taggedInQuestions,
        this.taggedInChallenges,
    });

    TaggedUserCount copyWith({
        int? books,
        int? assets,
        int? challengesCreated,
        int? questionsCreated,
        int? relatives,
        int? taggedInAssets,
        int? taggedInQuestions,
        int? taggedInChallenges,
    }) => 
        TaggedUserCount(
            books: books ?? this.books,
            assets: assets ?? this.assets,
            challengesCreated: challengesCreated ?? this.challengesCreated,
            questionsCreated: questionsCreated ?? this.questionsCreated,
            relatives: relatives ?? this.relatives,
            taggedInAssets: taggedInAssets ?? this.taggedInAssets,
            taggedInQuestions: taggedInQuestions ?? this.taggedInQuestions,
            taggedInChallenges: taggedInChallenges ?? this.taggedInChallenges,
        );

    factory TaggedUserCount.fromJson(Map<String, dynamic> json) => TaggedUserCount(
        books: json["books"],
        assets: json["assets"],
        challengesCreated: json["challengesCreated"],
        questionsCreated: json["questionsCreated"],
        relatives: json["relatives"],
        taggedInAssets: json["taggedInAssets"],
        taggedInQuestions: json["taggedInQuestions"],
        taggedInChallenges: json["taggedInChallenges"],
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
    };
}

class AssetsCount {
    int? taggedUsers;

    AssetsCount({
        this.taggedUsers,
    });

    AssetsCount copyWith({
        int? taggedUsers,
    }) => 
        AssetsCount(
            taggedUsers: taggedUsers ?? this.taggedUsers,
        );

    factory AssetsCount.fromJson(Map<String, dynamic> json) => AssetsCount(
        taggedUsers: json["taggedUsers"],
    );

    Map<String, dynamic> toJson() => {
        "taggedUsers": taggedUsers,
    };
}
