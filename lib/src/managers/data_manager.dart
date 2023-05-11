import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/data_access/database.dart';
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

  DataManager._internal(this._dataAccess);
  static DataManager get instance => _this!;

  final IDataAccess _dataAccess;

  void addImageToLabels(CustomImage image, List<int> labels) async{
    await _dataAccess.addImageToLabels(image, labels);
  }

  Future<List<CustomImage>> getImages(int labelId) async{
    List<CustomImage> images = [];
    images = await _dataAccess.getImagesFromLabel(labelId);
    return images;
  }

  Future<List<Label>> getLabels()async{
    return  _dataAccess.getLabels();
  }


  void addLabel(Label label){
    _dataAccess.addLabel(label);
  }

  void removeEtiqueta(Label etiqueta){
    _dataAccess.removeEtiqueta(etiqueta);
  }
}