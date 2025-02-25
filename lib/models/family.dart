// To parse this JSON data, do
//
//     final families = familiesFromJson(jsonString);

import 'dart:convert';

Families familiesFromJson(String str) => Families.fromJson(json.decode(str));

String familiesToJson(Families data) => json.encode(data.toJson());

class Families {
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? status;
    Relative? relative;
    Relation? relation;

    Families({
        this.createdAt,
        this.updatedAt,
        this.status,
        this.relative,
        this.relation,
    });

    Families copyWith({
        DateTime? createdAt,
        DateTime? updatedAt,
        bool? status,
        Relative? relative,
        Relation? relation,
    }) => 
        Families(
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            status: status ?? this.status,
            relative: relative ?? this.relative,
            relation: relation ?? this.relation,
        );

    factory Families.fromJson(Map<String, dynamic> json) => Families(
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        status: json["status"],
        relative: json["relative"] == null ? null : Relative.fromJson(json["relative"]),
        relation: json["relation"] == null ? null : Relation.fromJson(json["relation"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "status": status,
        "relative": relative?.toJson(),
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

class Relative {
    String? id;
    String? fullName;
    String? firstName;
    String? lastName;
    String? email;
    String? phoneNumber;
    dynamic birthDate;
    dynamic profileImage;

    Relative({
        this.id,
        this.fullName,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.birthDate,
        this.profileImage,
    });

    Relative copyWith({
        String? id,
        String? fullName,
        String? firstName,
        String? lastName,
        String? email,
        String? phoneNumber,
        dynamic birthDate,
        dynamic profileImage,
    }) => 
        Relative(
            id: id ?? this.id,
            fullName: fullName ?? this.fullName,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            email: email ?? this.email,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            birthDate: birthDate ?? this.birthDate,
            profileImage: profileImage ?? this.profileImage,
        );

    factory Relative.fromJson(Map<String, dynamic> json) => Relative(
        id: json["id"],
        fullName: json["fullName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        birthDate: json["birthDate"],
        profileImage: json["profileImage"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "birthDate": birthDate,
        "profileImage": profileImage,
    };
}
