import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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


  late DataManager _dataManager ;
  static HomeController get con => _instance!;
  List<Etiqueta> _etiquetas = [];
  List<Etiqueta> get etiquetas => _etiquetas;
  List pages = [];
  Color? currentColor;
  late List<Circle> circles = [];
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData locationData;
  late Location location;
  late GoogleMapController mapController;


  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void initPage(){
    DataManager();
    _dataManager = DataManager.data;
    _etiquetas = _dataManager.getEtiquetas();
    initLocation().then((value) => print(value));
  }


  void toggle(Etiqueta item,bool value) {
    setState(() {
      item.changeState(value);
      });
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
    circles.add(Circle(circleId: CircleId('source'),center: LatLng(locationData.latitude!, locationData.longitude!), radius: 4, fillColor:Colors.blueAccent,strokeColor: Colors.blueAccent));
    return locationData;
  }

  Future<LocationData> getLocation () async{
      LocationData data =await location.getLocation();
      return data;
  }


  void selectColor(Color color){
    setState(() {
      currentColor = color;
    });
  }
}
