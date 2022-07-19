import 'package:highlark_keep_notes/model/notes_model.dart';
import 'package:highlark_keep_notes/services/firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDataBase {
  static Database? _database;
  NotesDataBase._privateConstructor();
  static final NotesDataBase instance = NotesDataBase._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initializedDB();
    return _database;
  }

  Future<Database> initializedDB() async {
    const pathName = "Note1.db";
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, pathName);
    return openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const boolType = "BOOL NOT NULL";

    await db.execute('''

    CREATE TABLE ${NotesImpName.tableName}(
     ${NotesImpName.id} $idType,
      ${NotesImpName.title} $textType,
       ${NotesImpName.uniqueId} $textType,
      ${NotesImpName.content} $textType,
      ${NotesImpName.pin} $boolType,
      ${NotesImpName.createTime} $textType,
      ${NotesImpName.isArchive} $boolType

    )
''');
  }

  Future<Notes?> insertData(Notes notes) async {
    await FirestoreDB().createNewNotesFirestore(notes);

    final db = await instance.database;
    final id = await db!.insert(NotesImpName.tableName, notes.toJson());

    return notes.copy(id: id);
  }

  Future<List<Notes>> readAllData() async {
    final db = await instance.database;
    const orderBy = "${NotesImpName.createTime} ASC";
    final queryRes = await db!.query(NotesImpName.tableName,
        orderBy: orderBy,
        where: " NOT  ${NotesImpName.pin} AND NOT  ${NotesImpName.isArchive} ");
    return queryRes.map((json) => Notes.fromJson(json)).toList();
  }

  Future<List<Notes>> readPinData() async {
    final db = await instance.database;
    const orderBy = "${NotesImpName.createTime} ASC";
    final queryRes = await db!.query(NotesImpName.tableName,
        orderBy: orderBy, where: NotesImpName.pin);
    return queryRes.map((json) => Notes.fromJson(json)).toList();
  }

  Future<List<Notes>> readArchiveData() async {
    final db = await instance.database;
    const orderBy = "${NotesImpName.createTime} ASC";
    final queryRes = await db!.query(NotesImpName.tableName,
        orderBy: orderBy, where: NotesImpName.isArchive);
    return queryRes.map((json) => Notes.fromJson(json)).toList();
  }

  Future updateNote(Notes notes) async {
    await FirestoreDB().updateNotes(notes);
    final db = await instance.database;
    await db!.update(NotesImpName.tableName, notes.toJson(),
        where: "${NotesImpName.id}=?", whereArgs: [notes.id]);
  }

//...........................................................................//
  // Future updatePin(Notes notes) async {
  //   final db = await instance.database;
  //   await db!.update(
  //       NotesImpName.tableName, {NotesImpName.pin: !notes.pin ? 1 : 0},
  //       where: "${NotesImpName.id}=?", whereArgs: [notes.id]);
  // }
//...........................................................................//
  // Future updateArchive(Notes notes) async {
  //   final db = await instance.database;
  //   await db!.update(
  //       NotesImpName.tableName, {NotesImpName.pin: !notes.isArchive ? 1 : 0},
  //       where: "${NotesImpName.id}=?", whereArgs: [notes.id]);
  // }
//...........................................................................//

  Future deleteNote(Notes notes) async {
    await FirestoreDB().deleteNotes(notes);
    final db = await instance.database;
    db!.delete(NotesImpName.tableName,
        where: "${NotesImpName.id}=?", whereArgs: [notes.id]);
  }

  Future deleteAllNote() async {
    final db = await instance.database;
    db!.delete(
      NotesImpName.tableName,
    );
  }

  Future closeDB() async {
    final db = await instance.database;
    await db!.close();
  }
}
