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
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? status;
    dynamic profileImage;
    Relation? relation;

    Families({
        this.familyId,
        this.fullName,
        this.email,
        this.phoneNumber,
        this.birthDate,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.profileImage,
        this.relation,
    });

    Families copyWith({
        String? familyId,
        String? fullName,
        String? email,
        String? phoneNumber,
        DateTime? birthDate,
        DateTime? createdAt,
        DateTime? updatedAt,
        bool? status,
        dynamic profileImage,
        Relation? relation,
    }) => 
        Families(
            familyId: familyId ?? this.familyId,
            fullName: fullName ?? this.fullName,
            email: email ?? this.email,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            birthDate: birthDate ?? this.birthDate,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            status: status ?? this.status,
            profileImage: profileImage ?? this.profileImage,
            relation: relation ?? this.relation,
        );

    factory Families.fromJson(Map<String, dynamic> json) => Families(
        familyId: json["familyId"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        status: json["status"],
        profileImage: json["profileImage"],
        relation: json["relation"] == null ? null : Relation.fromJson(json["relation"]),
    );

    Map<String, dynamic> toJson() => {
        "familyId": familyId,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "birthDate": birthDate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "status": status,
        "profileImage": profileImage,
        "relation": relation?.toJson(),
    };
}

class Relation {
    String? id;
    String? name;
    dynamic reverseId;

    Relation({
        this.id,
        this.name,
        this.reverseId,
    });

    Relation copyWith({
        String? id,
        String? name,
        dynamic reverseId,
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
