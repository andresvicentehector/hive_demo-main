import 'package:flutter/material.dart';
import 'package:sunboards_vuit/models/via.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/info_screen.dart';



main() async {
  // Initialize hive
  await Hive.initFlutter();

  // Registering the adapter
  Hive.registerAdapter(ViaAdapter());
  // Opening the box
  await Hive.openBox('Viabox');


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunboards_vuit',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: true,
      home: InfoScreen(),
    );
  }
}
