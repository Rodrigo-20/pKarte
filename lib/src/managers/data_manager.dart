import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/data_access/database.dart';
import 'package:pkarte/src/data_access/dummy.dart';
import 'package:pkarte/src/interfaces/data_access.dart';
import 'package:pkarte/src/models/custom_image.dart';
import '../models/label.dart';

class DataManager extends ControllerMVC{
   factory DataManager() {
    if(_this == null){_this = DataManager._internal(Helper());  }
    return _this!;
  }
  //esta bien que el data manager tenga una referencia del controlador ?
  static DataManager? _this;

  DataManager._internal(this.dataAccess);
  static DataManager get data => _this!;

  final IDataAccess dataAccess;

  void addImage(CustomImage image, List<int> labels){
    dataAccess.addImage(image, labels);
  }

  Future<List<CustomImage>> getImages(int labelId) async{
    return dataAccess.getImages(labelId);
  }
  Future<List<Label>> getLabels()async{
    return  dataAccess.getLabels();
  }

  void saveEtiquetas(List<Label> etiquetas){
    dataAccess.saveEtiquetas(etiquetas);
  }

  void addLabel(Label etiqueta){
    dataAccess.addLabel(etiqueta);
  }

  void removeEtiqueta(Label etiqueta){
    dataAccess.removeEtiqueta(etiqueta);
  }
}