class MockInterviewResponse {
  final bool success;
  final String message;
  final InterviewBody body;

  MockInterviewResponse({
    required this.success,
    required this.message,
    required this.body,
  });

  factory MockInterviewResponse.fromJson(Map<String, dynamic> json) {
    return MockInterviewResponse(
      success: json['success'],
      message: json['message'],
      body: InterviewBody.fromJson(json['body']),
    );
  }
}

class InterviewBody {
  final List<Interview> allInterviews;
  final List<Interview> suggested;

  InterviewBody({
    required this.allInterviews,
    required this.suggested,
  });

  factory InterviewBody.fromJson(Map<String, dynamic> json) {
    List<dynamic> allInterviewList = json['all_InterView'] ?? [];
    List<Interview> interviews = allInterviewList.map((e) => Interview.fromJson(e)).toList();

    // If "suggested" is empty, fallback to allInterviews
    List<Interview> suggestedInterviews = (json['suggested'] != null && (json['suggested'] as List).isNotEmpty)
        ? (json['suggested'] as List).map((e) => Interview.fromJson(e)).toList()
        : interviews;

    return InterviewBody(
      allInterviews: interviews,
      suggested: suggestedInterviews,
    );
  }
}

class Interview {
  final String id;
  final String img;
  final String interviewName;
  final int totalPositions;
  final String description;
  final bool isDeleted;
  final List<QuestionBank> questionBanks;

  Interview({
    required this.id,
    required this.img,
    required this.interviewName,
    required this.totalPositions,
    required this.description,
    required this.isDeleted,
    required this.questionBanks,
  });

  factory Interview.fromJson(Map<String, dynamic> json) {
    return Interview(
      id: json['_id'],
      img: json['img'],
      interviewName: json['interview_name'],
      totalPositions: json['total_Positions'],
      description: json['description'],
      isDeleted: json['isDeleted'],
      questionBanks: (json['question_bank_ids'] as List)
          .map((e) => QuestionBank.fromJson(e))
          .toList(),
    );
  }
}

class QuestionBank {
  final String id;
  final String interviewId;
  final String img;
  final String questionBankName;
  final int duration;
  final String difficultyLevel;
  final String questionType;
  final String description;
  final List<String> whatToExpect;
  final bool isDeleted;

  QuestionBank({
    required this.id,
    required this.interviewId,
    required this.img,
    required this.questionBankName,
    required this.duration,
    required this.difficultyLevel,
    required this.questionType,
    required this.description,
    required this.whatToExpect,
    required this.isDeleted,
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
      whatToExpect: List<String>.from(json['what_to_expect']),
      isDeleted: json['isDeleted'],
    );
  }
}
