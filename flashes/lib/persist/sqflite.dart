import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flashes/persist/db_model.dart';

Sqflite sqfliteInstance = Sqflite();

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
    database = openDatabase(
      join(await getDatabasesPath(), 'thought_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE thought(id INTEGER PRIMARY KEY AUTOINCREMENT, create_time DateTime, `text` text, `image_paths_str` text)');
      },
      version: 1,
    );
  }

  Future<int> insertThought(ThoughtModel thought) async {
    final db = await _database;
    Map<String, Object> param = {
      "create_time": thought.createTime,
      "text": thought.text,
      "image_paths_str": thought.imagePathsStr!,
    };
    int data = await db.insert("thought", param);
    log("insert data:" + thought.text + thought.imagePathsStr!);
    return data;
  }

  Future<List<ThoughtModel>> thoughts() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps =
        await db.query('thought', orderBy: "id desc");
    log("fetch all data:");
    return List.generate(maps.length, (i) {
      return ThoughtModel(
        maps[i]['create_time'],
        maps[i]['text'],
        maps[i]['image_paths_str'],
      );
    });
  }

  Future<void> deleteAll() async {
    log("delete all data!!!!");
    final db = await _database;
    await db.delete('thought', where: 'id>=0');
  }
}
