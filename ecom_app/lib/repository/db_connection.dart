import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  intDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_ecom');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatiogDatabase);

    return database;
  }

  _onCreatiogDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE carts(id INTEGER PRIMARY KEY, productId INTEGER,productName)");
  }
}
