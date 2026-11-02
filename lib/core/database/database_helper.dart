import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../app_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY,
        title TEXT,
        duration TEXT,
        description TEXT,
        imageurl TEXT,
        url TEXT,
        artistid INTEGER,
        artist TEXT,
        gnreid INTEGER,
        gnre TEXT
      )
    ''');
    
    // Add additional tables as needed (e.g., playlists, history)
  }

  Future<int> insertFavorite(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('favorites', row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAllFavorites() async {
    Database db = await database;
    return await db.query('favorites');
  }

  Future<int> deleteFavorite(int id) async {
    Database db = await database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}
