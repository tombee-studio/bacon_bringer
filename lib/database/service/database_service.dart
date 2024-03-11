import 'package:bacon_bringer/bases/service.dart';
import 'package:sqlite_utils/sqlite_utils.dart';

class DatabaseSerivce implements Service {
  static const String databaseName = "bacon.db";
  static DatabaseSerivce? _instance;
  factory() => _instance;

  DatabaseSerivce get instance => _instance ??= DatabaseSerivce();

  late SqliteUtils db;

  void connect() async {
    db = SqliteUtils(settings: {
      'database': databaseName,
      'tableMap': {
        'table1':
            'id INTEGER PRIMARY KEY, nickname TEXT, telphone TEXT, createTime INTEGER, updateTime INTEGER',
        'table2': 'id INTEGER PRIMARY KEY, title TEXT, titleId INTEGER',
      },
      'version': 1,
    });
  }

  void disconnect() async {
    await db.close();
  }
}
