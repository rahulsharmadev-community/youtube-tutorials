import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOn = false;

  void onSwitch() => setState(() => isOn = !isOn);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Positioned(
            top: 0, child: Image.asset('assets/images/road.png', height: 120)),
        showBulb(width * 0.7),
        showButton(100),
      ],
    );
  }

  Positioned showButton(double width) {
    return Positioned(
        bottom: width,
        child: GestureDetector(
          onTap: onSwitch,
          child: Column(
            children: [
              Image.asset(
                isOn
                    ? 'assets/images/off_button.png'
                    : 'assets/images/on_button.png',
                width: 72,
              ),
              const SizedBox(height: 12),
              Material(
                color: Colors.transparent,
                child: Text(
                  isOn ? 'TURN OFF' : 'TURN ON',
                  style: TextStyle(
                      color: isOn ? Colors.grey : const Color(0xffffd600)),
                ),
              )
            ],
          ),
        ));
  }

  Positioned showBulb(double width) {
    return Positioned(
      top: 100,
      child: isOn
          ? Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 500,
                    spreadRadius: 1000,
                    offset: const Offset(0, 50),
                    color: const Color(0xffffd600).withOpacity(0.1)),
                BoxShadow(
                    blurRadius: 500,
                    spreadRadius: -10,
                    offset: const Offset(0, 50),
                    color: const Color(0xffffd600).withOpacity(0.3))
              ]),
              child: Image.asset('assets/images/on_bulb.png', width: width))
          : Image.asset('assets/images/off_bulb.png', width: width),
    );
  }
}
