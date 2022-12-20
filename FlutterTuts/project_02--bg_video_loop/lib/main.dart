import 'package:flutter/material.dart';
import 'ext.dart';

import 'background_video_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background loop video
        const BackgroundVideoWidget(),

        // Form Content
        Center(
          child: SimpleDialog(
            backgroundColor: Colors.brown.shade800.withOpacity(0.7),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            contentPadding: const EdgeInsets.all(12),
            title: Image.asset('assets/logo.png', height: 120),
            children: [
              customTextField('Username'),
              12.hSpace,
              customTextField('Password'),
              forgetButton(),
              32.hSpace,
              submitButton(),
              12.hSpace,
            ],
          ),
        )
      ]),
    );
  }

  Align forgetButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forget password?',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(42),
          backgroundColor: Colors.brown.shade900,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      child: const Text('Submit'),
    );
  }

  Widget customTextField(String params) => TextField(
          decoration: InputDecoration(
        label: Text(params),
        filled: true,
        fillColor: Colors.brown.shade100,
        labelStyle: const TextStyle(color: Colors.brown),
        focusedBorder: getBorder(),
        border: getBorder(),
        enabledBorder: getBorder(),
        errorBorder: getBorder(Colors.red),
        disabledBorder: getBorder(Colors.grey),
      ));

  OutlineInputBorder getBorder([Color color = Colors.brown]) =>
      OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.brown, width: 3),
        borderRadius: BorderRadius.circular(16),
      );
}
