import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:thoughts_down/persist/db_model.dart';

class Sqflite {
  var database;

  Future<Database> get _database async {
    if (database != null) {
      return database;
    } else {
      await init();
      return database;
    }
  }

  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    database =
        openDatabase(join(await getDatabasesPath(), 'thought_database.db'),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE thought(id INTEGER PRIMARY KEY AUTOINCREMENT, create_time DateTime, `text` text)');
    }, version: 1);
  }

  Future<int> insertThought(ThoughtModel thought) async {
    final db = await _database;
    Map<String, Object> param = {
      "create_time": thought.createTime,
      "text": thought.text
    };
    int data = await db.insert("thought", param);
    print("insert data:" + thought.text);
    return data;
  }

  Future<List<ThoughtModel>> thoughts() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps =
        await db.query('thought', orderBy: "id desc");
    print("fetch all data:");
    return List.generate(maps.length, (i) {
      return ThoughtModel(
        maps[i]['create_time'],
        maps[i]['text'],
      );
    });
  }

  Future<void> deleteAll() async {
    print("delete all data!!!!");
    final db = await _database;
    await db.delete('thought', where: 'id>=0');
  }
}
