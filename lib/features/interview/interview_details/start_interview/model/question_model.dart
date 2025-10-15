class Question {
  final bool success;
  final String message;
  final QuestionBody? body;

  Question({
    required this.success,
    required this.message,
    this.body,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      body: json['body'] != null ? QuestionBody.fromJson(json['body']) : null,
    );
  }
}

class QuestionBody {
  final String? userId;
  final String? questionBankId;
  final String? interviewId;
  final List<QuestionSet>? questionSet;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  QuestionBody({
    this.userId,
    this.questionBankId,
    this.interviewId,
    this.questionSet,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory QuestionBody.fromJson(Map<String, dynamic> json) {
    return QuestionBody(
      userId: json['user_id'],
      questionBankId: json['question_bank_id'],
      interviewId: json['interview_id'],
      questionSet: (json['question_Set'] as List<dynamic>?)
          ?.map((e) => QuestionSet.fromJson(e))
          .toList(),
      id: json['_id'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }
}

class QuestionSet {
  final String? interviewId;
  final String? questionBankId;
  final String? userId;
  final int? timeToAnswer;
  final String? question;
  final bool? isRetake;
  final bool? isLast;
  final String? id;

  QuestionSet({
    this.interviewId,
    this.questionBankId,
    this.userId,
    this.timeToAnswer,
    this.question,
    this.isRetake,
    this.isLast,
    this.id,
  });

  factory QuestionSet.fromJson(Map<String, dynamic> json) {
    return QuestionSet(
      interviewId: json['interview_id'],
      questionBankId: json['questionBank_id'],
      userId: json['user_id'],
      timeToAnswer: json['time_to_answer'],
      question: json['question'],
      isRetake: json['isRetake'],
      isLast: json['islast'],
      id: json['_id'],
    );
  }
}
