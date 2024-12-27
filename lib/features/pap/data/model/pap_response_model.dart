import 'dart:convert';

PapResponseModel papResponseModelFromJson(String str) =>
    PapResponseModel.fromJson(json.decode(str));

String papResponseModelToJson(PapResponseModel data) =>
    json.encode(data.toJson());

class PapResponseModel {
  String code;
  Data data;
  String message;

  PapResponseModel({
    required this.code,
    required this.data,
    required this.message,
  });

  factory PapResponseModel.fromJson(Map<String, dynamic> json) =>
      PapResponseModel(
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
  List<Item> items;
  int total;

  Data({
    required this.items,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total": total,
      };
}

class Item {
  String type;
  int value;

  Item({
    required this.type,
    required this.value,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}
