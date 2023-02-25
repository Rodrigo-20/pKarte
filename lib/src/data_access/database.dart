import 'package:path/path.dart';
import 'package:pkarte/src/interfaces/data_access.dart';
import 'package:pkarte/src/models/label.dart';
import 'package:sqflite/sqflite.dart';

class Helper implements IDataAccess{
  //static final Helper _instance = Helper._internal();
  //factory Helper() => _instance;
  //Helper._internal();
  static Database? _db;

  Future<Database> get db async {
    if(_db != null)
      return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'profiles_database.db');
    // When the database is first created, create a table to store dogs.
    Database database = await openDatabase(path,
        onCreate: (db, version) async {
          await db.execute('CREATE TABLE Profiles (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT, picture BLOB');
        },
        version: 2
    );
    return database;
  }

  Helper();

  @override
  void addEtiqueta(Label data) {
    // TODO: implement addEtiqueta
  }

  @override
  Future <List<Label>> getEtiquetas() async{
    // TODO: implement getEtiquetas
    throw UnimplementedError();
  }

  @override
  void removeEtiqueta(Label etiqueta) {
    // TODO: implement removeEtiqueta
  }

  @override
  void saveEtiquetas(List<Label> etiquetas) {
    // TODO: implement saveEtiquetas
  }
  
}