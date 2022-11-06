import 'package:flutter/material.dart';
import 'package:pkarte/src/models/filter.dart';
import 'package:pkarte/src/ui/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => FilterModel(),
        child: const MyApp() ,
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'hola mundo'),
    );
  }
}
