import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newproject/Teachers/Create_note_teacher.dart';

import '../../Database_note/Json_Models/Note_model.dart';
import '../../Database_note/SQLite/Sqlite.dart';

class Teachers extends StatefulWidget {
  const Teachers({super.key});

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  late DatabaseHelper handler;
  late Future<List<NoteModel>> notes;
  final db = DatabaseHelper();

  final nameOfTeacher = TextEditingController();
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
  final keyword = TextEditingController();




  @override
  void initState() {
    handler = DatabaseHelper();
    notes = handler.getNotes();

    handler.initDB().whenComplete(() {
      notes = getAllNotes();
    });
    super.initState();
  }

  Future<List<NoteModel>> getAllNotes() {
    return handler.getNotes();
  }

  //Search method here
  //First we have to create a method in Database helper class
  Future<List<NoteModel>> searchNote() {
    return handler.searchNotes(keyword.text);
  }

  //Refresh method
  Future<void> _refresh() async {
    setState(() {
      notes = getAllNotes();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("اساتید"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //We need call refresh method after a new note is created
            //Now it works properly
            //We will do delete now
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateNote_teacher()))
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
                controller: keyword,
                onChanged: (value) {
                  //When we type something in textfield
                  if (value.isNotEmpty) {
                    setState(() {
                      notes = searchNote();
                    });
                  } else {
                    setState(() {
                      notes = getAllNotes();
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
              child: FutureBuilder<List<NoteModel>>(
                future: notes,
                builder: (BuildContext context,
                    AsyncSnapshot<List<NoteModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text("No data"));
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    final items = snapshot.data ?? <NoteModel>[];
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            subtitle: Text(DateFormat("yMd").format(
                                DateTime.parse(items[index].createdAt))),
                            title: Text(items[index].nameOfTeacher),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: const Text("آیا میخواهید این معلومات را حذف نمائید"),
                                    actions: [
                                      MaterialButton(
                                          child: const Text("بله",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                                          onPressed: (){
                                            db
                                                .deleteNote(items[index].noteId!)
                                                .whenComplete(() {
                                              //After success delete , refresh notes
                                              //Done, next step is update notes
                                              _refresh();
                                            });
                                          }),
                                      MaterialButton(
                                          child: const Text("نخیر",style: TextStyle(color: Colors.indigo,fontSize: 20,fontWeight: FontWeight.bold),),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          })
                                    ],
                                  );
                                });
                                //We call the delete method in database helper
                              },
                            ),
                            onTap: () {
                              //When we click on note
                              setState(() {
                                nameOfTeacher.text = items[index].nameOfTeacher;
                                fatherName.text = items[index].fatherName;
                                lastName.text = items[index].lastName;
                                bast.text = items[index].bast.toString();
                                qadam.text = items[index].qadam.toString();
                                subjectOfBast.text = items[index].subjectOfBast.toString();
                                gradeOfEducation.text = items[index].gradeOfEducation.toString();
                                fieldOfKnowledge.text = items[index].fieldOfKnowledge.toString();
                                service.text = items[index].service.toString();
                                placeOfTeaches.text = items[index].placeOfTeaches.toString();
                                numberCode.text = items[index].numberCode.toString();
                                phoneNumber.text = items[index].phoneNumber.toString();
                                timeOfTeaches.text = items[index].timeOfTeaches.toString();
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
                                                  db
                                                      .updateNote(
                                                      nameOfTeacher.text,
                                                      fatherName.text,
                                                      lastName.text,
                                                      int.parse(bast.text),
                                                      int.parse(qadam.text),
                                                      int.parse(subjectOfBast.text),
                                                      fieldOfKnowledge.text,
                                                      int.parse(gradeOfEducation.text),
                                                      int.parse(service.text),
                                                      placeOfTeaches.text,
                                                      int.parse(numberCode.text),
                                                    //  int.parse(dateOfTaqrr.text),
                                                      int.parse(phoneNumber.text),
                                                      int.parse(timeOfTeaches.text),
                                                      items[index].noteId) 
                                                      .whenComplete(() {
                                                    //After update, note will refresh
                                                    _refresh();
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: const Text("Update"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                            ],
                                          ),
                                        ],
                                        title: const Text("Update note"),
                                        content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                controller: nameOfTeacher,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "لطفا اسم استاد را وارد نمائید";
                                                  }
                                                  return null;
                                                },
                                                decoration: const InputDecoration(
                                                  label: Text("نام"),
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
                                            /*  TextFormField(
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
