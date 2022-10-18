import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pkarte/src/ui/screens/new_etiqueta_form.dart';
import 'package:provider/provider.dart';
import '../../models/filtro.dart';
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

  void _changeTab(int index){
    setState(() {
      _selectedIndex = index;
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
        leading: Builder(
          builder: (BuildContext context) {
            return _selectedIndex == 0
                ? IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.filter_alt_rounded)) : const SizedBox.shrink();
          },
        ),
      ),
      drawer:Drawer(child:CostumeList(list: _con.etiquetas,toggle: _con.toggle,) ,),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar:_bottomNavigation(),
      floatingActionButton:_floatingButton(),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }

  _etiquetas(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(width: 40,height: 40,color: _con.etiquetas[index].color!.color,),
            title: Text(_con.etiquetas[index].name!),
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
        List<Marker> markers = [];
        filter.etiquetas.forEach((element) {
          if(element.getMarkers().isNotEmpty){
               var items = element.getMarkers();
               markers.addAll(items);
          }
        });
        return Container(
          child: FutureBuilder(
              future: _con.initLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng((snapshot.data as LocationData).latitude!,
                          (snapshot.data as LocationData).longitude!),
                      zoom: 14.5,
                    ),
                    markers:markers.toSet(),
                  );
                }
                else {
                  return const CircularProgressIndicator();
                }
              }
          ),
        );
      }
    );
  }

  _floatingButton(){
    return FloatingActionButton(
      onPressed:(){
        _selectedIndex == 1 ? Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EtiquetaForm()),
        ): print('ouch');},
      child: const Icon(Icons.add),
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
}