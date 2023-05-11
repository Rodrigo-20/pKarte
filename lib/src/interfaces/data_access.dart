import '../models/custom_image.dart';
import '../models/label.dart';

abstract class IDataAccess{


 Future<void> addLabel(Label label);
 Future<List<Label>> getLabels();
 void removeEtiqueta(Label etiqueta);

 Future<List<CustomImage>> getImagesFromLabel(int labelId);
 Future<void> addImageToLabels(CustomImage image,List<int> labels);
}