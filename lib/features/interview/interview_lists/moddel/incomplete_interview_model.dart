class IncompleteInterviewResponse {
  final bool success;
  final String message;
  final List<IncompleteInterview> body;

  IncompleteInterviewResponse({
    required this.success,
    required this.message,
    required this.body,
  });

  factory IncompleteInterviewResponse.fromJson(Map<String, dynamic> json) {
    return IncompleteInterviewResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      body: (json['body'] as List<dynamic>?)
              ?.map((e) => IncompleteInterview.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class IncompleteInterview {
  final String? id;
  final String? img;
  final String? interviewName;
  final int? totalPositions;
  final String? description;
  final bool? isDeleted;
  final List<String>? questionBankIds;
  final int? v;

  IncompleteInterview({
    this.id,
    this.img,
    this.interviewName,
    this.totalPositions,
    this.description,
    this.isDeleted,
    this.questionBankIds,
    this.v,
  });

  factory IncompleteInterview.fromJson(Map<String, dynamic> json) {
    return IncompleteInterview(
      id: json['_id'] as String?,
      img: json['img'] as String?,
      interviewName: json['interview_name'] as String?,
      totalPositions: json['total_Positions'] as int?,
      description: json['description'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      questionBankIds: (json['question_bank_ids'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      v: json['__v'] as int?,
    );
  }
}
