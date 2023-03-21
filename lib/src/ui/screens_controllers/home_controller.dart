import 'dart:io';
import 'dart:typed_data';
import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/models/custom_image.dart';
import '../../managers/data_manager.dart';
import '../../models/label.dart';
import '../../models/palette_enum.dart';


class HomeController extends ControllerMVC{

  factory HomeController(){
    if(_instance == null) {_instance = HomeController._();};
    return _instance!;
  }
  static  HomeController? _instance;

  HomeController._();


  late DataManager _dataManager ;
  static HomeController get con => _instance!;
  List<Label> _etiquetas = [];
  List<Label> get etiquetas => _etiquetas;
  List pages = [];
  Color? currentColor;
  late List<Circle> circles = [];
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData locationData;
  late Location location;
  late GoogleMapController mapController;
  ImagePicker picker = ImagePicker();


  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void initPage() async{
    DataManager();
    _dataManager = DataManager.data;
    _etiquetas = await _dataManager.getLabels();
    await initLocation();
  }


  void toggle(Label item,bool value) {
    setState(() {
      item.changeState(value);
      });
  }

  void updateEtiquetas() async{
    _etiquetas = await _dataManager.getLabels();
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

  Future<Uint8List?> getFromCamera() async {
    Uint8List bytes;
    XFile? pickedImage = await picker.pickImage( source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800,);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      bytes = await imageFile.readAsBytes();
      return bytes;
      //return Label(images: [CustomImage(image: Image.file(imageFile),longitude: locData.longitude!,latitude: locData.latitude!,id: '${locData.latitude.toString()}')], name: 'foto Nueva');
    }
    else { print('something went wrong'); return null;}
  }

  Future<Uint8List?> getFromGallery() async {

    XFile? pickedImage = await picker.pickImage( source: ImageSource.gallery, maxWidth: 300, maxHeight: 300,);
    //LocationData locData = await getLocation();

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      final bytes = await imageFile.readAsBytesSync();
      return bytes;
      /*final data = await readExifFromBytes(bytes);
      data.entries.forEach((element) {
        if(element.key.endsWith('Latitude')){
          latitude = fractionToDouble(element.value.values.toList());
          print(element.value.tagType);
        }
        if(element.key.endsWith('Longitude')){
          longitude = fractionToDouble(element.value.values.toList());
        }
      });
      for (var entry in data.entries) {
        print("${entry.key}: ${entry.value}");
      }*/
      //return Label(images: [CustomImage(image: Image.file(imageFile),longitude: longitude!,latitude: latitude!,id: '${latitude.toString()}')], name: 'foto Nueva');
    }
    else { print('something went wrong'); return null;}
  }

  double fractionToDouble(List<dynamic> coord){
    double doubleCordinate;
    Ratio grades = coord[0];
    Ratio mins = coord[1];
    Ratio secs = coord[2];
    doubleCordinate = -1*(grades.toDouble() + mins.toDouble()/60 + secs.toDouble()/3600);
    return doubleCordinate;
  }

  void addImage(CustomImage image,List<int> labels){
    _dataManager.addImage(image, labels);
  }

  Future<List<CustomImage>> getImages(int labelId) async{
    List<CustomImage> images = await _dataManager.getImages(labelId);
    return images;
  }
  void selectColor(Color color){
    setState(() {
      currentColor = color;
    });
  }

  getColorByName(String colorName){
    PaletteColor.hueColors.map((element) {
      if(element.name == colorName){
        return element.color;
      }
    });
  }
  getHueColorByName(String colorName){
    PaletteColor.hueColors.map((element) {
      if(element.name == colorName){
        return element.hueColor;
      }
    });
  }
}
