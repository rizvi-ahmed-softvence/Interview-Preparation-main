class Skills {
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<Data>? data;

  Skills({this.statusCode, this.success, this.message, this.data});

  Skills.fromJson(Map<String, dynamic> json)
      : statusCode = json['statusCode'] as int?,
        success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List<dynamic>?)?.map((v) => Data.fromJson(v as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'message': message,
        'data': data?.map((v) => v.toJson()).toList(),
      };
}

class Data {
  final String? sId;
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;

  Data({this.sId, this.name, this.createdAt, this.updatedAt, this.iV});

  Data.fromJson(Map<String, dynamic> json)
      : sId = json['_id'] as String?,
        name = json['name'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        iV = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': iV,
      };
}
