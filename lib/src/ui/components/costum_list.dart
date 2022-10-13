import 'package:flutter/material.dart';
import 'package:pkarte/src/ui/components/costume_item.dart';

class CostumeList extends StatelessWidget {
  final List<CostumeItem>? values;
  const CostumeList({required this.values});

  @override
  Widget build(BuildContext context) {
    return _list(values!);
  }
}


  _list(List<CostumeItem> list){
    return(
        Container(
          child: ListView.separated(
              itemBuilder: (context, index){
               return _cell(list[index]);
          },
              separatorBuilder: (context, index){
                return SizedBox(height: 20);
              },
              itemCount:list.length ),
        )
    );
  }

  _cell(CostumeItem item){
    return Container(
        width: 500,
        height: 250,
        padding: EdgeInsets.all(20),

        decoration: BoxDecoration(

            border: Border.all(
              color: Colors.black,
              width: 2,
            )
        ),
        child: Row(
          children: <Widget>[

            Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                  decoration: const BoxDecoration(

                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                        border: Border.all(
                          color: Colors.green,
                          width: 2,
                        )
                    ),
                    child: Icon(item.icon?? Icons.verified_user ,size: 40),
                  ),
                )
            ),
            Divider(
              height: 5,
              thickness: 3,
              color: Colors.black,
            ),
            Expanded(
              flex: 7,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Colors.yellowAccent,
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  <Widget>[
                      Text(item.text1!),
                      Text(item.text2?? ""),
                      Text(item.text3?? "")
                    ],
                  )
              ),
            )],
        )
    );
  }


