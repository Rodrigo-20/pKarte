class CostumeMarker{
  int? id;
  String? name;
  double? longitud;
  double? latitude;

  static int cantidadInstancias = 0;
  void _contarInstancias(){
    cantidadInstancias++;
  }

  CostumeMarker({required this.name,required this.longitud, required this.latitude}){
    _contarInstancias();
  }
}