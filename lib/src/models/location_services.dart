import 'package:location/location.dart';

class LocationServices {
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late Location location;
  late LocationData locationData;
  LocationServices();

  Future<LocationData> initLocation() async{
    location = Location();
    await enableService();//se puede guardar de alguna manera como sharePreferences ?
    await updatePermissionStatus();
    locationData = await location.getLocation();
    //circles.add(Circle(circleId: CircleId('source'),center: LatLng(locationData.latitude!, locationData.longitude!), radius: 4, fillColor:Colors.blueAccent,strokeColor: Colors.blueAccent));
    return locationData;
  }

  Future<void> enableService() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception('location is not enabled');
      }
    }
  }

  Future<void> updatePermissionStatus() async{
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception('location is not enabled');
      }
    }
  }

  Future<LocationData> getLocation () async{
    LocationData dataLocation = await location.getLocation();
    return dataLocation;
  }
}