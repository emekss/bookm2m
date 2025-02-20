// To parse this JSON data, do
//
//     final relationship = relationshipFromJson(jsonString);

import 'dart:convert';

Relationship relationshipFromJson(String str) => Relationship.fromJson(json.decode(str));

String relationshipToJson(Relationship data) => json.encode(data.toJson());

class Relationship {
    String? id;
    String? name;
    String? description;
    String? reverseId;
    String? isReverseOf;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Count? count;

    Relationship({
        this.id,
        this.name,
        this.description,
        this.reverseId,
        this.isReverseOf,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.count,
    });

    Relationship copyWith({
        String? id,
        String? name,
        String? description,
        String? reverseId,
        String? isReverseOf,
        bool? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        Count? count,
    }) => 
        Relationship(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            reverseId: reverseId ?? this.reverseId,
            isReverseOf: isReverseOf ?? this.isReverseOf,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            count: count ?? this.count,
        );

    factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        reverseId: json["reverseId"],
        isReverseOf: json["isReverseOf"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "reverseId": reverseId,
        "isReverseOf": isReverseOf,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "_count": count?.toJson(),
    };
}

class Count {
    int? families;

    Count({
        this.families,
    });

    Count copyWith({
        int? families,
    }) => 
        Count(
            families: families ?? this.families,
        );

    factory Count.fromJson(Map<String, dynamic> json) => Count(
        families: json["families"],
    );

    Map<String, dynamic> toJson() => {
        "families": families,
    };
}
