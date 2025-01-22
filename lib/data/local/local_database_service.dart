import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'restaurant-app.db';
  static const String _tableName = 'restaurant';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute(
      """CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        city TEXT,
        address TEXT,
        pictureId TEXT,
        categories TEXT,
        menus TEXT,
        rating REAL,
        customerReviews TEXT
      )
      """,
    );
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertItem(RestaurantDetail restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<RestaurantDetail>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    return results.map((result) => RestaurantDetail.fromJson(result)).toList();
  }

  Future<RestaurantDetail> getItemsById(int id) async {
    final db = await _initializeDb();
    final result =
        await db.query(_tableName, where: 'id =?', whereArgs: [id], limit: 1);

    return result.map((result) => RestaurantDetail.fromJson(result)).first;
  }

  Future<int> removeItem(int id) async {
    final db = await _initializeDb();
    final result =
        await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
