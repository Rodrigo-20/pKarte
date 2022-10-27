import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/data_access/dummy.dart';
import 'package:pkarte/src/interfaces/data_access.dart';
import '../models/etiqueta.dart';

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

  List<Etiqueta> getEtiquetas(){
    return dataAccess.getEtiquetas();
  }

  void saveEtiquetas(List<Etiqueta> etiquetas){
    dataAccess.saveEtiquetas(etiquetas);
  }

  void addEtiqueta(Etiqueta etiqueta){
    dataAccess.addEtiqueta(etiqueta);
  }

  void removeEtiqueta(Etiqueta etiqueta){
    dataAccess.removeEtiqueta(etiqueta);
  }
}