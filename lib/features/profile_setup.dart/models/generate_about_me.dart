// import 'dart:convert';
// Generateaboutme generateaboutmeFromJson(String str) => Generateaboutme.fromJson(json.decode(str));

// String generateaboutmeToJson(Generateaboutme data) => json.encode(data.toJson());

// class Generateaboutme {
//     String message;
//     Data data;
//     Profile profile;

//     Generateaboutme({
//         required this.message,
//         required this.data,
//         required this.profile,
//     });

//     factory Generateaboutme.fromJson(Map<String, dynamic> json) => Generateaboutme(
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//         profile: Profile.fromJson(json["profile"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": data.toJson(),
//         "profile": profile.toJson(),
//     };
// }

// class Data {
//     String id;
//     String userId;
//     String name;
//     String email;
//     String phone;
//     List<String> technicalSkills;
//     List<dynamic> softSkills;
//     List<dynamic> projects;
//     List<Education> education;
//     List<dynamic> awards;
//     List<dynamic> experience;
//     List<Language> languages;
//     List<dynamic> training;
//     List<dynamic> certifications;
//     int v;
//     Address address;
//     dynamic linkedIn;
//     dynamic summary;
//     dynamic github;

//     Data({
//         required this.id,
//         required this.userId,
//         required this.name,
//         required this.email,
//         required this.phone,
//         required this.technicalSkills,
//         required this.softSkills,
//         required this.projects,
//         required this.education,
//         required this.awards,
//         required this.experience,
//         required this.languages,
//         required this.training,
//         required this.certifications,
//         required this.v,
//         required this.address,
//         required this.linkedIn,
//         required this.summary,
//         required this.github,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["_id"],
//         userId: json["user_id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         technicalSkills: List<String>.from(json["technicalSkills"].map((x) => x)),
//         softSkills: List<dynamic>.from(json["softSkills"].map((x) => x)),
//         projects: List<dynamic>.from(json["projects"].map((x) => x)),
//         education: List<Education>.from(json["education"].map((x) => Education.fromJson(x))),
//         awards: List<dynamic>.from(json["awards"].map((x) => x)),
//         experience: List<dynamic>.from(json["experience"].map((x) => x)),
//         languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
//         training: List<dynamic>.from(json["training"].map((x) => x)),
//         certifications: List<dynamic>.from(json["certifications"].map((x) => x)),
//         v: json["__v"],
//         address: Address.fromJson(json["address"]),
//         linkedIn: json["linkedIn"],
//         summary: json["summary"],
//         github: json["github"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "user_id": userId,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "technicalSkills": List<dynamic>.from(technicalSkills.map((x) => x)),
//         "softSkills": List<dynamic>.from(softSkills.map((x) => x)),
//         "projects": List<dynamic>.from(projects.map((x) => x)),
//         "education": List<dynamic>.from(education.map((x) => x.toJson())),
//         "awards": List<dynamic>.from(awards.map((x) => x)),
//         "experience": List<dynamic>.from(experience.map((x) => x)),
//         "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
//         "training": List<dynamic>.from(training.map((x) => x)),
//         "certifications": List<dynamic>.from(certifications.map((x) => x)),
//         "__v": v,
//         "address": address.toJson(),
//         "linkedIn": linkedIn,
//         "summary": summary,
//         "github": github,
//     };
// }

// class Address {
//     String street;
//     String city;
//     String state;
//     dynamic postalCode;
//     String country;

//     Address({
//         required this.street,
//         required this.city,
//         required this.state,
//         required this.postalCode,
//         required this.country,
//     });

//     factory Address.fromJson(Map<String, dynamic> json) => Address(
//         street: json["street"],
//         city: json["city"],
//         state: json["state"],
//         postalCode: json["postal_code"],
//         country: json["country"],
//     );

//     Map<String, dynamic> toJson() => {
//         "street": street,
//         "city": city,
//         "state": state,
//         "postal_code": postalCode,
//         "country": country,
//     };
// }

