import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_app.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Calculations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        a REAL,
        b REAL,
        result REAL
      );
    ''');
  }

  Future<void> addCalculation(double a, double b, double result) async {
    final db = await database;
    await db.insert('Calculations', {'a': a, 'b': b, 'result': result});
  }

  Future<List<Map<String, dynamic>>> getAllCalculations() async {
    final db = await database;
    return await db.query('Calculations', orderBy: 'id DESC');
  }
}