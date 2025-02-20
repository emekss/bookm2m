// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
    String? id;
    String? name;
    String? book;
    String? options;
    List<Order>? orders;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    Count? count;

    BookModel({
        this.id,
        this.name,
        this.book,
        this.options,
        this.orders,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.count,
    });

    BookModel copyWith({
        String? id,
        String? name,
        String? book,
        String? options,
        List<Order>? orders,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
        Count? count,
    }) => 
        BookModel(
            id: id ?? this.id,
            name: name ?? this.name,
            book: book ?? this.book,
            options: options ?? this.options,
            orders: orders ?? this.orders,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            count: count ?? this.count,
        );

    factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        name: json["name"],
        book: json["book"],
        options: json["options"],
        orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "book": book,
        "options": options,
        "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "_count": count?.toJson(),
    };
}

class Count {
    int? orders;

    Count({
        this.orders,
    });

    Count copyWith({
        int? orders,
    }) => 
        Count(
            orders: orders ?? this.orders,
        );

    factory Count.fromJson(Map<String, dynamic> json) => Count(
        orders: json["orders"],
    );

    Map<String, dynamic> toJson() => {
        "orders": orders,
    };
}

class Order {
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

    Order({
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

    Order copyWith({
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
        Order(
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

    factory Order.fromJson(Map<String, dynamic> json) => Order(
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
