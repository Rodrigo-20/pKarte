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

  /*
  List<Etiqueta> result = [Etiqueta(name: 'hola mundo'),Etiqueta(name: 'hola mundo'),Etiqueta(name: 'hola mundo'),Etiqueta(name: 'hola mundo')];

  List<Etiqueta> getEtiquetas(){
     return result;
   }

  void saveEtiquetas(List<Etiqueta> etiquetas){
    result = etiquetas;
  }

  void addEtiqueta(Etiqueta etiqueta){
    result.add(etiqueta);
    //_controller.addEtiqueta(etiqueta);
  }
*/
}