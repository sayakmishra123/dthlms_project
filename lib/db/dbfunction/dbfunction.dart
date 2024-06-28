// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqflite.dart';

import '../copydbfun.dart';

class DbHandler {
  Database? _database;

  Future<Database?> get fninitializeDB async {
    String path = await fndbpath();

    // ignore: prefer_interpolation_to_compose_strings
    print(path + "/sayakdb.db");
    _database = await openDatabase(
      join(path, 'sayakdb.db'),
    );

    print(_database);
    return _database;
  }

  insertLoginData(String email, String ph, String token) async {
    Database? db = await fninitializeDB;

    return await db!.insert(
        'UserLogin', {'email': email, 'phoneNumber': ph, 'token': token});
  }

  readData() async {
    Database? db = await fninitializeDB;
    print(db!.database);
    final list = await db.query(
      'UserLogin',
      distinct: true,
      limit: 3,
    );
    for (int i = 0; i < list.length; i++) {
      if (kDebugMode) {
        print('${list[i]}\n');
      }
    }
    return list;
  }

  Future<bool> doesDatabaseExist(String dbName) async {
    try {
      // Get the default database path
      var databasesPath = await fndbpath();
      String dbPath = join(databasesPath, dbName);
      print(dbPath);
      print(await File(dbPath).exists());
      // Check if the database file exists
      return await File(dbPath).exists();
    } catch (e) {
      print('Error checking if database exists: $e');
      return false;
    }
  }

  createLogintable(String path) async {
    return await openDatabase(join(path, 'sayakdb.db'),
        onCreate: (db, version) {
      db.execute(
          "CREATE TABLE UserLogin(email TEXT,phoneNumber INTEGER,token TEXT)");
    }, version: 1);
  }

  createMyPackagetable() async {
    String path = await fndbpath();
    return await openDatabase(join(path, 'sayakdb.db'),
        onCreate: (db, version) {
      db.execute('''
      CREATE TABLE MyPackages(
        packageid INTEGER,
        packagename TEXT,
        package_structure TEXT,
        package_img TEXT,
        package_logo TEXT,
        package_validity DATE
      )
    ''');
    });
  }

  insertMyPackageData(email, ph, package_structure, package_img, package_logo,
      package_validity) async {
    Database? db = await fninitializeDB;

    return await db!.insert('MyPackages', {
      'packageid': email,
      'packagename': ph,
      'package_structure': package_structure,
      'package_img': package_img,
      'package_logo': package_logo,
      'package_validity': package_validity
    });
  }
}
