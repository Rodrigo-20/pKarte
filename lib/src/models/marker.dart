class CustomLocation{
  String id;
  double latitude;
  double longitud;


  static int cantidadInstancias = 0;
  void _contarInstancias(){
    cantidadInstancias++;
  }

  CustomLocation({required this.id, required this.latitude,required this.longitud}){
    _contarInstancias();
  }
}