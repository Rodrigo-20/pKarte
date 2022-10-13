import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CostumeExpansion extends StatelessWidget {
  const CostumeExpansion({Key? key, required this.title,required this.onShow, this.offset=0.0}) : super(key: key);
  final String title;
  final double offset;
  final Function() onShow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 5.0,color: Colors.blue)),
      child: Stack(

        children:[
          Visibility(
            visible: offset==0.0 ? true: false,
            child: AnimatedSlide(
              //scale: show ? 1.0 : 0.0,
              offset: Offset(0,offset),
              duration:const  Duration(milliseconds: 500),
              child:Container(
                height: 120,
                color: Colors.lightGreen,
              ),
            ),
          ),
            InkWell(
                onTap:(){ onShow();},
                child: Container(height: 70,width: double.infinity,color: Colors.redAccent,)),

          ],
        ),
    );

  }
}
