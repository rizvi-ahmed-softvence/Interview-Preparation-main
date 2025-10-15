

// Models for response
import 'dart:convert';

Vedioresponse vedioresponseFromJson(String str) =>
    Vedioresponse.fromJson(json.decode(str));

String vedioresponseToJson(Vedioresponse data) => json.encode(data.toJson());

class Vedioresponse {
  String qid;
  String interviewId;
  String questionBankId;
  String userId;
  bool isSummary;
  bool islast;
  String videoUrl;
  Assessment assessment;

  Vedioresponse({
    required this.qid,
    required this.interviewId,
    required this.questionBankId,
    required this.userId,
    required this.isSummary,
    required this.islast,
    required this.videoUrl,
    required this.assessment,
  });

  factory Vedioresponse.fromJson(Map<String, dynamic> json) => Vedioresponse(
        qid: json["qid"] ?? '',
        interviewId: json["interview_id"] ?? '',
        questionBankId: json["questionBank_id"] ?? '',
        userId: json["user_id"] ?? '',
        isSummary: json["isSummary"] ?? false,
        islast: json["islast"] ?? false,
        videoUrl: json["video_url"] ?? '',
        assessment: Assessment.fromJson(json["assessment"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "qid": qid,
        "interview_id": interviewId,
        "questionBank_id": questionBankId,
        "user_id": userId,
        "isSummary": isSummary,
        "islast": islast,
        "video_url": videoUrl,
        "assessment": assessment.toJson(),
      };
}

class Assessment {
  Articulation articulation;
  Articulation behaviouralCue;
  Articulation problemSolving;
  InprepScore inprepScore;
  WhatCanIDoBetter whatCanIDoBetter;
  int contentScore;

  Assessment({
    required this.articulation,
    required this.behaviouralCue,
    required this.problemSolving,
    required this.inprepScore,
    required this.whatCanIDoBetter,
    required this.contentScore,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        articulation: Articulation.fromJson(json["Articulation"] ?? {}),
        behaviouralCue: Articulation.fromJson(json["Behavioural_Cue"] ?? {}),
        problemSolving: Articulation.fromJson(json["Problem_Solving"] ?? {}),
        inprepScore: InprepScore.fromJson(json["Inprep_Score"] ?? {}),
        whatCanIDoBetter:
            WhatCanIDoBetter.fromJson(json["what_can_i_do_better"] ?? {}),
        contentScore: json["Content_Score"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "Articulation": articulation.toJson(),
        "Behavioural_Cue": behaviouralCue.toJson(),
        "Problem_Solving": problemSolving.toJson(),
        "Inprep_Score": inprepScore.toJson(),
        "what_can_i_do_better": whatCanIDoBetter.toJson(),
        "Content_Score": contentScore,
      };
}

class Articulation {
  String feedback;
  double score;

  Articulation({
    required this.feedback,
    required this.score,
  });

  factory Articulation.fromJson(Map<String, dynamic> json) => Articulation(
        feedback: json["feedback"] ?? '',
        score: json["score"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "feedback": feedback,
        "score": score,
      };
}

class InprepScore {
  double totalScore;

  InprepScore({
    required this.totalScore,
  });

  factory InprepScore.fromJson(Map<String, dynamic> json) => InprepScore(
        totalScore: json["total_score"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "total_score": totalScore,
      };
}

class WhatCanIDoBetter {
  String overallFeedback;

  WhatCanIDoBetter({
    required this.overallFeedback,
  });

  factory WhatCanIDoBetter.fromJson(Map<String, dynamic> json) =>
      WhatCanIDoBetter(
        overallFeedback: json["overall_feedback"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "overall_feedback": overallFeedback,
      };
}