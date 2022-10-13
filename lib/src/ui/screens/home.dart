import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/ui/components/costume_expansion.dart';
import 'package:pkarte/src/ui/screens/new_etiqueta_form.dart';
import '../../models/etiqueta.dart';
import '../../models/palette_enum.dart';
import '../components/color_selector.dart';
import '../components/costume_list.dart';
import '../screens_controllers/home_controller.dart';

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
  LatLng center = const LatLng(45.521563, -122.677433);
  int _selectedIndex = 0;
  double offset = 0.0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _con.initPage();
    print('iniciando estado');
  }

  void _changeTab  (int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      //ColorSelector(palette: PaletteColor.brilloso,currentColor: _con.currentColor?? Colors.blue, onSelectColor:_con.selectColor,),
      Container(
        child: FutureBuilder(
          future: _con.initLocation(),
          builder:(context,snapshot) {
            if(snapshot.hasData) {
             return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng((snapshot.data as LocationData).latitude!,
                      (snapshot.data as LocationData).longitude!),
                  zoom: 14.5,
                ),
               markers: _con.markers.toSet(),
              );
            }
            else {
              return const CircularProgressIndicator();
            }
          }
        ),
      ),
      _home(_con.etiquetas),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('hola mundo'),
        leading: Builder(
          builder: (BuildContext context) {
            return _selectedIndex == 0
                ? IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.filter_alt_rounded))
                : SizedBox();
          },
        ),
      ),
      drawer:_drawer(_con.etiquetas,_con.toggle),
      body: widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar:_bottomNavigation(_selectedIndex, _changeTab),
      floatingActionButton:FloatingActionButton(
        onPressed:(){
          _selectedIndex == 1 ? Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EtiquetaForm()),
            ): print('ouch');},
        child: Icon(Icons.add),
      ),

    );// This trailing comma makes auto-formatting nicer for build methods.
  }

}

_bottomNavigation(int index, Function(int) tapFunction){
  return(
      BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.white,
        onTap:tapFunction,
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

_drawer(List<Etiqueta> etiquetas, Function(int) _toggle){
  return Drawer(
      child:CostumeList(list: etiquetas,toggle: _toggle,)
  );


}

_home(List<Etiqueta> list_etiqueta){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(width: 40,height: 40,color: list_etiqueta[index].color!.color,),
            title: Text(list_etiqueta[index].name!),
            trailing: Icon(Icons.delete),
            enabled: true,
          );},
        itemCount: list_etiqueta.length,
      ),
    ),
  );

}

