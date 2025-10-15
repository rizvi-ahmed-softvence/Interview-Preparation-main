

import 'dart:convert';

Updateresume updateresumeFromJson(String str) => Updateresume.fromJson(json.decode(str));

String updateresumeToJson(Updateresume data) => json.encode(data.toJson());

class Updateresume {
    String? message;
    Data? data;
    AboutMe? aboutMe;

    Updateresume({
        this.message,
        this.data,
        this.aboutMe,
    });

    factory Updateresume.fromJson(Map<String, dynamic> json) => Updateresume(
        message: json["message"] as String?,
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        aboutMe: json["aboutMe"] != null ? AboutMe.fromJson(json["aboutMe"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "aboutMe": aboutMe?.toJson(),
    };
}

class AboutMe {
    bool? isAboutMeGenerated;
    String? generatedAboutMe;

    AboutMe({
        this.isAboutMeGenerated,
        this.generatedAboutMe,
    });

    factory AboutMe.fromJson(Map<String, dynamic> json) => AboutMe(
        isAboutMeGenerated: json["isAboutMeGenerated"] as bool?,
        generatedAboutMe: json["generatedAboutMe"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "isAboutMeGenerated": isAboutMeGenerated,
        "generatedAboutMe": generatedAboutMe,
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
    List<Experience>? experience;
    List<dynamic>? languages;
    List<dynamic>? training;
    List<dynamic>? certifications;
    int? v;
    Address? address;
    String? summary;

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
        this.summary,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"] as String?,
        userId: json["user_id"] as String?,
        name: json["name"] as String?,
        email: json["email"] as String?,
        phone: json["phone"] as String?,
        technicalSkills: json["technicalSkills"] != null ? List<String>.from(json["technicalSkills"].map((x) => x as String)) : null,
        softSkills: json["softSkills"] != null ? List<dynamic>.from(json["softSkills"].map((x) => x)) : null,
        projects: json["projects"] != null ? List<dynamic>.from(json["projects"].map((x) => x)) : null,
        education: json["education"] != null ? List<Education>.from(json["education"].map((x) => Education.fromJson(x))) : null,
        awards: json["awards"] != null ? List<dynamic>.from(json["awards"].map((x) => x)) : null,
        experience: json["experience"] != null ? List<Experience>.from(json["experience"].map((x) => Experience.fromJson(x))) : null,
        languages: json["languages"] != null ? List<dynamic>.from(json["languages"].map((x) => x)) : null,
        training: json["training"] != null ? List<dynamic>.from(json["training"].map((x) => x)) : null,
        certifications: json["certifications"] != null ? List<dynamic>.from(json["certifications"].map((x) => x)) : null,
        v: json["__v"] as int?,
        address: json["address"] != null ? Address.fromJson(json["address"]) : null,
        summary: json["summary"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "technicalSkills": technicalSkills != null ? List<dynamic>.from(technicalSkills!.map((x) => x)) : null,
        "softSkills": softSkills != null ? List<dynamic>.from(softSkills!.map((x) => x)) : null,
        "projects": projects != null ? List<dynamic>.from(projects!.map((x) => x)) : null,
        "education": education != null ? List<dynamic>.from(education!.map((x) => x.toJson())) : null,
        "awards": awards != null ? List<dynamic>.from(awards!.map((x) => x)) : null,
        "experience": experience != null ? List<dynamic>.from(experience!.map((x) => x.toJson())) : null,
        "languages": languages != null ? List<dynamic>.from(languages!.map((x) => x)) : null,
        "training": training != null ? List<dynamic>.from(training!.map((x) => x)) : null,
        "certifications": certifications != null ? List<dynamic>.from(certifications!.map((x) => x)) : null,
        "__v": v,
        "address": address?.toJson(),
        "summary": summary,
    };
}

class Address {
    String? city;
    String? country;

    Address({
        this.city,
        this.country,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"] as String?,
        country: json["country"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
    };
}

class Education {
    String? institution;
    String? degree;
    String? majorField;
    String? startDate;
    String? completionDate;

    Education({
        this.institution,
        this.degree,
        this.majorField,
        this.startDate,
        this.completionDate,
    });

    factory Education.fromJson(Map<String, dynamic> json) => Education(
        institution: json["institution"] as String?,
        degree: json["degree"] as String?,
        majorField: json["majorField"] as String?,
        startDate: json["startDate"] as String?,
        completionDate: json["completionDate"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "institution": institution,
        "degree": degree,
        "majorField": majorField,
        "startDate": startDate,
        "completionDate": completionDate,
    };
}

class Experience {
    String? jobTitle;
    String? compnay; // Note: 'compnay' is likely a typo, should be 'company'
    String? city;
    String? country;
    String? responsibilities;
    List<String>? skills;
    String? startDate;
    String? endDate;

    Experience({
        this.jobTitle,
        this.compnay,
        this.city,
        this.country,
        this.responsibilities,
        this.skills,
        this.startDate,
        this.endDate,
    });

    factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        jobTitle: json["jobTitle"] as String?,
        compnay: json["compnay"] as String?,
        city: json["city"] as String?,
        country: json["country"] as String?,
        responsibilities: json["responsibilities"] as String?,
        skills: json["skills"] != null ? List<String>.from(json["skills"].map((x) => x as String)) : null,
        startDate: json["startDate"] as String?,
        endDate: json["endDate"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "jobTitle": jobTitle,
        "compnay": compnay,
        "city": city,
        "country": country,
        "responsibilities": responsibilities,
        "skills": skills != null ? List<dynamic>.from(skills!.map((x) => x)) : null,
        "startDate": startDate,
        "endDate": endDate,
    };
}