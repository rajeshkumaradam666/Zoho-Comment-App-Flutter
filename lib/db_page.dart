import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  List<AppuserModel> appuserlist = [];
  List<CommentsModel> commentslist = [];

  int userid = 0;
  static const _databaseName = "CommandApp.db";
  static const _databaseVersion = 1;
  static const tableAppuser = 'Appuser';
  static const tableAppuserId = 'Id';
  static const tableAppuserEmail = 'Email';
  static const tableAppuserPassword = 'Password';
  static const tableAppuserSecret = 'Secret';
  static const tableAppusercommand = 'Commands';

  static const tablecomments = 'Commentstable';
  static const tablecommentsId = 'Id';
  static const tablecommentsUserRefId = 'UserRefId';
  static const tablecommentsEmail = 'Email';
  static const tablecommentscommand = 'Commands';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static late Database _database;
  Future<Database> get database async {
    // if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    // var obj =await _database.rawQuery("PRAGMA foreign_keys");
    // print(obj.toString());
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<int> dropDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // String path = join(databasesPath, _databaseName);

    deleteDatabase(path);
    return 0;
    // await db.close();
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
           CREATE TABLE IF NOT EXISTS $tableAppuser (
            $tableAppuserId INTEGER PRIMARY KEY AUTOINCREMENT,
            $tableAppuserEmail TEXT NOT NULL,
            $tableAppuserPassword  TEXT NOT NULL,
            $tableAppuserSecret  TEXT NOT NULL,
            $tableAppusercommand  TEXT  NULL          
          )
          ''');

    await db.execute('''
           CREATE TABLE IF NOT EXISTS $tablecomments (
            $tablecommentsId INTEGER PRIMARY KEY AUTOINCREMENT,
            $tablecommentsUserRefId INTEGER NOT NULL,
            $tablecommentsEmail TEXT NOT NULL,
            $tablecommentscommand  TEXT NOT NULL             
          )
          ''');
  }

  Future<QueryResponse> insertAppUser(Map<String, dynamic> objlist) async {
    Database db = await instance.database;
    try {
      await db.insert(tableAppuser, objlist);
      return QueryResponse(true, '');
    } catch (error) {
      return QueryResponse(false, error.toString());
    }
  }

  Future<QueryResponse> insertAppUsercomments(Map<String, dynamic> objlist) async {
    Database db = await instance.database;
    try {
      await db.insert(tablecomments, objlist);
      return QueryResponse(true, '');
    } catch (error) {
      return QueryResponse(false, error.toString());
    }
  }

  Future selectAppuser() async {
    try {
      appuserlist.clear();
      Database db = await instance.database;
      // ignore: prefer_adjacent_string_concatenation
      List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM $tableAppuser ' + '');
      appuserlist = result.map((element) => AppuserModel.fromJson(element)).toList();
    } catch (error) {
      if (error.toString() == "") {}
    }
  }

  Future selectcomments() async {
    try {
      commentslist.clear();
      Database db = await instance.database;
      // ignore: prefer_adjacent_string_concatenation
      List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM $tablecomments ' + '');
      commentslist = result.map((element) => CommentsModel.fromJson(element)).toList();
    } catch (error) {
      if (error.toString() == "") {}
    }
  }

  Future selectcommentsbyId(int id) async {
    try {
      // commentslist.clear();
      Database db = await instance.database;
      List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM $tablecomments where $tablecommentsUserRefId=' + id.toString() + '');
      commentslist = result.map((element) => CommentsModel.fromJson(element)).toList();
    } catch (error) {
      if (error.toString() == "") {}
    }
  }

  Future selectforgotpwd(String email, String secret) async {
    try {
      appuserlist.clear();
      Database db = await instance.database;
      List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM $tableAppuser  where $tableAppuserEmail=\'' + email + '\'  and $tableAppuserSecret=' + secret.toString() + '');
      appuserlist = result.map((element) => AppuserModel.fromJson(element)).toList();
    } catch (error) {
      if (error.toString() == "") {}
    }
  }

  Future<QueryResponse> updatecomments(
    int id,
    Map<String, dynamic> row,
  ) async {
    Database db = await instance.database;
    try {
      await db.update(tablecomments, row, where: '$tablecommentsId = ?', whereArgs: [id]);
      await selectcomments();
      return QueryResponse(true, '');
    } catch (error) {
      return QueryResponse(false, error.toString());
    }
  }
}
//model for whole project

class AppuserModel {
  // ignore: non_constant_identifier_names
  String Email;
  // ignore: non_constant_identifier_names
  String Password;
  // ignore: non_constant_identifier_names
  String Secret;
  // ignore: non_constant_identifier_names
  String Command;
  // ignore: non_constant_identifier_names
  int Id;

  AppuserModel(this.Email, this.Password, this.Secret, this.Command, this.Id);
  AppuserModel.fromJson(Map<String, dynamic> json)
      : Id = int.parse(json['Id'].toString()),
        Email = json['Email'] ?? '',
        Password = json['Password'] ?? '',
        Secret = json['Secret'] ?? '',
        Command = json['Command'] ?? '';
  // method
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'Email': Email,
      'Password': Password,
      'Secret': Secret,
      'Command': Command,
    };
  }
}

class CommentsModel {
  // ignore: non_constant_identifier_names
  String Email;

  // ignore: non_constant_identifier_names
  String Command;
  // ignore: non_constant_identifier_names
  int Id;
  // ignore: non_constant_identifier_names
  int UserRefId;

  CommentsModel(this.Email, this.Command, this.Id, this.UserRefId);
  CommentsModel.fromJson(Map<String, dynamic> json)
      : Id = int.parse(json['Id'].toString()),
        UserRefId = int.parse(json['UserRefId'].toString()),
        Email = json['Email'] ?? '',
        Command = json['Commands'] ?? '';
  // method
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'UserRefId': UserRefId,
      'Email': Email,
      'Command': Command,
    };
  }
}

//common Functions for whole Project
class QueryResponse {
  final bool result;
  final String message;
  QueryResponse(this.result, this.message);
}

void toastMsg(msg, value, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg + value.toString(),
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.black,
    duration: const Duration(seconds: 1),
  ));
}
