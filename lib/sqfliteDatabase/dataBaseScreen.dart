import 'package:sqflite/sqflite.dart';

var database;
List newtasks = [];

void createDatabase() async {
  database = await openDatabase(
    'todo.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)',
      );
      
      print('Database Created');
    },
    onOpen: (db) async {
      await getDataFromDatabase(db).then((value) {
        newtasks = List.from(value);
        print('Tasks loaded: $newtasks');
      });
      print('Database Opened');
    },
  );
}

Future<void> insertToDatabase({
  required String title,
  required String date,
  required String time,
}) async {
  await database.transaction((txn) async {
    try {
      int id = await txn.rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES(?, ?, ?, ?)',
        [title, date, time, 'new'
        ],
      );
      print('$id inserted Successfully');

      // Reload tasks after inserting a new task
      await getDataFromDatabase(database).then((value) {
        newtasks = List.from(value);
        print('Tasks loaded: $newtasks');
      });
    } catch (error) {
      print('Error when inserting database: ${error.toString()}');
    }
  });
}

Future<List<Map<String, dynamic>>> getDataFromDatabase(database) async {
  return await database.rawQuery('SELECT * FROM tasks');
}
