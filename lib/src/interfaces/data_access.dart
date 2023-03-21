import '../models/custom_image.dart';
import '../models/label.dart';

abstract class IDataAccess{

 void saveEtiquetas(List<Label> etiquetas);
 Future<void> addLabel(Label label);
 Future<List<Label>> getLabels();
 void removeEtiqueta(Label etiqueta);

 Future<List<CustomImage>> getImages(int LabelId);
 Future<void> addImage(CustomImage image,List<int> labels);
}