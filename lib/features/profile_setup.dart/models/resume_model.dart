class Address {
  final String city;
  final String country;

  Address({required this.city, required this.country});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
    };
  }
}

class Education {
  final String institution;
  final String degree;
  final String majorField;
  final String startDate;
  final String completionDate;

  Education({
    required this.institution,
    required this.degree,
    required this.majorField,
    required this.startDate,
    required this.completionDate,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'],
      degree: json['degree'],
      majorField: json['majorField'],
      startDate: json['startDate'],
      completionDate: json['completionDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'degree': degree,
      'majorField': majorField,
      'startDate': startDate,
      'completionDate': completionDate,
    };
  }
}

class Experience {
  final String jobTitle;
  final String company;
  final String city;
  final String country;
  final String responsibilities;
  final List<String> skills;
  final String startDate;
  final String endDate;

  Experience({
    required this.jobTitle,
    required this.company,
    required this.city,
    required this.country,
    required this.responsibilities,
    required this.skills,
    required this.startDate,
    required this.endDate,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      jobTitle: json['jobTitle'],
      company: json['company'],
      city: json['city'],
      country: json['country'],
      responsibilities: json['responsibilities'],
      skills: List<String>.from(json['skills']),
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'company': company,
      'city': city,
      'country': country,
      'responsibilities': responsibilities,
      'skills': skills,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

class ResumeData {
  final String summary;
  final Address address;
  final List<String> technicalSkills;
  final Experience experience;
  final List<Education> education;

  ResumeData({
    required this.summary,
    required this.address,
    required this.technicalSkills,
    required this.experience,
    required this.education,
  });

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      summary: json['summary'],
      address: Address.fromJson(json['address']),
      technicalSkills: List<String>.from(json['technicalSkills']),
      experience: Experience.fromJson(json['experience']),
      education: (json['education'] as List)
          .map((e) => Education.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
      'address': address.toJson(),
      'technicalSkills': technicalSkills,
      'experience': experience.toJson(),
      'education': education.map((e) => e.toJson()).toList(),
    };
  }
}