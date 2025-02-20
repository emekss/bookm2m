// To parse this JSON data, do
//
//     final bookModelTypes = bookModelTypesFromJson(jsonString);

import 'dart:convert';

BookModelTypes bookModelTypesFromJson(String str) => BookModelTypes.fromJson(json.decode(str));

String bookModelTypesToJson(BookModelTypes data) => json.encode(data.toJson());

class BookModelTypes {
    String? name;
    String? value;

    BookModelTypes({
        this.name,
        this.value,
    });

    BookModelTypes copyWith({
        String? name,
        String? value,
    }) => 
        BookModelTypes(
            name: name ?? this.name,
            value: value ?? this.value,
        );

    factory BookModelTypes.fromJson(Map<String, dynamic> json) => BookModelTypes(
        name: json["name"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
    };
}
