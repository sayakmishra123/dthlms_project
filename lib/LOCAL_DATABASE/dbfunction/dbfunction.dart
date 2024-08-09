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
  createTblEncryptionHistory();
  createtblChapter();
  createtblFileDetails();
  createtblSectionFilesDetails();
  createtblMyPackage();
  createtblPackageDetails();
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

///Create Schema
void createtblChapter() {
  // Create a table and insert some data
  _db.execute('''
   CREATE TABLE IF NOT EXISTS TblChapter(ChapterId TEXT, ChapterName TEXT, PackageId TEXT,ParentId TEXT, FileType TEXT);
  ''');
  // log()
  print('tblchapter');
}

void createTblEncryptionHistory() {
  // Create a table and insert some data
  _db.execute('''
   CREATE TABLE IF NOT EXISTS TblEncryptionHistory(FileId TEXT, FileType TEXT, FileName TEXT, FileDuration TEXT,FileDescription TEXT,SortedOrder TEXT,FromDateTime TEXT,UptoDateTime TEXT,ThumbnailImage TEXT,LiveId TEXT,LiveUrl TEXT,PackageId TEXT,FranchiseId TEXT,UserId TEXT,SectionChapterId TEXT);
  ''');
  print('tblfile table');
}

void createtblFileDetails() {
  // Create a table and insert some data
  _db.execute('''
   CREATE TABLE IF NOT EXISTS TblFileDetails(FileId TEXT, FileDetailsId TEXT, FileName TEXT, FileType TEXT,Option1 TEXT,Option2 TEXT,Option3 TEXT,Option4 TEXT,VideoTime TEXT,Answer TEXT,Category TEXT,TagName TEXT, DocumentPath TEXT,SortedOrder TEXT,IsVideoCompulsory TEXT,IsChapterCompulsory TEXT,PreviousVideoId TEXT,MinimumVideoDuration TEXT,PackageId TEXT,PreviousChapterId TEXT);
  ''');
  print('tblFileDetails table');
}

void createtblMyPackage() {
  // Create a table and insert some data
  _db.execute('''
   CREATE TABLE IF NOT EXISTS TblMyPackage(UserId TEXT, PackageName TEXT, PackageId TEXT PRIMARY KEY, CourseName TEXT, CourseId TEXT, TermId TEXT, TermName TEXT, ValidUpto TEXT, ValidFrom TEXT, FranchiseId INTEGER, ActivationId TEXT);
  ''');
  // log()
  print('tblMyPackage');
}

void createtblPackageDetails() {
  // Create a table and insert some data
  _db.execute('''
      CREATE TABLE IF NOT EXISTS TblPackageDetails (
        PackageId TEXT PRIMARY KEY,
        NodeId TEXT,
        NodeName TEXT,
        NodeOptionId TEXT,
        NodeOptionName TEXT,
        SortedOrder INTEGER,
        FranchiseId TEXT,
        UserId TEXT
      )
      ''');

  // log()
  print('PackageDetails');
}

void createtblSectionFilesDetails() {
  // Create a table and insert some data
  _db.execute('''
          CREATE TABLE IF NOT EXISTS TblSectionFilesDetails(
            SectionChapterId TEXT PRIMARY KEY,
            SectionChapterName TEXT,
            SortedOrder TEXT
          )
          ''');
  // log()
  print('tblSectionFilesDetails');
}

Future<void> insertLogindataa(
    String email, String phoneNumber, String token) async {
  _db.execute('''
       INSERT INTO UserLogin (email, phoneNumber, token) 
      VALUES ('$email', '$phoneNumber', '$token');
    ''');

  // return null;
}

Future<void> inserttblChapter(String chapterId, String chapterName,
    String packageId, String parentId, String fileType) async {
  _db.execute('''
       INSERT INTO TblChapter (ChapterId, ChapterName, PackageId,ParentId,FileType) 
      VALUES ('$chapterId', '$chapterName', '$packageId','$parentId','$fileType');
    ''');
}

Future<void> insertTblEncryptionHistory(
    String fileId,
    String fileType,
    String fileName,
    String fileDuration,
    String fileDescription,
    String sortedOrder,
    String fromDateTime,
    String uptoDateTime,
    String thumbnailImage,
    String liveId,
    String liveUrl,
    String packageId,
    String franchiseId,
    String userId,
    String sectionChapterId) async {
  _db.execute('''
       INSERT INTO TblEncryptionHistory (FileId, FileType, FileName,FileDuration,FileDescription,SortedOrder,FromDateTime,UptoDateTime,ThumbnailImage,LiveId,LiveUrl,PackageId,FranchiseId,UserId,SectionChapterId) 
      VALUES ('$fileId', '$fileType', '$fileName','$fileDuration','$fileDescription','$sortedOrder','$fromDateTime','$uptoDateTime','$thumbnailImage','$liveId','$liveUrl','$packageId','$franchiseId','$userId'.'$sectionChapterId');
    ''');
}

Future<void> insertTblFileDetails(
  String fileId,
  String fileDetailsId,
  String fileName,
  String fileType,
  String option1,
  String option2,
  String option3,
  String option4,
  String videoTime,
  String answer,
  String category,
  String tagName,
  String documentPath,
  String sortedOrder,
  String isVideoCompulsory,
  String isChapterCompulsory,
  String previousVideoId,
  String minimumVideoDuration,
  String packageId,
  String previousChapterId,
) async {
  _db.execute('''
    INSERT INTO TblFileDetails (
      FileId,
      FileDetailsId,
      FileName,
      FileType,
      Option1,
      Option2,
      Option3,
      Option4,
      VideoTime,
      Answer,
      Category,
      TagName,
      DocumentPath,
      SortedOrder,
      IsVideoCompulsory,
      IsChapterCompulsory,
      PreviousVideoId,
      MinimumVideoDuration,
      PackageId,
      PreviousChapterId
    ) VALUES (
      '$fileId',
      '$fileDetailsId',
      '$fileName',
      '$fileType',
      '$option1',
      '$option2',
      '$option3',
      '$option4',
      '$videoTime',
      '$answer',
      '$category',
      '$tagName',
      '$documentPath',
      '$sortedOrder',
      '$isVideoCompulsory',
      '$isChapterCompulsory',
      '$previousVideoId',
      '$minimumVideoDuration',
      '$packageId',
      '$previousChapterId'
    );
  ''');
  print('Inserted data into TblFileDetails');
}

Future<void> readLoginData() async {
  final sql.ResultSet resultSet = _db.select('SELECT * FROM UserLogin');
  resultSet.forEach((row) {
    print(
        'Email: ${row['email']}, Phone Number: ${row['phoneNumber']}, Token: ${row['token']}');
  });
}
