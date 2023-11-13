import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Json_Models/Note_model.dart';
import '../Json_Models/StudentNodeModel.dart';

class DatabaseHelper {
  final databaseName = "note.db";
  String noteTable =
      //Teacher Table
      "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, nameOfTeacher TEXT NOT NULL, fatherName TEXT NOT NULL, lastName TEXT, bast INTEGER, qadam INTEGER, subjectOfBast INTEGER, gradeOfEducation INTEGER, fieldOfKnowledge TEXT, service INTEGER, placeOfTeaches TEXT, numberCode INTEGER, phoneNumber INTEGER, timeOfTeaches INTEGER, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";
  //Student Table
  final dbName = "std.dbs";
  String studentTable =
      "CREATE TABLE students (id INTEGER PRIMARY KEY AUTOINCREMENT, principle TEXT NOT NULL, teacher TEXT NOT NULL, time INTEGER, numberClass INTEGER, presents INTEGER, absents INTEGER,  createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  //Teacher Method
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(noteTable);
    });
  }

  //Student Method
  Future<Database> initDBC() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return openDatabase(path, version: 1, onCreate: (dbs, version) async {
      await dbs.execute(studentTable);
    });
  }

  //Teacher Method
  //Search Method
  Future<List<NoteModel>> searchNotes(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db
        .rawQuery("select * from notes where nameOfTeacher LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  //Student Search Method
  Future<List<StudentsNoteModel>> searchNotesStudent(String keywords) async {
    final Database dbs = await initDBC();
    List<Map<String, Object?>> searchResult = await dbs.rawQuery(
        "select * from students where principle LIKE ?", ["%$keywords%"]);
    return searchResult.map((e) => StudentsNoteModel.fromMap(e)).toList();
  }

  //CRUD Methods

  //Teacher Create Note
  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  //Student Create Note
  Future<int> createNoteStudent(StudentsNoteModel students) async {
    final Database dbs = await initDBC();
    return dbs.insert('students', students.toMap());
  }

  // Teacher Get notes
  Future<List<NoteModel>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  // Student Get Notes
  Future<List<StudentsNoteModel>> getNotesStudent() async {
    final Database dbs = await initDBC();
    List<Map<String, Object?>> result = await dbs.query('students');
    return result.map((e) => StudentsNoteModel.fromMap(e)).toList();
  }

  // Teacher Delete Notes
  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

  // Student Delete Notes
  Future<int> deleteNoteStudent(int id) async {
    final Database dbs = await initDBC();
    return dbs.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  // Teacher Update Notes
  Future<int> updateNote( nameOfTeacher, fatherName, lastName, bast, qadam, noteId, fieldOfKnowledge, subjectOfBast , gradeOfEducation , service , placeOfTeaches , numberCode ,  phoneNumber , timeOfTeaches ,) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update notes set nameOfTeacher = ?, fatherName = ?, lastName =?, bast = ?, qadam = ?, fieldOfKnowledge = ?, subjectOfBast = ?,  gradeOfEducation = ?, service = ?, placeOfTeaches = ?, numberCode = ?, phoneNumber =?, timeOfTeaches = ?  where noteId = ?',
        [ nameOfTeacher, fatherName, lastName, bast, qadam, fieldOfKnowledge, subjectOfBast, gradeOfEducation, service, placeOfTeaches, numberCode, phoneNumber, timeOfTeaches, noteId ]);
  }

  //Students Update Notes
  Future<int> updateNoteStudent( principle, teacher, time, numberClass, presents, absents, id,) async {
    final Database dbs = await initDBC();
    return dbs.rawUpdate(
        'update students set principle = ?, teacher = ?, time = ?,numberClass =?, presents =?, absents = ?  where id = ?',
        [ principle, teacher, time, numberClass,presents, absents, id,
        ]);
  }
}