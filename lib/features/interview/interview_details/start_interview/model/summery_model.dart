class SummaryModel {
  final bool? success;
  final String? message;
  final SummaryData? data;

  SummaryModel({
    this.success,
    this.message,
    this.data,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? SummaryData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class SummaryData {
  final Assessment? assessment;
  final String? id;
  final String? interviewId;
  final String? questionBankId;
  final String? userId;
  final bool? isLast;
  final bool? isSummary;
  final String? videoUrl;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  SummaryData({
    this.assessment,
    this.id,
    this.interviewId,
    this.questionBankId,
    this.userId,
    this.isLast,
    this.isSummary,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SummaryData.fromJson(Map<String, dynamic> json) {
    return SummaryData(
      assessment:
          json['assessment'] != null ? Assessment.fromJson(json['assessment']) : null,
      id: json['_id'],
      interviewId: json['interview_id'],
      questionBankId: json['questionBank_id'],
      userId: json['user_id'],
      isLast: json['islast'],
      isSummary: json['isSummary'],
      videoUrl: json['video_url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assessment': assessment?.toJson(),
      '_id': id,
      'interview_id': interviewId,
      'questionBank_id': questionBankId,
      'user_id': userId,
      'islast': isLast,
      'isSummary': isSummary,
      'video_url': videoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class Assessment {
  final AssessmentItem? articulation;
  final AssessmentItem? behaviouralCue;
  final AssessmentItem? problemSolving;
  final InprepScore? inprepScore;
  final WhatCanIDoBetter? whatCanIDoBetter;
  final int? contentScore;

  Assessment({
    this.articulation,
    this.behaviouralCue,
    this.problemSolving,
    this.inprepScore,
    this.whatCanIDoBetter,
    this.contentScore,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      articulation: json['Articulation'] != null
          ? AssessmentItem.fromJson(json['Articulation'])
          : null,
      behaviouralCue: json['Behavioural_Cue'] != null
          ? AssessmentItem.fromJson(json['Behavioural_Cue'])
          : null,
      problemSolving: json['Problem_Solving'] != null
          ? AssessmentItem.fromJson(json['Problem_Solving'])
          : null,
      inprepScore: json['Inprep_Score'] != null
          ? InprepScore.fromJson(json['Inprep_Score'])
          : null,
      whatCanIDoBetter: json['what_can_i_do_better'] != null
          ? WhatCanIDoBetter.fromJson(json['what_can_i_do_better'])
          : null,
      contentScore: json['Content_Score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Articulation': articulation?.toJson(),
      'Behavioural_Cue': behaviouralCue?.toJson(),
      'Problem_Solving': problemSolving?.toJson(),
      'Inprep_Score': inprepScore?.toJson(),
      'what_can_i_do_better': whatCanIDoBetter?.toJson(),
      'Content_Score': contentScore,
    };
  }
}

class AssessmentItem {
  final String? feedback;
  final int? score;

  AssessmentItem({
    this.feedback,
    this.score,
  });

  factory AssessmentItem.fromJson(Map<String, dynamic> json) {
    return AssessmentItem(
      feedback: json['feedback'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feedback': feedback,
      'score': score,
    };
  }
}

class InprepScore {
  final int? totalScore;

  InprepScore({this.totalScore});

  factory InprepScore.fromJson(Map<String, dynamic> json) {
    return InprepScore(
      totalScore: json['total_score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_score': totalScore,
    };
  }
}

class WhatCanIDoBetter {
  final String? overallFeedback;

  WhatCanIDoBetter({this.overallFeedback});

  factory WhatCanIDoBetter.fromJson(Map<String, dynamic> json) {
    return WhatCanIDoBetter(
      overallFeedback: json['overall_feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'overall_feedback': overallFeedback,
    };
  }
}
