
import 'dart:typed_data';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

class CustomImage{
  late Uint8List imageData;
  late double latitude;
  late double longitude;
  int? id;

  CustomImage(this.imageData, LocationData locationData){
    latitude = locationData.latitude!;
    longitude = locationData.longitude!;
  }

  CustomImage.fromGallery(this.imageData, LocationData locationData);

  CustomImage.fromMap(Map<String,dynamic> data){
    id = data['id'];
    imageData = data['imageData'];
    latitude = data['latitude'];
    longitude = data['longitude'];
  }

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'latitude':latitude,
      'longitude':longitude,
      'imageData':imageData,
    };
  }

}