// class Education {
//     String degree;
//     String institution;
//     String majorField;
//     String educationLevel;
//     dynamic startDate;
//     String? completionDate;
//     String? gpa;
//     String? gpaScale;

//     Education({
//         required this.degree,
//         required this.institution,
//         required this.majorField,
//         required this.educationLevel,
//         required this.startDate,
//         required this.completionDate,
//         required this.gpa,
//         required this.gpaScale,
//     });

//     factory Education.fromJson(Map<String, dynamic> json) => Education(
//         degree: json["degree"],
//         institution: json["institution"],
//         majorField: json["major_field"],
//         educationLevel: json["education_level"],
//         startDate: json["start_date"],
//         completionDate: json["completion_date"],
//         gpa: json["gpa"],
//         gpaScale: json["gpa_scale"],
//     );

//     Map<String, dynamic> toJson() => {
//         "degree": degree,
//         "institution": institution,
//         "major_field": majorField,
//         "education_level": educationLevel,
//         "start_date": startDate,
//         "completion_date": completionDate,
//         "gpa": gpa,
//         "gpa_scale": gpaScale,
//     };
// }

// class Language {
//     String name;
//     String proficiency;

//     Language({
//         required this.name,
//         required this.proficiency,
//     });

//     factory Language.fromJson(Map<String, dynamic> json) => Language(
//         name: json["name"],
//         proficiency: json["proficiency"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "proficiency": proficiency,
//     };
// }

// class Profile {
//     bool isAboutMeGenerated;
//     String generatedAboutMe;

//     Profile({
//         required this.isAboutMeGenerated,
//         required this.generatedAboutMe,
//     });

//     factory Profile.fromJson(Map<String, dynamic> json) => Profile(
//         isAboutMeGenerated: json["isAboutMeGenerated"],
//         generatedAboutMe: json["generatedAboutMe"],
//     );

//     Map<String, dynamic> toJson() => {
//         "isAboutMeGenerated": isAboutMeGenerated,
//         "generatedAboutMe": generatedAboutMe,
//     };
// }



import 'dart:convert';

Generateaboutme generateaboutmeFromJson(String str) =>
    Generateaboutme.fromJson(json.decode(str));

String generateaboutmeToJson(Generateaboutme data) => json.encode(data.toJson());

class Generateaboutme {
  String? message; // Nullable in case server sends null
  Data? data; // Nullable for safety
  Profile? profile; // Nullable in case "profile" is missing

  Generateaboutme({
    this.message,
    this.data,
    this.profile,
  });

