class UserInfo {
  bool? success;
  String? message;
  Data? data;

  UserInfo({this.success, this.message, this.data});

  UserInfo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['success'] = success;
    json['message'] = message;
    if (data != null) {
      json['data'] = data!.toJson();
    }
    return json;
  }
}

class Data {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? img;
  String? experienceLevel;
  String? preferedInterviewFocus;
  bool? emailNotification;
  int? interviewTaken;
  int? confidence;
  bool? isResumeUploaded;
  bool? isAboutMeGenerated;
  String? generatedAboutMe;
  bool? isAboutMeVideoChecked;
  List<dynamic>? appliedJobs;
  UserId? userId;
  String? currentPlan;
  List<dynamic>? planId;
  int? interviewsAvailable;
  String? stripeCustomerId;
  List<dynamic>? stripeSubscriptionId;
  List<dynamic>? paymentId;
  String? lastJobNotificationDate;
  bool? isDeleted;
  List<dynamic>? progress;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? resumeId;

  Data({
    this.sId,
    this.name,
    this.phone,
    this.email,
    this.img,
    this.experienceLevel,
    this.preferedInterviewFocus,
    this.emailNotification,
    this.interviewTaken,
    this.confidence,
    this.isResumeUploaded,
    this.isAboutMeGenerated,
    this.generatedAboutMe,
    this.isAboutMeVideoChecked,
    this.appliedJobs,
    this.userId,
    this.currentPlan,
    this.planId,
    this.interviewsAvailable,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    this.paymentId,
    this.lastJobNotificationDate,
    this.isDeleted,
    this.progress,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.resumeId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    img = json['img'];
    experienceLevel = json['experienceLevel'];
    preferedInterviewFocus = json['preferedInterviewFocus'];
    emailNotification = json['emailNotification'];
    interviewTaken = json['interviewTaken'];
    confidence = json['confidence'];
    isResumeUploaded = json['isResumeUploaded'];
    isAboutMeGenerated = json['isAboutMeGenerated'];
    generatedAboutMe = json['generatedAboutMe'];
    isAboutMeVideoChecked = json['isAboutMeVideoChecked'];
    appliedJobs = json['appliedJobs'];
    userId = json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    currentPlan = json['currentPlan'];
    planId = json['plan_id'];
    interviewsAvailable = json['interviewsAvailable'];
    stripeCustomerId = json['stripeCustomerId'];
    stripeSubscriptionId = json['stripeSubscriptionId'];
    paymentId = json['paymentId'];
    lastJobNotificationDate = json['lastJobNotificationDate'];
    isDeleted = json['isDeleted'];
    progress = json['progress'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    resumeId = json['resume_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['_id'] = sId;
    json['name'] = name;
    json['phone'] = phone;
    json['email'] = email;
    json['img'] = img;
    json['experienceLevel'] = experienceLevel;
    json['preferedInterviewFocus'] = preferedInterviewFocus;
    json['emailNotification'] = emailNotification;
    json['interviewTaken'] = interviewTaken;
    json['confidence'] = confidence;
    json['isResumeUploaded'] = isResumeUploaded;
    json['isAboutMeGenerated'] = isAboutMeGenerated;
    json['generatedAboutMe'] = generatedAboutMe;
    json['isAboutMeVideoChecked'] = isAboutMeVideoChecked;
    json['appliedJobs'] = appliedJobs;
    if (userId != null) {
      json['user_id'] = userId!.toJson();
    }
    json['currentPlan'] = currentPlan;
    json['plan_id'] = planId;
    json['interviewsAvailable'] = interviewsAvailable;
    json['stripeCustomerId'] = stripeCustomerId;
    json['stripeSubscriptionId'] = stripeSubscriptionId;
    json['paymentId'] = paymentId;
    json['lastJobNotificationDate'] = lastJobNotificationDate;
    json['isDeleted'] = isDeleted;
    json['progress'] = progress;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = iV;
    json['resume_id'] = resumeId;
    return json;
  }
}

class UserId {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? role;
  bool? aggriedToTerms;
  bool? allowPasswordChange;
  String? sentOTP;
  bool? oTPverified;
  bool? isDeleted;
  bool? isBlocked;
  bool? isLoggedIn;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserId({
    this.sId,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.role,
    this.aggriedToTerms,
    this.allowPasswordChange,
    this.sentOTP,
    this.oTPverified,
    this.isDeleted,
    this.isBlocked,
    this.isLoggedIn,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    aggriedToTerms = json['aggriedToTerms'];
    allowPasswordChange = json['allowPasswordChange'];
    sentOTP = json['sentOTP'];
    oTPverified = json['OTPverified'];
    isDeleted = json['isDeleted'];
    isBlocked = json['isBlocked'];
    isLoggedIn = json['isLoggedIn'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['_id'] = sId;
    json['name'] = name;
    json['phone'] = phone;
    json['email'] = email;
    json['password'] = password;
    json['role'] = role;
    json['aggriedToTerms'] = aggriedToTerms;
    json['allowPasswordChange'] = allowPasswordChange;
    json['sentOTP'] = sentOTP;
    json['OTPverified'] = oTPverified;
    json['isDeleted'] = isDeleted;
    json['isBlocked'] = isBlocked;
    json['isLoggedIn'] = isLoggedIn;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = iV;
    return json;
  }
}
