class LoginInfo {
  String? message;
  String? accessMessage;
  String? approvalToken;
  String? refreshToken;
  Meta? meta;
  User? user;

  LoginInfo({
    this.message,
    this.accessMessage,
    this.approvalToken,
    this.refreshToken,
    this.meta,
    this.user,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(
      message: json['message'] as String?,
      accessMessage: json['access_Message'] as String?,
      approvalToken: json['approvalToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      meta: json['meta'] != null ? Meta.fromJson(json['meta'] as Map<String, dynamic>) : null,
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['access_Message'] = accessMessage;
    data['approvalToken'] = approvalToken;
    data['refreshToken'] = refreshToken;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Meta {
  bool? isResumeUploaded;
  bool? isAboutMeGenerated;
  bool? isAboutMeVideoChecked;

  Meta({
    this.isResumeUploaded,
    this.isAboutMeGenerated,
    this.isAboutMeVideoChecked,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      isResumeUploaded: json['isResumeUploaded'] as bool?,
      isAboutMeGenerated: json['isAboutMeGenerated'] as bool?,
      isAboutMeVideoChecked: json['isAboutMeVideoChecked'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isResumeUploaded'] = isResumeUploaded;
    data['isAboutMeGenerated'] = isAboutMeGenerated;
    data['isAboutMeVideoChecked'] = isAboutMeVideoChecked;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? role;
  bool? agreedToTerms;
  String? sentOTP;
  bool? otpVerified;
  bool? isDeleted;
  bool? isBlocked;
  bool? isLoggedIn;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User({
    this.sId,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.role,
    this.agreedToTerms,
    this.sentOTP,
    this.otpVerified,
    this.isDeleted,
    this.isBlocked,
    this.isLoggedIn,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      sId: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      agreedToTerms: json['aggriedToTerms'] as bool?,
      sentOTP: json['sentOTP'] as String?,
      otpVerified: json['OTPverified'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isBlocked: json['isBlocked'] as bool?,
      isLoggedIn: json['isLoggedIn'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['aggriedToTerms'] = agreedToTerms;
    data['sentOTP'] = sentOTP;
    data['OTPverified'] = otpVerified;
    data['isDeleted'] = isDeleted;
    data['isBlocked'] = isBlocked;
    data['isLoggedIn'] = isLoggedIn;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}