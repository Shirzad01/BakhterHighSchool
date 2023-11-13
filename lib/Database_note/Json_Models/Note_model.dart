class NoteModel {
  final int? noteId;
  final String nameOfTeacher;
  final String fatherName;
  final String lastName;
  final int bast;
  final int qadam;
  final int subjectOfBast;
  final int gradeOfEducation;
  final String fieldOfKnowledge;
  final int service;
  final int numberCode;
 // final int dateOfTaqrr;
  final int timeOfTeaches;
  final String placeOfTeaches;
  final int phoneNumber;
  final String createdAt;



  NoteModel({
    this.noteId,
    required this.nameOfTeacher,
    required this.fatherName,
    required this.lastName,
    required this.bast,
    required this.qadam,
    required this.subjectOfBast,
    required this.gradeOfEducation,
    required this.fieldOfKnowledge,
    required this.service,
    required this.numberCode,
   // required this.dateOfTaqrr,
    required this.timeOfTeaches,
    required this.placeOfTeaches,
    required this.phoneNumber,
    required this.createdAt,
  });

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
    noteId: json["noteId"],
    nameOfTeacher: json["nameOfTeacher"] as String,
    fatherName: json["fatherName"] as String,
    lastName: json["lastName"] as String,
    bast: json["bast"] as int,
    qadam: json["qadam"] as int,
    subjectOfBast: json["subjectOfBast"] as int,
    gradeOfEducation: json["gradeOfEducation"] as int,
    fieldOfKnowledge: json["fieldOfKnowledge"] as String,
    service: json["service"] as int,
    numberCode: json["numberCode"] as int,
  //  dateOfTaqrr: json["dateOfTaqrr"] as int,
    timeOfTeaches: json["timeOfTeaches"] as int,
    placeOfTeaches: json["placeOfTeaches"] as String,
      phoneNumber: json["phoneNumber"] as int,
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toMap() => {
    "noteId": noteId,
    "nameOfTeacher": nameOfTeacher,
    "fatherName": fatherName,
    "lastName": lastName,
    "bast": bast,
    "qadam": qadam,
    "subjectOfBast": subjectOfBast,
    "gradeOfEducation": gradeOfEducation,
    "fieldOfKnowledge": fieldOfKnowledge,
    "service": service,
    "numberCode": numberCode,
   // "dataOfTaqrr": dateOfTaqrr,
    "timeOfTeaches": timeOfTeaches,
    "placeOfTeaches": placeOfTeaches,
    "phoneNumber": phoneNumber,
    "createdAt": createdAt,
  };
}
