import 'dart:io';

import 'package:bacon_bringer/bases/provider.dart';
import 'package:bacon_bringer/database/data/db_account_data_class.dart';
import 'package:bacon_bringer/database/data/db_category_data_class.dart';
import 'package:bacon_bringer/database/data/db_user_data.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'package:drift/drift.dart';

part 'app_database.g.dart';

final databaseProvider = Provider<QueryExecutor>(_openConnection);

@DriftDatabase(
    tables: [DBUserDataClass, DBAccountDataClass, DBCategoryDataClass])
class AppDatabase extends _$AppDatabase {
  AppDatabase._(QueryExecutor e) : super(e);

  static final AppDatabase _instance = AppDatabase._(databaseProvider.instance);

  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
