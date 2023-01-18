
import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/flutter_color_picker_wheel.dart';
import 'package:flutter_color_picker_wheel/models/button_behaviour.dart';

class Wall25Button extends StatefulWidget {
  final int index;
  final Function sendMessage;
  final List<String> presas;
  final Color c2;

  const Wall25Button({required this.index, required this.sendMessage, required this.c2, required this.presas});

  @override
  State<Wall25Button> createState() => _Wall25ButtonState();
}

class _Wall25ButtonState extends State<Wall25Button> {
  bool isActivated = false;
  late bool marcar = false ;
  late int _colorController;
  late Color c1;
  late Color c2 = Colors.transparent;

  _deletePresaList(){
    widget.presas.removeWhere( (item) => item.contains('${widget.index},') );

  }
  _deletePresaWall(){widget.sendMessage("${widget.index}.0");}

  _addPresa() async{

    _deletePresaList();
    switch (_colorController){

      case  4294198070: { //case red
        widget.presas.add("${widget.index},65280");
        widget.sendMessage("${widget.index}.65280");
      }break;
      case 4280391411: { //case blue
        widget.presas.add("${widget.index},255");
        widget.sendMessage("${widget.index}.255");
      }break;
      case 4283215696: { //case green
        widget.presas.add("${widget.index},16711680");
        widget.sendMessage("${widget.index}.16711680");
      }break;
      case 4294967295: { //case white
        widget.presas.add("${widget.index},16777215");
        widget.sendMessage("${widget.index}.16777215");

      }break;
      case 4288423856 : { //case purple
        widget.presas.add("${widget.index},65535");
        widget.sendMessage("${widget.index}.65535");
      }break;
      case 4294961979: { //case yellow
        widget.presas.add("${widget.index},16776960");
        widget.sendMessage("${widget.index}.16776960");
      }break;


    }

  }



@override
  void initState() {
    // TODO: implement initState
    super.initState();



  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 32.3,
      child: Container(
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(20) ,border: Border.all(color: Colors.transparent)),
        child: Stack(
          children: [WheelColorPicker(
            onSelect: (Color newColor) {
              setState(() {
                c1 = newColor;
                _colorController= c1.value;
                isActivated = false;
                if(c1.value!=0) {
                  _addPresa();
                  print(widget.presas);
                }
                else{_deletePresaList();
                _deletePresaWall();
                print(widget.presas);}

              });
            },
            defaultColor: widget.c2 ,
            animationConfig: fanLikeAnimationConfig,
            colorList: const [
              [Colors.red,],
              [Colors.white,Colors.purple],
              [Colors.yellow,],
              [Colors.green,],
              [Colors.blue,],
              [Colors.transparent,],
            ],
            behaviour: ButtonBehaviour.clickToOpen,
            buttonSize: 15,
            pieceHeight: 20,
            innerRadius: 25,



          ),
            //Text("${widget.index}"),

          ]
        ),


      ),
    );
  }
}

