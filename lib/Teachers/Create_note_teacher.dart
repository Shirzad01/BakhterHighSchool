import 'package:flutter/material.dart';

import '../Database_note/Json_Models/Note_model.dart';
import '../Database_note/SQLite/Sqlite.dart';

class CreateNote_teacher extends StatefulWidget {
  const CreateNote_teacher({super.key});

  @override
  State<CreateNote_teacher> createState() => _CreateNote_teacherState();
}

class _CreateNote_teacherState extends State<CreateNote_teacher> {
  final name = TextEditingController();
  final fatherName = TextEditingController();
  final lastName = TextEditingController();
  final bast = TextEditingController();
  final qadam = TextEditingController();
  final subjectOfBast = TextEditingController();
  final gradeOfEducation = TextEditingController();
  final fieldOfKnowledge = TextEditingController();
  final service = TextEditingController();
  final numberCode = TextEditingController();
  final dateOfTaqrr = TextEditingController();
  final timeOfTeaches = TextEditingController();
  final placeOfTeaches = TextEditingController();
  final phoneNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ایجاد معلومات اساتید"),
        actions: [
          IconButton(
              onPressed: () {
                //Add Note button
                //We should not allow empty data to the database
                if (formKey.currentState!.validate()) {
                  db
                      .createNote(NoteModel(
                      nameOfTeacher: name.text,
                      fatherName: fatherName.text,
                      lastName: lastName.text,
                      bast: int.parse(bast.text),
                      qadam: int.parse(qadam.text),
                      subjectOfBast: int.parse(subjectOfBast.text),
                      gradeOfEducation: int.parse(gradeOfEducation.text),
                      fieldOfKnowledge: fieldOfKnowledge.text,
                      service: int.parse(service.text),
                      placeOfTeaches: placeOfTeaches.text,
                      numberCode: int.parse(numberCode.text),
                     // dateOfTaqrr: int.parse(dateOfTaqrr.text),
                      phoneNumber: int.parse(phoneNumber.text),
                      timeOfTeaches: int.parse(timeOfTeaches.text),
                      createdAt: DateTime.now().toIso8601String()))
                      .whenComplete(() {
                    //When this value is true
                    Navigator.of(context).pop(true);
                  });
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Form(
        //I forgot to specify key
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا اسم استاد را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("نام",),
                    ),
                  ),
                  TextFormField(
                    controller: fatherName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا نام پدر را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("نام پدر"),
                    ),
                  ),
                  TextFormField(
                    controller: lastName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا تخلص استاد را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text(" تخلص"),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: bast,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا بست را وارد نمائید نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("بست"),
                    ),
                  ),
                  TextFormField(
                    controller: qadam,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا قدم  را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("قدم",),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: subjectOfBast,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا عنوان بست را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("عنوان بست"),
                    ),
                  ),
                  TextFormField(
                    controller: fieldOfKnowledge,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا رشته تحصیلی خویش را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("رشته تحصیلی"),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: gradeOfEducation,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا درجه تحصیلی خویش را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("درجه تحصیلی"),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: service,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا مدت خدمت را معیین  نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("مدت خدمت"),
                    ),
                  ),
                  TextFormField(
                    controller: placeOfTeaches,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا محل وظیفه خویش را نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("محل وظیفه"),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: numberCode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا کود نمبر تشکیل خویش را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("کود نمبر تشکیل"),
                    ),
                  ),
                 /* TextFormField(
                    keyboardType: TextInputType.number,
                    controller: dateOfTaqrr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا تاریخ تقرر را معیین  نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("تاریخ تقرر"),
                    ),
                  ),

                  */
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneNumber,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا شماره تماس  را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("شماره تماس"),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: timeOfTeaches,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا تایم درسی را معیین نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("تایم درسی"),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}