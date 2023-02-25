import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/data_access/dummy.dart';
import 'package:pkarte/src/interfaces/data_access.dart';
import '../models/label.dart';

class DataManager extends ControllerMVC{
   factory DataManager() {
    if(_this == null){_this = DataManager._internal(DummyData());  }
    return _this!;
  }
  //esta bien que el data manager tenga una referencia del controlador ?
  static DataManager? _this;

  DataManager._internal(this.dataAccess);
  static DataManager get data => _this!;

  final IDataAccess dataAccess;

  Future<List<Label>> getEtiquetas()async{
    return await dataAccess.getEtiquetas();
  }

  void saveEtiquetas(List<Label> etiquetas){
    dataAccess.saveEtiquetas(etiquetas);
  }

  void addEtiqueta(Label etiqueta){
    dataAccess.addEtiqueta(etiqueta);
  }

  void removeEtiqueta(Label etiqueta){
    dataAccess.removeEtiqueta(etiqueta);
  }
}