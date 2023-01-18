import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sunboards_vuit/screens/Bluetooth_screen.dart';
import 'package:sunboards_vuit/screens/add_presas_screen.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunboards_vuit/screens/jugar_screen.dart';
import 'package:sunboards_vuit/template/T8Colors.dart';
import 'package:sunboards_vuit/template/T1Colors.dart';
import 'package:sunboards_vuit/template/T1Images.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class Navigation extends StatefulWidget {
   final BluetoothDevice? selectedDevice;

  const Navigation({ required this.selectedDevice }) ;

  @override
  State<Navigation> createState() => _NavigationState();
}


class _NavigationState extends State<Navigation> {
  var isSelected=1;
  Widget Animation = Icon(
    Icons.add,
    color: t1_white,
  );
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 60,
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              boxShadow: [BoxShadow(color: shadowColorGlobal, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 3.0))],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  tabItem(1, t1_home),
                  tabItem(2, t1_user),
                  Container(
                    width: 45,
                    height: 45,
                  ),
                  tabItem(3, t1_game),
                  tabItem(4, t1_settings)
                ],
              ),
            ),
          ),
          Container(
            height: 75,
            width: 75,
            child: FloatingActionButton(
              backgroundColor: (widget.selectedDevice != null? t8_colorPrimary: t8_textColorSecondary),
              onPressed: () {


                if(widget.selectedDevice!=null){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddPresas(
                        server: widget.selectedDevice,
                      ),
                    ),
                  );
                }

              },
              child: Animation
            ),
          )
        ],
      ),
    );;
  }
  Widget tabItem(var pos, var icon) {

    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = 1;
        });

        if(pos==1){

        }
        else if(pos==3){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => JugarScreen(),
            ),
          );
        }
        else if(pos==4){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Bluetooth_screen(),
            ),
          );
        }


      },
      child: Container(
        width: 45,
        height: 45,
        alignment: Alignment.center,
        decoration: isSelected == pos ? BoxDecoration(shape: BoxShape.circle, color: t1_colorPrimary_light) : BoxDecoration(),
        child: SvgPicture.asset(
          icon,
          width: 20,
          height: 20,
          color: isSelected == pos ? t1_colorPrimary : Colors.black,
        ),
      ),
    );
  }
}


/*setState(() {
Animation= LoadingAnimationWidget.discreteCircle(
color:  const Color(0xFF32EE02),
secondRingColor: const Color(0xFFF5FC00),
thirdRingColor: const Color(0xFFEA3799),
size: 45,);
});*/