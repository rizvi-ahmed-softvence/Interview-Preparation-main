import 'dart:convert';
Progress progressFromJson(String str) => Progress.fromJson(json.decode(str));
String progressToJson(Progress data) => json.encode(data.toJson());
class Progress {
  Map<String, DifferenceBetweenTotalAndWithoutLast> dailyAverages;
  Map<String, DifferenceBetweenTotalAndWithoutLast> dailyPercentageChanges;
  WeeklyGes weeklyAverages;
  WeeklyGes weeklyPercentageChanges;
  DifferenceBetweenTotalAndWithoutLast totalAverage;
  DifferenceBetweenTotalAndWithoutLast withoutLastAverage;
  double lastInterviewChangePercent;
  int totalInterviews;
  List<LyOverallAverage> dailyOverallAverages;
  List<LyOverallAverage> weeklyOverallAverages;
  DifferenceBetweenTotalAndWithoutLast differenceBetweenTotalAndWithoutLast;

  Progress({
    required this.dailyAverages,
    required this.dailyPercentageChanges,
    required this.weeklyAverages,
    required this.weeklyPercentageChanges,
    required this.totalAverage,
    required this.withoutLastAverage,
    required this.lastInterviewChangePercent,
    required this.totalInterviews,
    required this.dailyOverallAverages,
    required this.weeklyOverallAverages,
    required this.differenceBetweenTotalAndWithoutLast,
  });

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        dailyAverages: Map.from(json["dailyAverages"] ?? {}).map(
            (k, v) => MapEntry<String, DifferenceBetweenTotalAndWithoutLast>(
                k, DifferenceBetweenTotalAndWithoutLast.fromJson(v))),
        dailyPercentageChanges: Map.from(json["dailyPercentageChanges"] ?? {})
            .map((k, v) =>
                MapEntry<String, DifferenceBetweenTotalAndWithoutLast>(
                    k, DifferenceBetweenTotalAndWithoutLast.fromJson(v))),
        weeklyAverages: WeeklyGes.fromJson(json["weeklyAverages"] ?? {}),
        weeklyPercentageChanges:
            WeeklyGes.fromJson(json["weeklyPercentageChanges"] ?? {}),
        totalAverage: DifferenceBetweenTotalAndWithoutLast.fromJson(
            json["totalAverage"] ?? {}),
        withoutLastAverage: DifferenceBetweenTotalAndWithoutLast.fromJson(
            json["withoutLastAverage"] ?? {}),
        lastInterviewChangePercent:
            json["lastInterviewChangePercent"]?.toDouble() ?? 0.0,
        totalInterviews: json["totalInterviews"] ?? 0,
        dailyOverallAverages: List<LyOverallAverage>.from(
            json["dailyOverallAverages"]?.map((x) => LyOverallAverage.fromJson(x)) ??
                []),
        weeklyOverallAverages: List<LyOverallAverage>.from(
            json["weeklyOverallAverages"]?.map((x) => LyOverallAverage.fromJson(x)) ??
                []),
        differenceBetweenTotalAndWithoutLast:
            DifferenceBetweenTotalAndWithoutLast.fromJson(
                json["differenceBetweenTotalAndWithoutLast"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "dailyAverages": Map.from(dailyAverages)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "dailyPercentageChanges": Map.from(dailyPercentageChanges)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "weeklyAverages": weeklyAverages.toJson(),
        "weeklyPercentageChanges": weeklyPercentageChanges.toJson(),
        "totalAverage": totalAverage.toJson(),
        "withoutLastAverage": withoutLastAverage.toJson(),
        "lastInterviewChangePercent": lastInterviewChangePercent,
        "totalInterviews": totalInterviews,
        "dailyOverallAverages":
            List<dynamic>.from(dailyOverallAverages.map((x) => x.toJson())),
        "weeklyOverallAverages":
            List<dynamic>.from(weeklyOverallAverages.map((x) => x.toJson())),
        "differenceBetweenTotalAndWithoutLast":
            differenceBetweenTotalAndWithoutLast.toJson(),
      };
}

class DifferenceBetweenTotalAndWithoutLast {
  double articulation;
  double behaviouralCue;
  double problemSolving;  // Change from int to double
  double inprepScore;
  double contentScore;
  double? average;

  DifferenceBetweenTotalAndWithoutLast({
    required this.articulation,
    required this.behaviouralCue,
    required this.problemSolving,
    required this.inprepScore,
    required this.contentScore,
    this.average,
  });

  factory DifferenceBetweenTotalAndWithoutLast.fromJson(Map<String, dynamic> json) =>
      DifferenceBetweenTotalAndWithoutLast(
        articulation: json["Articulation"]?.toDouble() ?? 0.0,
        behaviouralCue: json["Behavioural_Cue"]?.toDouble() ?? 0.0,
        problemSolving: (json["Problem_Solving"] is int)
            ? (json["Problem_Solving"] as int).toDouble()
            : json["Problem_Solving"]?.toDouble() ?? 0.0,
        inprepScore: json["Inprep_Score"]?.toDouble() ?? 0.0,
        contentScore: json["Content_Score"]?.toDouble() ?? 0.0,
        average: json["average"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "Articulation": articulation,
        "Behavioural_Cue": behaviouralCue,
        "Problem_Solving": problemSolving,
        "Inprep_Score": inprepScore,
        "Content_Score": contentScore,
        "average": average,
      };
}


class LyOverallAverage {
  String date;
  double average;

  LyOverallAverage({
    required this.date,
    required this.average,
  });

  factory LyOverallAverage.fromJson(Map<String, dynamic> json) =>
      LyOverallAverage(
        date: json["date"] ?? "",
        average: json["average"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "average": average,
      };
}

class WeeklyGes {
  DifferenceBetweenTotalAndWithoutLast? week1;
  DifferenceBetweenTotalAndWithoutLast week2;
  DifferenceBetweenTotalAndWithoutLast week3;
  DifferenceBetweenTotalAndWithoutLast week4;

  WeeklyGes({
    this.week1,
    required this.week2,
    required this.week3,
    required this.week4,
  });

  factory WeeklyGes.fromJson(Map<String, dynamic> json) => WeeklyGes(
        week1: json["Week 1"] == null
            ? null
            : DifferenceBetweenTotalAndWithoutLast.fromJson(json["Week 1"]),
        week2: DifferenceBetweenTotalAndWithoutLast.fromJson(json["Week 2"] ?? {}),
        week3: DifferenceBetweenTotalAndWithoutLast.fromJson(json["Week 3"] ?? {}),
        week4: DifferenceBetweenTotalAndWithoutLast.fromJson(json["Week 4"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "Week 1": week1?.toJson(),
        "Week 2": week2.toJson(),
        "Week 3": week3.toJson(),
        "Week 4": week4.toJson(),
      };
}

