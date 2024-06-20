import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_app/model/todo_list_model.dart';

class DataBaseHelper {

   static final DataBaseHelper _instance = DataBaseHelper._internal();
   factory DataBaseHelper() => _instance;
   DataBaseHelper._internal();

   static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(
      path, 
      version: 1, 
      onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      isCompleted INTEGER NOT NULL
    )
    ''');
  }

  Future<int> insertTask(TodoTaskModel todoTaskModel) async {
    Database? db = await database;
    return await db!.insert('tasks', todoTaskModel.toMap());
  }

  Future<List<TodoTaskModel>> queryAllTasks() async {
    Database? db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('tasks', distinct: true);

    return List.generate(maps.length, (index) {
      return TodoTaskModel.fromMap(maps[index]);
    });
  }
  

Future<int> updateTask(TodoTaskModel task) async {
    final db = await _instance.database;
    return await db!.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }


 Future<int> deleteTask(int id) async {
  Database? db = await database;
  return await db!.delete('tasks', where: 'id = ?', whereArgs: [id]);
}
}