  factory Generateaboutme.fromJson(Map<String, dynamic> json) => Generateaboutme(
        message: json["message"] as String? ?? "No message provided",
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        profile: json["profile"] != null ? Profile.fromJson(json["profile"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "profile": profile?.toJson(),
      };
}

class Data {
  String? id;
  String? userId;
  String? name;
  String? email;
  String? phone;
  List<String>? technicalSkills;
  List<dynamic>? softSkills;
  List<dynamic>? projects;
  List<Education>? education;
  List<dynamic>? awards;
  List<dynamic>? experience;
  List<Language>? languages;
  List<dynamic>? training;
  List<dynamic>? certifications;
  int? v;
  Address? address;
  dynamic linkedIn;
  dynamic summary;
  dynamic github;

  Data({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.technicalSkills,
    this.softSkills,
    this.projects,
    this.education,
    this.awards,
    this.experience,
    this.languages,
    this.training,
    this.certifications,
    this.v,
    this.address,
    this.linkedIn,
    this.summary,
    this.github,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"] as String?,
        userId: json["user_id"] as String?,
        name: json["name"] as String?,
        email: json["email"] as String?,
        phone: json["phone"] as String?,
        technicalSkills: json["technicalSkills"] != null
            ? List<String>.from(json["technicalSkills"].map((x) => x?.toString()))
            : null,
        softSkills: json["softSkills"] != null
            ? List<dynamic>.from(json["softSkills"].map((x) => x))
            : null,
        projects: json["projects"] != null
            ? List<dynamic>.from(json["projects"].map((x) => x))
            : null,
        education: json["education"] != null
            ? List<Education>.from(json["education"].map((x) => Education.fromJson(x)))
            : null,
        awards: json["awards"] != null
            ? List<dynamic>.from(json["awards"].map((x) => x))
            : null,
        experience: json["experience"] != null
            ? List<dynamic>.from(json["experience"].map((x) => x))
            : null,
        languages: json["languages"] != null
            ? List<Language>.from(json["languages"].map((x) => Language.fromJson(x)))
            : null,
        training: json["training"] != null
            ? List<dynamic>.from(json["training"].map((x) => x))
            : null,
        certifications: json["certifications"] != null
            ? List<dynamic>.from(json["certifications"].map((x) => x))
            : null,
        v: json["__v"] as int?,
        address: json["address"] != null ? Address.fromJson(json["address"]) : null,
        linkedIn: json["linkedIn"],
        summary: json["summary"],
        github: json["github"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "technicalSkills": technicalSkills != null
            ? List<dynamic>.from(technicalSkills!.map((x) => x))
            : null,
        "softSkills": softSkills != null
            ? List<dynamic>.from(softSkills!.map((x) => x))
            : null,
        "projects": projects != null
            ? List<dynamic>.from(projects!.map((x) => x))
            : null,
        "education": education != null
            ? List<dynamic>.from(education!.map((x) => x.toJson()))
            : null,
        "awards": awards != null ? List<dynamic>.from(awards!.map((x) => x)) : null,
        "experience": experience != null
            ? List<dynamic>.from(experience!.map((x) => x))
            : null,
        "languages": languages != null
            ? List<dynamic>.from(languages!.map((x) => x.toJson()))
            : null,
        "training": training != null
            ? List<dynamic>.from(training!.map((x) => x))
            : null,
        "certifications": certifications != null
            ? List<dynamic>.from(certifications!.map((x) => x))
            : null,
        "__v": v,
        "address": address?.toJson(),
        "linkedIn": linkedIn,
        "summary": summary,
        "github": github,
      };
}

class Address {
  String? street;
  String? city;
  String? state;
  dynamic postalCode;
  String? country;

  Address({
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"] as String?,
        city: json["city"] as String?,
        state: json["state"] as String?,
        postalCode: json["postal_code"],
        country: json["country"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country": country,
      };
}

class Education {
  String? degree;
  String? institution;
  String? majorField;
  String? educationLevel;
  dynamic startDate;
  String? completionDate;
  String? gpa;
  String? gpaScale;

  Education({
    this.degree,
    this.institution,
    this.majorField,
    this.educationLevel,
    this.startDate,
    this.completionDate,
    this.gpa,
    this.gpaScale,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        degree: json["degree"] as String?,
        institution: json["institution"] as String?,
        majorField: json["major_field"] as String?,
        educationLevel: json["education_level"] as String?,
        startDate: json["start_date"],
        completionDate: json["completion_date"] as String?,
        gpa: json["gpa"] as String?,
        gpaScale: json["gpa_scale"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "degree": degree,
        "institution": institution,
        "major_field": majorField,
        "education_level": educationLevel,
        "start_date": startDate,
        "completion_date": completionDate,
        "gpa": gpa,
        "gpa_scale": gpaScale,
      };
}

class Language {
  String? name;
  String? proficiency;

  Language({
    this.name,
    this.proficiency,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        name: json["name"] as String?,
        proficiency: json["proficiency"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "proficiency": proficiency,
      };
}

class Profile {
  bool? isAboutMeGenerated;
  String? generatedAboutMe;

  Profile({
    this.isAboutMeGenerated,
    this.generatedAboutMe,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        isAboutMeGenerated: json["isAboutMeGenerated"] as bool? ?? false,
        generatedAboutMe: json["generatedAboutMe"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "isAboutMeGenerated": isAboutMeGenerated,
        "generatedAboutMe": generatedAboutMe,
      };
}