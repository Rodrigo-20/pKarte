import 'package:path/path.dart';
import 'package:pkarte/src/interfaces/data_access.dart';
import 'package:pkarte/src/models/label.dart';
import 'package:sqflite/sqflite.dart';

import '../models/custom_image.dart';

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
    String path = join(databasesPath, 'pkarte_database.db');
    // When the database is first created, create a table to store dogs.
    Database database = await openDatabase(path,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE images ('
                  'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                  'latitude DOUBLE NOT NULL, '
                  'longitude DOUBLE NOT NULL, '
                  'imageData BLOB NOT NULL)');
          await db.execute(
              'CREATE TABLE labels ('
                  'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                  'name TEXT,'
                  'description TEXT, '
                  'color TEXT NOT NULL) '
                  );
          await db.execute(
              'CREATE TABLE images_labels ('
                  'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                  'image_id INTEGER NOT NULL,'
                  'label_id INTEGER NOT NULL, '
                  'FOREIGN KEY(image_id) REFERENCES images(id),'
                  'FOREIGN KEY(label_id) REFERENCES labels(id))'
          );
        },
        version: 3
    );
    return database;
  }

  Helper();

  @override
  Future<void> addLabel(Label label) async {
    final data = await db;
    await data.insert(
      'labels',
      label.toMap(),
      //conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> addImageToLabels(CustomImage image, List<int> labels) async {
    print('guardando imagen');
    print('labels');
    print(labels.length);
    final data = await db;
    int imageId = await data.insert('images',image.toMap());
    for(int i= 0; i< labels.length; i++){
    print(imageId);
    await data.insert('images_labels',{'image_id':imageId,'label_id':labels[i]});
    }
  }


  @override
  Future <List<Label>> getLabels() async{
    final data = await db;
    final List<Map<String,dynamic>> labels = await data.query('labels');
    return List.generate(labels.length,(index) {
      return Label.fromMap(labels[index]);
    });
  }

  @override
  void removeEtiqueta(Label etiqueta) {
    // TODO: implement removeEtiqueta
  }

  @override
  void saveEtiquetas(List<Label> etiquetas) {
    // TODO: implement saveEtiquetas
  }


  @override
  Future<List<CustomImage>> getImagesFromLabel(int LabelId) async {
    // TODO: implement getImages
    List<CustomImage> images = [];
    print('trayebdo imagenes');
    final data = await db;
    final List<Map<String,dynamic>> images_id = await data.query('images_labels',columns: ['image_id'],where:'label_id = ?',whereArgs: [LabelId]);
    print('images_id:  ');
    print(images_id);
    print(images_id.first['image_id']);
    for(int i = 0; i< images_id.length; i++){
      print(images_id[i]['id']);
      CustomImage image = await getImage(images_id[i]['image_id']);
      images.add(image);
    }
    return images;
  }

  Future<CustomImage> getImage(int imageId) async{
    final data = await db;
    List<Map<String,dynamic>> image = await data.query(
      'images',
      where:'id = ?',
      whereArgs: [imageId]);
    print(image.first['latitude']);
    return CustomImage.fromMap(image.first);
  }

  
}