import 'package:flutter/material.dart';
import 'package:newproject/Database_note/Json_Models/StudentNodeModel.dart';
import '../SQLite/Sqlite.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final principle = TextEditingController();
  final teacher = TextEditingController();
  final time = TextEditingController();
  final numberOfClass = TextEditingController();
  final numberClass = TextEditingController();
  final presents = TextEditingController();
  final absents = TextEditingController();
  final formKeys = GlobalKey<FormState>();

  final dbs = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ایجاد معلومات"),
        actions: [
          IconButton(
              onPressed: () {
                //Add Note button
                //We should not allow empty data to the database
                if (formKeys.currentState!.validate()) {
                  dbs
                      .createNoteStudent(StudentsNoteModel(
                          principle: principle.text,
                          teacher: teacher.text,
                           time: int.parse(time.text),
                          // numberClass: int.parse(numberClass.text),
                           presents: int.parse(presents.text),
                           absents: int.parse(absents.text),
                          createdAt: DateTime.now().toIso8601String()))
                      .whenComplete(() {
                    //When this value is true
                    Navigator.of(context).pop(true);
                  });
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Form(
          //I forgot to specify key
          key: formKeys,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: principle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا اسم سرمعلم مربوطه را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("سرمعلم مربوطه"),
                    ),
                  ),
                  TextFormField(
                    controller: teacher,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا اسم نگران صنف را وارد نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("نگران صنف"),
                    ),
                  ),
                   TextFormField(
                    controller: time,
                    keyboardType: TextInputType.number,
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
               /*  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: numberOfClass,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا تعداد صنف را معیین نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("تعداد صنف"),
                    ),
                  ),

                */
              TextFormField(
                    keyboardType: TextInputType.number,
                    controller: presents,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا تعداد حاضرین صنف را معیین نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("تعداد حاضرین"),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: absents,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "لطفا تعداد محرومین صنف را معیین نمائید";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("تعداد محرومین"),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
