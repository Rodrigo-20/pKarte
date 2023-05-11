import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/interfaces/image_source.dart';
import 'package:pkarte/src/models/custom_image.dart';
import 'package:pkarte/src/models/gallery..dart';
import 'package:pkarte/src/models/location_services.dart';
import '../../managers/data_manager.dart';
import '../../models/camera.dart';
import '../../models/color_item.dart';
import '../../models/filter.dart';
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
  List<Label> _labels = [];
  List<Label> get labels => _labels;
  Color? currentColor;
  late List<Circle> circles = [];
  late LocationData locationData;
  late GoogleMapController mapController;
  LocationServices locationServices = LocationServices();
  final Camera _camera = Camera();
  final Gallery _gallery = Gallery();
  late IImageSource imageSource;
  FilterModel filter = FilterModel();
  late Uint8List image;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<LocationData> getLocation() async{
    LocationData location = (await locationServices.getLocation());
    return location;
  }


  void initPage() async{
    DataManager();
    _dataManager = DataManager.instance;
    _labels = await _dataManager.getLabels();
    await locationServices.initLocation();
  }

  void toggle(Label item,bool value) {
    setState(() => item.changeState(value));
  }

  void updateLabels() {
    setState(() async{
      _labels = await _dataManager.getLabels();
    });
  }

  void setCameraImageSource(){
    imageSource = _camera;
  }

  void setGalleryImageSource(){
    imageSource = _gallery;
  }

  Future<void> getImageData() async{
    Uint8List? imageData = await imageSource.getImageData();
    image = imageData!;
  }


  Future<void> addImageToLabels(List<int> labels) async{
    LocationData location = await locationServices.getLocation();
    Uint8List? imageData = await imageSource.getImageData();
    CustomImage image = CustomImage(imageData!, location);
    _dataManager.addImageToLabels(image, labels);
  }

  Future<List<CustomImage>> getImagesFromLabel(int labelId) async{
    List<CustomImage> images = await _dataManager.getImages(labelId);
    return images;
  }

  void selectColor(Color color){
    setState(() {
      currentColor = color;
    });
  }

  Color getColorByName(String colorName){
    if (PaletteColor.hueColors.isNotEmpty) {
      ColorItem colorItem =  PaletteColor.hueColors.firstWhere((color) => color.name == colorName, orElse: () => PaletteColor.cyan  );
      return colorItem.color;
    }
    else { return PaletteColor.cyan.color;}
  }

  double getHueColorByName(String colorName) {
    if (PaletteColor.hueColors.isNotEmpty) {
      ColorItem color =  PaletteColor.hueColors.firstWhere((color) => color.name == colorName, orElse: () => PaletteColor.cyan  );
      return color.hueColor;
    }
    else {return 180.0;}
  }
}
