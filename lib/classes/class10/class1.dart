import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newproject/Database_note/Json_Models/StudentNodeModel.dart';
import 'package:newproject/helper_class.dart';
import '../../Database_note/SQLite/Sqlite.dart';
import '../../Database_note/Views/Create_note_Student.dart';

class class_10_1 extends StatefulWidget {
  const class_10_1({super.key});

  @override
  State<class_10_1> createState() => _class_10_1State();
}

class _class_10_1State extends State<class_10_1> {
  late DatabaseHelper handlers;
  late Future<List<StudentsNoteModel>> students;
  final dbs = DatabaseHelper();

  final principle = TextEditingController();
  final teacher = TextEditingController();
  final time = TextEditingController();
  final numberClass = TextEditingController();
  final presents = TextEditingController();
  final absents = TextEditingController();
  final keywords = TextEditingController();

  @override
  void initState() {
    handlers = DatabaseHelper();
    students = handlers.getNotesStudent();

    handlers.initDBC().whenComplete(() {
      students = getAllNotesStudent();
    });
    super.initState();
  }

  Future<List<StudentsNoteModel>> getAllNotesStudent() {
    return handlers.getNotesStudent();
  }

  //Search method here
  //First we have to create a method in Database helper class
  Future<List<StudentsNoteModel>> searchNotesStudent() {
    return handlers.searchNotesStudent(keywords.text);
  }

  //Refresh method
  Future<void> _refresh() async {
    setState(() {
      students = getAllNotesStudent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("شاگردان"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //We need call refresh method after a new note is created
            //Now it works properly
            //We will do delete now
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CreateNote()))
                .then((value) {
              if (value) {
                //This will be called
                _refresh();
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            //Search Field here
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: keywords,
                onChanged: (value) {
                  //When we type something in textfield
                  if (value.isNotEmpty) {
                    setState(() {
                      students = searchNotesStudent();
                    });
                  } else {
                    setState(() {
                      students = getAllNotesStudent();
                    });
                  }
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                    hintText: "Search"),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<StudentsNoteModel>>(
                future: students,
                builder: (BuildContext context,
                    AsyncSnapshot<List<StudentsNoteModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text("No data"));
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    final item = snapshot.data ?? <StudentsNoteModel>[];
                    return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            subtitle: Text(DateFormat("yMd")
                                .format(DateTime.parse(item[index].createdAt))),
                            title: Text(item[index].principle),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("آیا مطمعین هستید؟",textAlign: TextAlign.right,),
                                        content:
                                            const Text("این معلومات را حذف نماید",textAlign: TextAlign.right,),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              dbs
                                                  .deleteNoteStudent(
                                                      item[index].id!)
                                                  .whenComplete(
                                                () {
                                                  //After success delete , refresh notes
                                                  //Done, next step is update notes
                                                  _refresh();
                                                },
                                              );
                                            },
                                            color: Colors.indigo,
                                            child: const Text("بله",style: TextStyle(color: Colors.white),),
                                          ),
                                          MaterialButton(
                                              child: const Text("نخیر",style: TextStyle(color: Colors.white),),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            color: Colors.indigo,
                                          )
                                        ],
                                      );
                                    }
                                    );
                                //We call the delete method in database helper
                              },
                            ),
                            onTap: () {
                              //When we click on note
                              setState(() {
                                principle.text = item[index].principle;
                                teacher.text = item[index].teacher;
                                time.text = item[index].time.toString();
                              //  numberClass.text = item[index].numberClass.toString();
                                presents.text = item[index].presents.toString();
                                absents.text = item[index].absents.toString();
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: AlertDialog(
                                        actions: [
                                          Row(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  //Now update method
                                                  dbs
                                                      .updateNoteStudent(
                                                          principle.text,
                                                          teacher.text,
                                                          int.tryParse(time.text),
                                                          int.tryParse(numberClass.text),
                                                          int.tryParse(presents.text),
                                                          int.tryParse(absents.text),
                                                          item[index].id)
                                                      .whenComplete(() {
                                                    //After update, note will refresh
                                                    _refresh();
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text("به روزرسانی"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("لغو"),
                                              ),
                                            ],
                                          ),
                                        ],
                                        title: const Text(
                                            "به روزرسانی معلومات شاگردان"),
                                        content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                controller: principle,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "لطفا اسم سرمعلم مربوطه را وارد نمائید";
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
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
                                                decoration:
                                                    const InputDecoration(
                                                  label: Text("نگران صنف"),
                                                ),
                                              ),
                                               TextFormField(
                                                controller: time,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "لطفا تایم درسی را معیین نمائید";
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  label: Text("تایم درسی"),
                                                ),
                                              ),
                                              TextFormField(
                                                controller: presents,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "لطفا تعداد حاضرین صنف را معیین نمائید";
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  label: Text("تعداد حاضرین"),
                                                ),
                                              ),
                                              TextFormField(
                                                controller: absents,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "لطفا تعداد محرومین صنف را معیین نمائید";
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  label: Text("تعداد محرومین"),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    );
                                  });
                            },
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ));
  }
}
