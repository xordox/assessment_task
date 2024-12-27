// To parse this JSON data, do
//
//     final outletResponseModel = outletResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OutletResponseModel outletResponseModelFromJson(String str) => OutletResponseModel.fromJson(json.decode(str));

String outletResponseModelToJson(OutletResponseModel data) => json.encode(data.toJson());

class OutletResponseModel {
    String code;
    Data data;
    String message;

    OutletResponseModel({
        required this.code,
        required this.data,
        required this.message,
    });

    factory OutletResponseModel.fromJson(Map<String, dynamic> json) => OutletResponseModel(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    List<OutletItem> items;
    int total;

    Data({
        required this.items,
        required this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<OutletItem>.from(json["items"].map((x) => OutletItem.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total": total,
    };
}

class OutletItem {
    String type;
    int value;

    OutletItem({
        required this.type,
        required this.value,
    });

    factory OutletItem.fromJson(Map<String, dynamic> json) => OutletItem(
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
    };
}
