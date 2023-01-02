import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.black,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const Scaffold(backgroundColor: Colors.black, body: HomePage()),
      );
}
