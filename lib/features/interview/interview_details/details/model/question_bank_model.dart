class QuestionBankModel {
  final bool success;
  final String message;
  final List<QuestionBank>? body;

  QuestionBankModel({
    required this.success,
    required this.message,
    this.body,
  });

  factory QuestionBankModel.fromJson(Map<String, dynamic> json) {
    return QuestionBankModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      body: (json['body'] as List<dynamic>?)
          ?.map((e) => QuestionBank.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'body': body?.map((e) => e.toJson()).toList(),
    };
  }
}

class QuestionBank {
  final String? id;
  final String? interviewId;
  final String? img;
  final String? questionBankName;
  final int? duration;
  final String? difficultyLevel;
  final String? questionType;
  final String? description;
  final List<String>? whatToExpect;
  final bool? isDeleted;
  final int? v;

  QuestionBank({
    this.id,
    this.interviewId,
    this.img,
    this.questionBankName,
    this.duration,
    this.difficultyLevel,
    this.questionType,
    this.description,
    this.whatToExpect,
    this.isDeleted,
    this.v,
  });

  factory QuestionBank.fromJson(Map<String, dynamic> json) {
    return QuestionBank(
      id: json['_id'],
      interviewId: json['interview_id'],
      img: json['img'],
      questionBankName: json['questionBank_name'],
      duration: json['duration'],
      difficultyLevel: json['difficulty_level'],
      questionType: json['question_Type'],
      description: json['description'],
      whatToExpect: (json['what_to_expect'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isDeleted: json['isDeleted'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'interview_id': interviewId,
      'img': img,
      'questionBank_name': questionBankName,
      'duration': duration,
      'difficulty_level': difficultyLevel,
      'question_Type': questionType,
      'description': description,
      'what_to_expect': whatToExpect,
      'isDeleted': isDeleted,
      '__v': v,
    };
  }
}
