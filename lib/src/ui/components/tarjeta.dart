
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tarjeta extends StatelessWidget {
  const Tarjeta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children:[
          Expanded(child: _buttons()),Expanded(child: _body()), Expanded(child: _bottom())],
      )
    );
  }
}
_buttons(){
  return Container(
    height: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.tealAccent),
    child: (
      Row(
        children: [
          Expanded(
              flex:3,
              child: ElevatedButton(onPressed: ()=>print('ouch'), child: Container( ))),
          SizedBox(width: 20),
          Expanded(
              flex:7,
              child: Container(
                child: Column(
                  children: [
                    Expanded(child: ElevatedButton(onPressed: ()=>print('ouhh'), child: Container())),
                    SizedBox(height: 20,),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [Expanded(child: ElevatedButton(onPressed: ()=>print('ouch'), child: Container( ))),
                                     SizedBox(width: 20,),
                                     Expanded(child: ElevatedButton(onPressed: ()=>print('ouch'), child: Container( )))],
                        ),
                      ),
                    )],
                ),
              )
          )
        ],
      )
    ),
  );
}

_body(){
  List<String> dias = ['Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo'];
  return Container(
      decoration: BoxDecoration(color: Colors.blue[400]),
      padding: EdgeInsets.all(20),

      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(color: Colors.green),
            ),
          ),
           SizedBox(width: 20,),
           Expanded(
             flex: 7,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 Container(alignment: Alignment.center, color: Colors.blue[600], height: 20,child: Text('Dias'),),
                 Expanded(
                   child: Container(

                     child: ListView.builder(
                      itemBuilder:(BuildContext context,int index) => Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)) ,child: Align(alignment: Alignment.center, child: RotatedBox(quarterTurns: 1,child:Text(dias[index]),))),
                      itemCount:dias.length,
                      itemExtent: 60,
                      scrollDirection: Axis.horizontal,
                     ),
                   ),
                 ),
               ],
             ),
           )
        ],
      ) ,

  );
}

_bottom(){
  return Container(
    height: 300,
      color: Colors.red,
      child:Column(

          children:[
            Expanded(

                child: Container(
                  alignment: Alignment.topLeft,
                  child: Container(

                  color: Colors.blue,
                  width: 100,
            ),
                )),
            Expanded(child: Text('Hola mundo',style: TextStyle(fontWeight: FontWeight.bold),)),
            Expanded(child:
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                color: Colors.blue,
                width: 100,
              ),
            ))
          ]


      )
  );

}

