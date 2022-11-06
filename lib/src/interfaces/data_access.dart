import '../models/label.dart';

abstract class IDataAccess{

 void saveEtiquetas(List<Label> etiquetas);
 void addEtiqueta(Label data);
 List<Label> getEtiquetas();
 void removeEtiqueta(Label etiqueta);

}