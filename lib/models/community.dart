// To parse this JSON data, do
//
//     final community = communityFromJson(jsonString);

import 'dart:convert';

Community communityFromJson(String str) => Community.fromJson(json.decode(str));

String communityToJson(Community data) => json.encode(data.toJson());

class Community {
    String? id;
    String? name;
    List<Admin>? members;
    String? coverImageId;
    Image? coverImage;
    String? adminId;
    Admin? admin;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Community({
        this.id,
        this.name,
        this.members,
        this.coverImageId,
        this.coverImage,
        this.adminId,
        this.admin,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    Community copyWith({
        String? id,
        String? name,
        List<Admin>? members,
        String? coverImageId,
        Image? coverImage,
        String? adminId,
        Admin? admin,
        bool? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Community(
            id: id ?? this.id,
            name: name ?? this.name,
            members: members ?? this.members,
            coverImageId: coverImageId ?? this.coverImageId,
            coverImage: coverImage ?? this.coverImage,
            adminId: adminId ?? this.adminId,
            admin: admin ?? this.admin,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Community.fromJson(Map<String, dynamic> json) => Community(
        id: json["id"],
        name: json["name"],
        members: json["members"] == null ? [] : List<Admin>.from(json["members"]!.map((x) => Admin.fromJson(x))),
        coverImageId: json["coverImageId"],
        coverImage: json["coverImage"] == null ? null : Image.fromJson(json["coverImage"]),
        adminId: json["adminId"],
        admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toJson())),
        "coverImageId": coverImageId,
        "coverImage": coverImage?.toJson(),
        "adminId": adminId,
        "admin": admin?.toJson(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Admin {
    String? id;
    String? firstName;
    String? lastName;
    String? fullName;
    Image? profileImage;
    String? email;

    Admin({
        this.id,
        this.firstName,
        this.lastName,
        this.fullName,
        this.profileImage,
        this.email,
    });

    Admin copyWith({
        String? id,
        String? firstName,
        String? lastName,
        String? fullName,
        Image? profileImage,
        String? email,
    }) => 
        Admin(
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            fullName: fullName ?? this.fullName,
            profileImage: profileImage ?? this.profileImage,
            email: email ?? this.email,
        );

    factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        profileImage: json["profileImage"] == null ? null : Image.fromJson(json["profileImage"]),
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "profileImage": profileImage?.toJson(),
        "email": email,
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
    bool? status;
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
        bool? status,
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
