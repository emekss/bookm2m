// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
    String? id;
    String? userId;
    User? user;
    String? subscriptionId;
    Subscription? subscription;
    int? amount;
    String? method;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Payment({
        this.id,
        this.userId,
        this.user,
        this.subscriptionId,
        this.subscription,
        this.amount,
        this.method,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    Payment copyWith({
        String? id,
        String? userId,
        User? user,
        String? subscriptionId,
        Subscription? subscription,
        int? amount,
        String? method,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Payment(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            user: user ?? this.user,
            subscriptionId: subscriptionId ?? this.subscriptionId,
            subscription: subscription ?? this.subscription,
            amount: amount ?? this.amount,
            method: method ?? this.method,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        userId: json["userId"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        subscriptionId: json["subscriptionId"],
        subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
        amount: json["amount"],
        method: json["method"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "user": user?.toJson(),
        "subscriptionId": subscriptionId,
        "subscription": subscription?.toJson(),
        "amount": amount,
        "method": method,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Subscription {
    String? id;
    String? userId;
    String? planId;
    DateTime? startDate;
    DateTime? endDate;
    DateTime? nextBillingDate;
    bool? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Subscription({
        this.id,
        this.userId,
        this.planId,
        this.startDate,
        this.endDate,
        this.nextBillingDate,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    Subscription copyWith({
        String? id,
        String? userId,
        String? planId,
        DateTime? startDate,
        DateTime? endDate,
        DateTime? nextBillingDate,
        bool? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Subscription(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            planId: planId ?? this.planId,
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
            nextBillingDate: nextBillingDate ?? this.nextBillingDate,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        userId: json["userId"],
        planId: json["planId"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        nextBillingDate: json["nextBillingDate"] == null ? null : DateTime.parse(json["nextBillingDate"]),
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "planId": planId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "nextBillingDate": nextBillingDate?.toIso8601String(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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
