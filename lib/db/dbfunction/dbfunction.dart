import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:crypto/crypto.dart';
// import 'package:encrypt/encrypt.dart';
// import 'package:encrypt/encrypt.dart';
// import 'package:encrypt/encrypt.dart';
// import 'package:encrypt/encrypt.dart';
// import 'package:encrypt/encrypt.dart';
// import 'package:flutter/foundation.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../copydbfun.dart'; // Ensure this is your path to copydbfun.dart

class SecureStorage {
  final _storage = FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }
}

var key = encrypt.Key.fromUtf8(
    'my32lengthsupersecretnooneknows1'); // 32 chars for AES-256
final iv = encrypt.IV.fromUtf8('16lengthsuperivv');

class EncryptionHelper {
  // final String key;

  // EncryptionHelper(this.key);

  String encryptdata(String data) {
    // final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(data, iv: iv);

    // final encrypted = encrypter.encrypt(data);
    return encrypted.base64;
  }

  String decryptdata(String encryptedData) {
    // final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    // final decrypted = encrypter.decrypt64(encryptedData);
    return decrypted;
  }
}

class DbHandler {
  Database? _database;
  final SecureStorage _secureStorage = SecureStorage();
  final String _dbName = 'sayakdb.db';
  final String _keyStorageName = 'db_encryption_key';
  late EncryptionHelper _encryptionHelper = EncryptionHelper();

  Future<Database?> get fninitializeDB async {
    String path = await fndbpath();

    // Get or create the encryption key
    String? key = await _secureStorage.readSecureData(_keyStorageName);
    if (key == null) {
      key = base64UrlEncode(List<int>.generate(
          32, (i) => i + 1)); // Example key generation, replace with your own
      await _secureStorage.writeSecureData(_keyStorageName, key);
    }

    // _encryptionHelper = EncryptionHelper(key);

    _database = await openDatabase(
      join(path, _dbName),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE UserLogin(email TEXT, phoneNumber TEXT, token TEXT)");
      },
      version: 1,
    );
    return _database;
  }

  Future<void> createLogintable() async {
    Database? db = await fninitializeDB;
    await db!.execute(
        "CREATE TABLE UserLogin(email TEXT, phoneNumber TEXT, token TEXT)");
  }

  Future<void> createMyPackagetable() async {
    Database? db = await fninitializeDB;
    await db!.execute('''
      CREATE TABLE MyPackages(
        packageid TEXT,
        packagename TEXT,
        package_structure TEXT,
        package_img TEXT,
        package_logo TEXT,
        package_validity TEXT
      )
    ''');
  }

  Future<int> insertLoginData(
      String email, String phoneNumber, String token) async {
    Database? db = await fninitializeDB;
    return await db!.insert(
      'UserLogin',
      {
        'email': _encryptionHelper.encryptdata(email),
        'phoneNumber': _encryptionHelper.encryptdata(phoneNumber),
        'token': _encryptionHelper.encryptdata(token),
      },
    );
  }

  Future<int> insertMyPackageData(
      String packageid,
      String packagename,
      String package_structure,
      String package_img,
      String package_logo,
      String package_validity) async {
    Database? db = await fninitializeDB;
    return await db!.insert(
      'MyPackages',
      {
        'packageid': _encryptionHelper.encryptdata(packageid),
        'packagename': _encryptionHelper.encryptdata(packagename),
        'package_structure': _encryptionHelper.encryptdata(package_structure),
        'package_img': _encryptionHelper.encryptdata(package_img),
        'package_logo': _encryptionHelper.encryptdata(package_logo),
        'package_validity': _encryptionHelper.encryptdata(package_validity),
      },
    );
  }

  Future<List<Map<String, dynamic>>> readData(String tablename) async {
    Database? db = await fninitializeDB;
    final list = await db!.query(
      tablename,
      distinct: true,
      limit: 3,
    );
    // for (int i = 0; i < list.length; i++) {
    //   list[i].updateAll(
    //       (key, value) => _encryptionHelper.decryptdata(value));
    //   if (kDebugMode) {
    //     print('${list[i]}\n');
    //   }
    // }

    return list;
  }

/*
Database? db = await fninitializeDB;
    DbHandler dbHandler = DbHandler();
    await dbHandler.fninitializeDB;

    List<Map<String, dynamic>> userList = await dbHandler.readData('UserLogin');
    String email = "";
    String phoneNumber = "";
    String token = "";
    for (Map<String, dynamic> user in userList) {
      email = dbHandler._encryptionHelper.decryptdata(user['email']);
      phoneNumber =
          dbHandler._encryptionHelper.decryptdata(user['phoneNumber']);
      token = dbHandler._encryptionHelper.decryptdata(user['token']);

      print('Decrypted User Data:');
      print('Email: $email');
      print('Phone Number: $phoneNumber');
      print('Token: $token');
    }
    return [
      {'email': '$email'}
    ];
*/
  closedb() async {
    Database? db = await fninitializeDB;
    db?.close();
  }

  Future<bool> doesDatabaseExist(String dbName) async {
    try {
      var databasesPath = await fndbpath();
      String dbPath = join(databasesPath, dbName);
      return await File(dbPath).exists();
    } catch (e) {
      print('Error checking if database exists: $e');
      return false;
    }
  }

  Future<void> backupDatabase() async {
    String path = await fndbpath();
    String dbPath = join(path, _dbName);
    File dbFile = File(dbPath);
    // Implement your backup logic here, e.g., upload to cloud storage
    // Example: await uploadToCloud(dbFile);
  }

  // Example function to demonstrate usage (replace with actual backup logic)
  Future<void> uploadToCloud(File file) async {
    // Implement your cloud upload logic here
    print('Uploading ${file.path} to cloud...');
  }

  // Method to check if the database file exists periodically
  Future<void> checkDatabaseExistence() async {
    String path = await fndbpath();
    String dbPath = join(path, _dbName);
    bool exists = await File(dbPath).exists();
    if (!exists) {
      print('Database file does not exist. Performing recovery...');
      // Perform recovery or re-initialize the database
      await fninitializeDB;
    }
  }

  // Method to delete the database file (for testing purposes)
  Future<void> deleteDatabaseFile() async {
    String path = await fndbpath();
    String dbPath = join(path, _dbName);
    File dbFile = File(dbPath);
    if (await dbFile.exists()) {
      await dbFile.delete();
      print('Database file deleted.');
    }
  }
}
