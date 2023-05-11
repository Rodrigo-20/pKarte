import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/models/color_item.dart';
import 'package:pkarte/src/models/palette_enum.dart';
import 'package:pkarte/src/ui/components/add_picture_filter.dart';
import 'package:provider/provider.dart';
import '../../models/custom_image.dart';
import '../../models/filter.dart';
import '../../models/label.dart';
import '../components/filter_component.dart';
import '../screens_controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends StateMVC {

  _MyHomePageState():super(HomeController()){
    _con = HomeController.con;
  }
  late HomeController _con;
  int _selectedIndex = 0;
  bool isSecondVisible = false;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _con.initPage();
  }

  void _changeTab(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  void showSecond(){
    setState(() {
      isSecondVisible = !isSecondVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      _map(),
      _etiquetas(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('pKarte'),
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar:_bottomNavigation(),
      floatingActionButton:_floatingButtons(),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }

  _etiquetas(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.location_on_outlined, color:getColorByName(_con.labels[index].color),size: 30,),
            title: Text(_con.labels[index].name),
            trailing: const Icon(Icons.delete),
            enabled: true,
          );},
        itemCount: _con.labels.length,
      ),
    );
  }

  _map() {
    Marker createMarkerFromImage({required CustomImage image,required Label label}){
        return Marker(
            markerId: MarkerId(image.id.toString()),
            position: LatLng(image.latitude!, image.longitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(getHueColorByName(label.color)),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Image.memory(image.imageData)),
              );
            }
        );
    }

    return Consumer<FilterModel>(//que va primero, el consumidor o el future builder ?
      builder: (context,filter,child) {
        List<Marker> markers = [];
        filter.labels.forEach((label) async {
          List<CustomImage> images = await _con.getImagesFromLabel(label.id!);
          images.forEach((image) {
            markers.add(createMarkerFromImage(image: image, label: label));
          });
        });
        return Container(
          child: FutureBuilder(
              future: _con.getLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('hola mundo');
                  print(markers.length);
                  return GoogleMap(
                    markers:markers.toSet(),
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng((snapshot.data as LocationData).latitude!, (snapshot.data as LocationData).longitude!),
                      zoom: 14.5,
                    ),
                  );
                }
                else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
          ),
        );
      }
    );

  }

  _floatingButtons(){
    return Container(
        margin:_selectedIndex == 0 ? const EdgeInsets.only(right: 0,bottom: 100) : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _filterButton(),
            const SizedBox(height: 20,),
            _addButton(),
          ],
        )
    );
  }

  _bottomNavigation(){
    return(
        BottomNavigationBar(
          currentIndex:_selectedIndex,
          selectedItemColor: Colors.white,
          onTap:_changeTab,
          backgroundColor: Colors.teal,
          iconSize: 40,
          items:const  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon:Icon(Icons.home),
                label:'Home'),
            BottomNavigationBarItem(
                icon:  Icon(Icons.format_list_bulleted),
                label:'Etiquetas' )
          ],
        )
    );
  }

  _filterButton(){
    return _selectedIndex == 0 ?
    FloatingActionButton(
          elevation: 8,
          heroTag:'filter' ,
          child: const Icon(Icons.filter_alt_rounded),
          onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return
                  FilterComponent(color: Colors.teal.shade400, items: _con.labels, onTap: (lista){print(lista);},); }
              );
            },
         )
    :const SizedBox.shrink();
  }

  _addButton(){
    return _selectedIndex == 0 ?
    FloatingActionButton(
      elevation: 8,
      heroTag:'filter' ,
      child: const Icon(Icons.add_circle_outline),
      onPressed: (){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return
                AddPicFilter(
                  color: Colors.teal.shade400,
                  items: _con.labels,
                  addImageFromCamera: (lista)  {
                    _con.setCameraImageSource();
                    _con.addImageToLabels(lista);
                  },
                  addImageFromGallery: (lista) async{
                    _con.setGalleryImageSource();
                    _con.addImageToLabels(lista);
                  },
                );
            }
        );
      },
    )
        :const SizedBox.shrink();

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