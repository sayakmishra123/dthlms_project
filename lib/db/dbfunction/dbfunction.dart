// import 'package:sqflite_sqlcipher/sqflite.dart';
// Add this import for SQLCipher support
// import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart'; // Add this import

// class DbHandler {
//   Database? _database;
//   final String _dbName = 'sayakdb.db';
//   final String password =
//       "your_secure_password"; // Replace with secure management

//   Future<String> fndbpath() async {
//     var databasesPath = await getDatabasesPath();
//     return databasesPath;
//   }

//   Future<Database?> get fninitializeDB async {
//     if (_database != null) return _database;

//     String path = await fndbpath();
//     path = join(path, _dbName);

//     _database = await openDatabase(
//       path,
//       // Manually configure encryption
//       onCreate: (db, version) async {
//         await db.execute(
//             "CREATE TABLE UserLogin(email TEXT, phoneNumber TEXT, token TEXT)");
//         await db.execute('''
//           CREATE TABLE MyPackages(
//             packageid TEXT,
//             packagename TEXT,
//             package_structure TEXT,
//             package_img TEXT,
//             package_logo TEXT,
//             package_validity TEXT
//           )
//         ''');
//       },
//       version: 1,
//     );

//     // Encrypt the database
//     await _database?.execute('PRAGMA key = "$password";');

//     return _database;
//   }

//   // Future<void> createLogintable() async {
//   //   Database? db = await fninitializeDB;
//   //   await db!.execute(
//   //       "CREATE TABLE UserLogin(email TEXT, phoneNumber TEXT, token TEXT)");
//   // }

//   // Future<void> createMyPackagetable() async {
//   //   Database? db = await fninitializeDB;
//   //   await db!.execute('''
//   //     CREATE TABLE MyPackages(
//   //       packageid TEXT,
//   //       packagename TEXT,
//   //       package_structure TEXT,
//   //       package_img TEXT,
//   //       package_logo TEXT,
//   //       package_validity TEXT
//   //     )
//   //   ''');
//   // }

//   // Future<int> insertLoginData(
//   //     String email, String phoneNumber, String token) async {
//   //   Database? db = await fninitializeDB;
//   //   return await db!.insert(
// 'UserLogin',
// {
//   'email': email,
//   'phoneNumber': phoneNumber,
//   'token': token,
// },
//   //   );
//   // }

//   // Future<int> insertMyPackageData(
//   //     String packageid,
//   //     String packagename,
//   //     String package_structure,
//   //     String package_img,
//   //     String package_logo,
//   //     String package_validity) async {
//   //   Database? db = await fninitializeDB;
//   //   return await db!.insert(
//   //     'MyPackages',
//   //     {
//   //       'packageid': packageid,
//   //       'packagename': packagename,
//   //       'package_structure': package_structure,
//   //       'package_img': package_img,
//   //       'package_logo': package_logo,
//   //       'package_validity': package_validity,
//   //     },
//   //   );
//   // }

//   // Future<List<Map<String, dynamic>>> readData(String tablename) async {
//   //   Database? db = await fninitializeDB;
//   //   final list = await db!.query(
//   //     tablename,
//   //     distinct: true,
//   //     limit: 3,
//   //   );
//   //   return list;
//   // }

//   // Future<void> closedb() async {
//   //   Database? db = await fninitializeDB;
//   //   db?.close();
//   // }

//   Future<bool> doesDatabaseExist(String dbName) async {
//     try {
//       var databasesPath = await fndbpath();
//       String dbPath = join(databasesPath, dbName);
//       return await File(dbPath).exists();
//     } catch (e) {
//       print('Error checking if database exists: $e');
//       return false;
//     }
//   }

//   // Future<void> backupDatabase() async {
//   //   String path = await fndbpath();
//   //   String dbPath = join(path, _dbName);
//   //   File dbFile = File(dbPath);
//   //   // Implement your backup logic here, e.g., upload to cloud storage
//   //   // Example: await uploadToCloud(dbFile);
//   // }

//   // Future<void> uploadToCloud(File file) async {
//   //   // Implement your cloud upload logic here
//   //   print('Uploading ${file.path} to cloud...');
//   // }

//   // Future<void> deleteDatabaseFile() async {
//   //   String path = await fndbpath();
//   //   String dbPath = join(path, _dbName);
//   //   File dbFile = File(dbPath);
//   //   if (await dbFile.exists()) {
//   //     await dbFile.delete();
//   //     print('Database file deleted.');
//   //   }
//   // }

// }

import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:sqlite3/sqlite3.dart' as sql;

late sql.Database _db;

/// Create crypted database on Windows
void testSQLCipherOnWindows() async {
  //Create DB with password

  final String password = "test";
  //Local DB file path
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  String filename = "$appDocPath${Platform.pathSeparator}testDB.sqlite";
  print(filename);

  _db = sql.sqlite3.open(
    filename,
    mode: sql.OpenMode.readWriteCreate,
  );
  if (_db.handle.address > 0) {
    print("Database created here: $filename");
    _db.execute(
      "PRAGMA key = '$password'",
    );
    print("Database password set: $password");
  }
  getVersion();
  createLoginTable();
}

void getVersion() {
  final sql.ResultSet resultSet = _db.select("SELECT sqlite_version()");
  resultSet.forEach((element) {
    print(element);
  });

  final sql.ResultSet resultSet2 = _db.select("PRAGMA cipher_version");
  resultSet2.forEach((element) {
    print(element);
  });
}

///Create Schema
void createLoginTable() {
  // Create a table and insert some data
  _db.execute('''
   CREATE TABLE IF NOT EXISTS UserLogin(email TEXT, phoneNumber TEXT, token TEXT);
  ''');
}

Future<void> insertLogindataa(
    String email, String phoneNumber, String token) async {
  _db.execute('''
       INSERT INTO UserLogin (email, phoneNumber, token) 
      VALUES ('$email', '$phoneNumber', '$token');
    ''');

  // return null;
}

Future<void> readLoginData() async {
  final sql.ResultSet resultSet = _db.select('SELECT * FROM UserLogin');
  resultSet.forEach((row) {
    print(
        'Email: ${row['email']}, Phone Number: ${row['phoneNumber']}, Token: ${row['token']}');
  });
}
