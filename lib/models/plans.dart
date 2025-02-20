// To parse this JSON data, do
//
//     final plans = plansFromJson(jsonString);

import 'dart:convert';

Plans plansFromJson(String str) => Plans.fromJson(json.decode(str));

String plansToJson(Plans data) => json.encode(data.toJson());

class Plans {
    String? id;
    String? title;
    String? subTitle;
    String? description;
    int? price;
    String? currency;
    String? billingCycle;
    int? duration;
    String? durationCycle;
    List<FeatureElement>? features;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? status;
    Count? count;

    Plans({
        this.id,
        this.title,
        this.subTitle,
        this.description,
        this.price,
        this.currency,
        this.billingCycle,
        this.duration,
        this.durationCycle,
        this.features,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.count,
    });

    Plans copyWith({
        String? id,
        String? title,
        String? subTitle,
        String? description,
        int? price,
        String? currency,
        String? billingCycle,
        int? duration,
        String? durationCycle,
        List<FeatureElement>? features,
        DateTime? createdAt,
        DateTime? updatedAt,
        bool? status,
        Count? count,
    }) => 
        Plans(
            id: id ?? this.id,
            title: title ?? this.title,
            subTitle: subTitle ?? this.subTitle,
            description: description ?? this.description,
            price: price ?? this.price,
            currency: currency ?? this.currency,
            billingCycle: billingCycle ?? this.billingCycle,
            duration: duration ?? this.duration,
            durationCycle: durationCycle ?? this.durationCycle,
            features: features ?? this.features,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            status: status ?? this.status,
            count: count ?? this.count,
        );

    factory Plans.fromJson(Map<String, dynamic> json) => Plans(
        id: json["id"],
        title: json["title"],
        subTitle: json["subTitle"],
        description: json["description"],
        price: json["price"],
        currency: json["currency"],
        billingCycle: json["billingCycle"],
        duration: json["duration"],
        durationCycle: json["durationCycle"],
        features: json["features"] == null ? [] : List<FeatureElement>.from(json["features"]!.map((x) => FeatureElement.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        status: json["status"],
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subTitle": subTitle,
        "description": description,
        "price": price,
        "currency": currency,
        "billingCycle": billingCycle,
        "duration": duration,
        "durationCycle": durationCycle,
        "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "status": status,
        "_count": count?.toJson(),
    };
}

class Count {
    int? features;

    Count({
        this.features,
    });

    Count copyWith({
        int? features,
    }) => 
        Count(
            features: features ?? this.features,
        );

    factory Count.fromJson(Map<String, dynamic> json) => Count(
        features: json["features"],
    );

    Map<String, dynamic> toJson() => {
        "features": features,
    };
}

class FeatureElement {
    FeatureFeature? feature;
    int? quantity;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? status;

    FeatureElement({
        this.feature,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.status,
    });

    FeatureElement copyWith({
        FeatureFeature? feature,
        int? quantity,
        DateTime? createdAt,
        DateTime? updatedAt,
        bool? status,
    }) => 
        FeatureElement(
            feature: feature ?? this.feature,
            quantity: quantity ?? this.quantity,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            status: status ?? this.status,
        );

    factory FeatureElement.fromJson(Map<String, dynamic> json) => FeatureElement(
        feature: json["feature"] == null ? null : FeatureFeature.fromJson(json["feature"]),
        quantity: json["quantity"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "feature": feature?.toJson(),
        "quantity": quantity,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "status": status,
    };
}

class FeatureFeature {
    String? id;
    String? title;
    bool? status;

    FeatureFeature({
        this.id,
        this.title,
        this.status,
    });

    FeatureFeature copyWith({
        String? id,
        String? title,
        bool? status,
    }) => 
        FeatureFeature(
            id: id ?? this.id,
            title: title ?? this.title,
            status: status ?? this.status,
        );

    factory FeatureFeature.fromJson(Map<String, dynamic> json) => FeatureFeature(
        id: json["id"],
        title: json["title"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
    };
}
