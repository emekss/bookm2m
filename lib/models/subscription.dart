// To parse this JSON data, do
//
//     final sub = subFromJson(jsonString);

import 'dart:convert';

Sub subFromJson(String str) => Sub.fromJson(json.decode(str));

String subToJson(Sub data) => json.encode(data.toJson());

class Sub {
    String? id;
    String? userId;
    User? user;
    String? planId;
    Plan? plan;
    DateTime? startDate;
    DateTime? endDate;
    DateTime? nextBillingDate;
    List<Payment>? payments;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Meta? meta;

    Sub({
        this.id,
        this.userId,
        this.user,
        this.planId,
        this.plan,
        this.startDate,
        this.endDate,
        this.nextBillingDate,
        this.payments,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.meta,
    });

    Sub copyWith({
        String? id,
        String? userId,
        User? user,
        String? planId,
        Plan? plan,
        DateTime? startDate,
        DateTime? endDate,
        DateTime? nextBillingDate,
        List<Payment>? payments,
        bool? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        Meta? meta,
    }) => 
        Sub(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            user: user ?? this.user,
            planId: planId ?? this.planId,
            plan: plan ?? this.plan,
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
            nextBillingDate: nextBillingDate ?? this.nextBillingDate,
            payments: payments ?? this.payments,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            meta: meta ?? this.meta,
        );

    factory Sub.fromJson(Map<String, dynamic> json) => Sub(
        id: json["id"],
        userId: json["userId"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        planId: json["planId"],
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        nextBillingDate: json["nextBillingDate"] == null ? null : DateTime.parse(json["nextBillingDate"]),
        payments: json["payments"] == null ? [] : List<Payment>.from(json["payments"]!.map((x) => Payment.fromJson(x))),
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "user": user?.toJson(),
        "planId": planId,
        "plan": plan?.toJson(),
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "nextBillingDate": nextBillingDate?.toIso8601String(),
        "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x.toJson())),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "meta": meta?.toJson(),
    };
}

class Meta {
    Pagination? pagination;

    Meta({
        this.pagination,
    });

    Meta copyWith({
        Pagination? pagination,
    }) => 
        Meta(
            pagination: pagination ?? this.pagination,
        );

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
    };
}

class Pagination {
    int? totalCount;
    int? totalPage;
    int? currentPage;
    String? next;
    int? currentCountPerPage;
    int? range;

    Pagination({
        this.totalCount,
        this.totalPage,
        this.currentPage,
        this.next,
        this.currentCountPerPage,
        this.range,
    });

    Pagination copyWith({
        int? totalCount,
        int? totalPage,
        int? currentPage,
        String? next,
        int? currentCountPerPage,
        int? range,
    }) => 
        Pagination(
            totalCount: totalCount ?? this.totalCount,
            totalPage: totalPage ?? this.totalPage,
            currentPage: currentPage ?? this.currentPage,
            next: next ?? this.next,
            currentCountPerPage: currentCountPerPage ?? this.currentCountPerPage,
            range: range ?? this.range,
        );

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json["totalCount"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        next: json["next"],
        currentCountPerPage: json["currentCountPerPage"],
        range: json["range"],
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "totalPage": totalPage,
        "currentPage": currentPage,
        "next": next,
        "currentCountPerPage": currentCountPerPage,
        "range": range,
    };
}

class Payment {
    String? id;
    int? amount;
    String? method;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Payment({
        this.id,
        this.amount,
        this.method,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    Payment copyWith({
        String? id,
        int? amount,
        String? method,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Payment(
            id: id ?? this.id,
            amount: amount ?? this.amount,
            method: method ?? this.method,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        amount: json["amount"],
        method: json["method"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "method": method,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Plan {
    String? title;
    String? subTitle;
    String? description;
    double? price;
    String? currency;
    String? billingCycle;
    int? duration;
    String? durationCycle;
    bool? status;

    Plan({
        this.title,
        this.subTitle,
        this.description,
        this.price,
        this.currency,
        this.billingCycle,
        this.duration,
        this.durationCycle,
        this.status,
    });

    Plan copyWith({
        String? title,
        String? subTitle,
        String? description,
        double? price,
        String? currency,
        String? billingCycle,
        int? duration,
        String? durationCycle,
        bool? status,
    }) => 
        Plan(
            title: title ?? this.title,
            subTitle: subTitle ?? this.subTitle,
            description: description ?? this.description,
            price: price ?? this.price,
            currency: currency ?? this.currency,
            billingCycle: billingCycle ?? this.billingCycle,
            duration: duration ?? this.duration,
            durationCycle: durationCycle ?? this.durationCycle,
            status: status ?? this.status,
        );

    factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        title: json["title"],
        subTitle: json["subTitle"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        currency: json["currency"],
        billingCycle: json["billingCycle"],
        duration: json["duration"],
        durationCycle: json["durationCycle"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "description": description,
        "price": price,
        "currency": currency,
        "billingCycle": billingCycle,
        "duration": duration,
        "durationCycle": durationCycle,
        "status": status,
    };
}

class User {
    String? id;
    String? firstName;
    String? lastName;
    ProfileImage? profileImage;
    String? email;

    User({
        this.id,
        this.firstName,
        this.lastName,
        this.profileImage,
        this.email,
    });

    User copyWith({
        String? id,
        String? firstName,
        String? lastName,
        ProfileImage? profileImage,
        String? email,
    }) => 
        User(
            id: id ?? this.id,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            profileImage: profileImage ?? this.profileImage,
            email: email ?? this.email,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profileImage: json["profileImage"] == null ? null : ProfileImage.fromJson(json["profileImage"]),
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profileImage": profileImage?.toJson(),
        "email": email,
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
