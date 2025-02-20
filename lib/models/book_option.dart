// To parse this JSON data, do
//
//     final bookOption = bookOptionFromJson(jsonString);

import 'dart:convert';

BookOption bookOptionFromJson(String str) => BookOption.fromJson(json.decode(str));

String bookOptionToJson(BookOption data) => json.encode(data.toJson());

class BookOption {
    String? id;
    String? name;
    String? description;
    String? values;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<String>? plans;

    BookOption({
        this.id,
        this.name,
        this.description,
        this.values,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.plans,
    });

    BookOption copyWith({
        String? id,
        String? name,
        String? description,
        String? values,
        bool? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<String>? plans,
    }) => 
        BookOption(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            values: values ?? this.values,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            plans: plans ?? this.plans,
        );

    factory BookOption.fromJson(Map<String, dynamic> json) => BookOption(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        values: json["values"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        plans: json["plans"] == null ? [] : List<String>.from(json["plans"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "values": values,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "plans": plans == null ? [] : List<dynamic>.from(plans!.map((x) => x)),
    };
}
