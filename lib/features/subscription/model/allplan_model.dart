// allplan_model.dart (your existing model, unchanged)
class Allplan {
  int statusCode;
  bool success;
  String message;
  List<Datum> data;

  Allplan({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory Allplan.fromJson(Map<String, dynamic> json) => Allplan(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String name;
  String description;
  double priceMonthly;
  String priceLabel;
  String priceId;
  List<String> features;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.priceMonthly,
    required this.priceLabel,
    required this.priceId,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    priceMonthly: (json["priceMonthly"] ?? 0).toDouble(),
    priceLabel: json["priceLabel"],
    priceId: json["priceId"],
    features: List<String>.from(json["features"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "priceMonthly": priceMonthly,
    "priceLabel": priceLabel,
    "priceId": priceId,
    "features": List<dynamic>.from(features.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
