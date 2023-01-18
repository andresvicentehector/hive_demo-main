import 'package:flutter/material.dart';
import 'package:sunboards_vuit/utils/bluetooth/SelectBondedDevicePage.dart';
import 'package:sunboards_vuit/screens/escalar_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunboards_vuit/template/T8Colors.dart';
import 'package:sunboards_vuit/template/utils/T8Constant.dart';
import 'package:sunboards_vuit/template/ConstantesPropias.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sunboards_vuit/utils/navigation_bar/navigator.dart';

class InfoScreen extends StatefulWidget {

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final Box contactBox;
  late var width;
  late BluetoothDevice? selectedDevice;
  TextEditingController editingController= TextEditingController();
  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    contactBox = Hive.box('Viabox');
    selectedDevice=null;


  }

  void dispose() {
      super.dispose();
    }


  void _filterSearchResults(String query) {

  }

  void _filterbylevel(int color){}
  void _filerbyblock(bool isblock){}

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(quePared,style: TextStyle(fontFamily: 'November')),
        actions: <Widget>[
          ElevatedButton(
           child: Icon(Icons.bluetooth, color: selectedDevice != null? Colors.blue : Colors.white ),
            onPressed: () async {
             selectedDevice =
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SelectBondedDevicePage(checkAvailability: false);
                  },
                ),
              );

              if (selectedDevice != null) {
                print('Connect -> selected ' + selectedDevice!.address);
                setState(() {


                });
              } else {
                print('Connect -> no device selected');
              }
            },
          ),
        ],
      ),
      body: Stack(
           children: [


             filtros(),
             Padding(
               padding: const EdgeInsets.fromLTRB(6.0, 70.0, 6.0, 84.0),
               child: ValueListenableBuilder(
                 valueListenable: contactBox.listenable(),

                 builder: (context, Box box, widget,) {
                   if (box.isEmpty) {
                     return Center(
                       child: Text('Crea una nueva vía',style: TextStyle(fontFamily: 'November'),),
                     );
                   } else {
                     return ListView.builder(
                       itemCount: box.length,
                       reverse: true,

                       itemBuilder: (context, index) {
                         var currentBox = box;
                         var viaData = currentBox.getAt(index)!;
                         return InkWell(
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Row(
                                     children: <Widget>[
                                       GestureDetector(
                                           onTap: (){
                                             _escalarScreen(context, viaData, index, selectedDevice);
                                             },
                                           child: circulo(viaData)),
                                       SizedBox(width: 14),
                                       GestureDetector( onTap: (){
                                         if (selectedDevice != null){

                                           _escalarScreen(context, viaData, index, selectedDevice);

                                         }
                                       },
                                           child: textoDescriptivo(viaData)),
                                       SizedBox(width: 14),

                                     ],
                                   ),

                                   SizedBox(height: 14),

                                   GestureDetector(
                                     onTap:  ()  {

                                       if (selectedDevice != null){

                                        _escalarScreen(context, viaData, index, selectedDevice);

                                       }


                                     },
                                     child: botonCargarVia(selectedDevice),
                                   )
                                 ],
                               ),

                             )



                         );
                       },
                     );


                   }
                 },
               ),
             ),

            Navigation(selectedDevice: selectedDevice),
            ]

            )

    );

  }


  Widget circulo(var viaData ){
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Color(viaData.dificultad)),
      width: width / 9.5,
      height: width / 9.5,
      padding: EdgeInsets.all(10),

    );
  }

  Widget textoDescriptivo(var viaData){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(viaData.name,  style: TextStyle(color: t8_textColorSecondary, fontSize: textSizeSMedium) ),
        Text(viaData.autor, style: TextStyle(fontFamily: fontMedium)),
        Text(viaData.presas.length.toString()+" presas", style: TextStyle(fontFamily: fontMedium)),
      ],
    );
  }

  void _escalarScreen(BuildContext context, var viaData, int index, BluetoothDevice? selectedDevice ){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EscalarScreen(
          index: index,
          via: viaData,
          server: selectedDevice,
        ),
      ),
    );
    
   

  }


  Widget botonCargarVia(BluetoothDevice? selectedDevice){
    return Container(
        decoration: BoxDecoration(color: (selectedDevice != null? t8_colorPrimary: t8_textColorSecondary), borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child:  Text( (selectedDevice != null?  "Cargar vía": "Conéctate a la pared" ), style: TextStyle(color: t8_white, fontFamily: 'November', )),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(

                width: 35,
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    selectedDevice != null?  Icons.arrow_forward : Icons.arrow_upward,
                    color: t8_white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget filtros(){
    return   Row(
      children: [


        SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(1.0, 6.0, 1.0, 6.0),
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)))),
            ),
          ),
        ),

      ],);
  }

}












