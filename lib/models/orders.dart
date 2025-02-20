// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));

String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
    String? id;
    String? userId;
    String? bookId;
    String? modelId;
    String? shippingAddress;
    int? numCopies;
    int? shippingTaxRates;
    double? subTotal;
    double? totalCost;
    String? shippingMethod;
    String? paymentMethod;
    String? currency;
    List<History>? history;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Orders({
        this.id,
        this.userId,
        this.bookId,
        this.modelId,
        this.shippingAddress,
        this.numCopies,
        this.shippingTaxRates,
        this.subTotal,
        this.totalCost,
        this.shippingMethod,
        this.paymentMethod,
        this.currency,
        this.history,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    Orders copyWith({
        String? id,
        String? userId,
        String? bookId,
        String? modelId,
        String? shippingAddress,
        int? numCopies,
        int? shippingTaxRates,
        double? subTotal,
        double? totalCost,
        String? shippingMethod,
        String? paymentMethod,
        String? currency,
        List<History>? history,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Orders(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            bookId: bookId ?? this.bookId,
            modelId: modelId ?? this.modelId,
            shippingAddress: shippingAddress ?? this.shippingAddress,
            numCopies: numCopies ?? this.numCopies,
            shippingTaxRates: shippingTaxRates ?? this.shippingTaxRates,
            subTotal: subTotal ?? this.subTotal,
            totalCost: totalCost ?? this.totalCost,
            shippingMethod: shippingMethod ?? this.shippingMethod,
            paymentMethod: paymentMethod ?? this.paymentMethod,
            currency: currency ?? this.currency,
            history: history ?? this.history,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["id"],
        userId: json["userId"],
        bookId: json["bookId"],
        modelId: json["modelId"],
        shippingAddress: json["shippingAddress"],
        numCopies: json["numCopies"],
        shippingTaxRates: json["shippingTaxRates"],
        subTotal: json["subTotal"]?.toDouble(),
        totalCost: json["totalCost"]?.toDouble(),
        shippingMethod: json["shippingMethod"],
        paymentMethod: json["paymentMethod"],
        currency: json["currency"],
        history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bookId": bookId,
        "modelId": modelId,
        "shippingAddress": shippingAddress,
        "numCopies": numCopies,
        "shippingTaxRates": shippingTaxRates,
        "subTotal": subTotal,
        "totalCost": totalCost,
        "shippingMethod": shippingMethod,
        "paymentMethod": paymentMethod,
        "currency": currency,
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class History {
    String? id;
    String? orderId;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    History({
        this.id,
        this.orderId,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    History copyWith({
        String? id,
        String? orderId,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        History(
            id: id ?? this.id,
            orderId: orderId ?? this.orderId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        orderId: json["orderId"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
