import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/models/palette_enum.dart';
import 'package:pkarte/src/ui/components/add_picture_filter.dart';

import 'package:provider/provider.dart';
import '../../models/custom_image.dart';
import '../../models/filter.dart';

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
            leading: Icon(Icons.location_on_outlined, color:_getColorByName(_con.etiquetas[index].color),size: 30,),
            title: Text(_con.etiquetas[index].name),
            trailing: const Icon(Icons.delete),
            enabled: true,
          );},
        itemCount: _con.etiquetas.length,
      ),
    );
  }

  _map() {
    return Consumer<FilterModel>(
      builder: (context,filter,child) {
        print('algo esta pasando');

        filter.labels.length> 0 ? print(filter.labels.first.id) : print('no hay nada');
        List<Marker> _markers = [];
        filter.labels.forEach((element) async {
          List<CustomImage> images = await _con.getImages(element.id!);
          images.forEach((image) {
            print('id :');
            print(image.id);
            _markers.add(Marker(
                markerId: MarkerId(image.id.toString()),
                position: LatLng(image.latitude, image.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(_getHueColorByName(element.color)),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Image.memory(image.imageData)),
                  );
                }
            ));
          });
          /*
               if(element.images!= null) {
                 element.images!.forEach((image) {
                   _markers!.add(Marker(
                       markerId: MarkerId(image.id.toString()),
                       position: LatLng(image.latitude, image.longitude),
                       icon: BitmapDescriptor.defaultMarkerWithHue(_getHueColorByName(element.color!)),
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => Image.memory(image.imageData)),
                         );
                       }
                   ));
                 });
          }*/
        });
        return Container(
          child: FutureBuilder(
              future: _con.initLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                    markers:_markers.toSet(),
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
                  FilterComponent(color: Colors.teal.shade400, items: _con.etiquetas, onTap: (lista){print(lista);},); }
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
                  items: _con.etiquetas,
                  getImageFromCamera: (lista) async {
                    LocationData location = await _con.getLocation();
                    Uint8List? picData = await _con.getFromCamera();
                    _con.addImage(CustomImage(picData!, location), lista);
                  },
                  getImageFromGallery: (lista) async{
                    LocationData location = await _con.getLocation();
                    Uint8List? picData = await _con.getFromGallery();
                    _con.addImage(CustomImage.fromGallery(picData!, location),lista);
                  },
                );
            }
        );
      },
    )
        :const SizedBox.shrink();

  }

  _second(IconData icon ){
      var filter = context.watch<FilterModel>();
      return Expanded(
          flex: 1,
          child: FloatingActionButton(
            onPressed:(){
              //GUARDAR
              //_con.getFromGallery().then((value) => filter.add(value!));
              showSecond();},
            heroTag: 'addFromGallery',
            child: Icon(icon,color: Colors.white,),
          ));
  }

  _first(IconData icon ){
    var filter = context.watch<FilterModel>();
      return Expanded(
          flex: 1,
          child: FloatingActionButton(
            onPressed:(){
              if(isSecondVisible) {
                //_con.getFromCamera().then((value) => filter.add(value!));
                showSecond();
              }
              else{showSecond();}
              },
            heroTag: 'addFromCamera',
            child: Icon(isSecondVisible ? icon: Icons.add ,color: Colors.white,),
          ));
  }
  _getColorByName(String colorName){
    PaletteColor.hueColors.map((element) {
      if(element.name == colorName){
        return element.color;
      }
    });
  }
  _getHueColorByName(String colorName){
    PaletteColor.hueColors.map((element) {
      if(element.name == colorName){
        return element.hueColor;
      }
    });
  }

  /*
  _addButton(){
    var filter = context.watch<FilterModel>();
    return FloatingActionButton(
      onPressed:(){
        _selectedIndex == 1 ? Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EtiquetaForm()),
        ): _con.getFromCamera().then((value) => filter.add(value!));},
      elevation: 8,
      heroTag: 'add',
      child: const Icon(Icons.add),
    );
  }
   */





}