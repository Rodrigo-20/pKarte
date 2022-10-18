
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../managers/data_manager.dart';
import '../../models/etiqueta.dart';


class HomeController extends ControllerMVC{

  factory HomeController(){
    if(_instance == null) {_instance = HomeController._();};
    return _instance!;
  }
  static  HomeController? _instance;


  HomeController._();


  late DataManager _dataBase ;
  static HomeController get con => _instance!;
  List<Etiqueta> _etiquetas = [];
  List<Etiqueta> get etiquetas => _etiquetas;
  late Etiqueta? _currentEtiqueta;
  List pages = [];
  Color? currentColor;
  late LatLng center  ;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData locationData;
  late Location location;
  late GoogleMapController mapController;
  List<Marker> _markers = [];
  List<Marker> get markers => _markers;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  void initPage(){
    DataManager();
    _dataBase = DataManager.data;
    _etiquetas = _dataBase.getEtiquetas();
    _currentEtiqueta = _etiquetas[1];
    if(_currentEtiqueta!.getMarkers().length != 0){
      print(_etiquetas[0].name);
      _currentEtiqueta!.getMarkers().forEach((element) {
        _markers.add(element);
        print(element);});

    }
    else{
      print('no hay nada aca');
    }
    initLocation().then((value) => print(value));
  }


  void toggle(int index) {
    setState(() {
      _etiquetas[index].active = !_etiquetas[index].active!;
      });
    _dataBase.saveEtiquetas(_etiquetas);
  }

  Future<LocationData> initLocation() async{
    location = Location();
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception('location is not enabled');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception('location is not enabled');
      }
    }

    locationData = await location.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);
    _markers.add(
      Marker(markerId: MarkerId('source'),position:LatLng(locationData.latitude!, locationData.longitude!),)
    );
    return locationData;
    //center = LatLng( locationData.latitude!,locationData.longitude!);
    //print(center);
  }

  Future<LocationData> getLocation () async{
      LocationData data =await location.getLocation();
      return data;
  }

  void addEtiqueta(Etiqueta etiqueta){
    setState(() {
      _etiquetas.add(etiqueta);
    });
  }

  void selectColor(Color color){
    setState(() {
      currentColor = color;
    });
  }
}