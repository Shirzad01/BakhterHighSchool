class StudentsNoteModel {
  final int? id;
  final String principle;
  final String teacher;
  final int time;
 // final int numberClass;
  final int presents;
  final int absents;
  final String createdAt;

  StudentsNoteModel({
    this.id,
    required this.principle,
    required this.teacher,
    required this.time,
   // required this.numberClass,
    required this.presents,
    required this.absents,
    required this.createdAt});

  factory StudentsNoteModel.fromMap(Map<String, dynamic> json) =>
      StudentsNoteModel(
          id: json["id"] as int,
          principle: json["principle"] as String,
          teacher: json["teacher"] as String,
          time: json["time"] as int,
     //     numberClass: json["numberClass"] as int,
          presents: json["presents"] as int,
          absents: json["absents"] as int,
          createdAt: json["createdAt"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "principle": principle,
        "teacher": teacher,
        "time": time,
      //  "numberClass": numberClass,
        "presents": presents,
        "absents": absents,
        "createdAt": createdAt,
      };
}
