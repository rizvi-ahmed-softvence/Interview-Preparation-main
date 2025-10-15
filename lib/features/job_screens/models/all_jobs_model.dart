class AllJobsModel {
  String? sId;
  String? title;
  String? company;
  String? location;
  String? link;
  String? posted;
  String? source;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isApplied;

  AllJobsModel({
    this.sId,
    this.title,
    this.company,
    this.location,
    this.link,
    this.posted,
    this.source,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.isApplied,
  });

  // From JSON to model
  AllJobsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    title = json['title'] as String?;
    company = json['company'] as String?;
    location = json['location'] as String?;
    link = json['link'] as String?;
    posted = json['posted'] as String?;
    source = json['source'] as String?;
    description = json['description'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    iV = json['__v'] as int?;
    isApplied = json['isApplied'] as bool?;
  }

  // From model to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'title': title,
      'company': company,
      'location': location,
      'link': link,
      'posted': posted,
      'source': source,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
      'isApplied': isApplied,
    };
  }
}
