import '../models/etiqueta.dart';

abstract class IDataAccess{

 void saveEtiquetas(List<Etiqueta> etiquetas);
 void addEtiqueta(Etiqueta data);
 List<Etiqueta> getEtiquetas();
 void removeEtiqueta(Etiqueta etiqueta);

}