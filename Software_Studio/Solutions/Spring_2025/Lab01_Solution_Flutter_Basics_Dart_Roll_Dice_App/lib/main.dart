import 'package:flutter/material.dart';
import 'gradient_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int sum = 0;
  int value = 0;

  void updateSum(int newSum, int rollCount) {
    setState(() {
      sum = newSum;
      if (sum >= 20) {
        value = 1;
      }
      else if(5 - rollCount == 0 && sum < 20) {
        value = 2;
      }
      else if(5 - rollCount == 5) {
        value = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color1 = value == 1 ?
      Color.fromARGB(255, 8, 107, 58) : value == 2 ?
      Color.fromARGB(255, 138, 1, 16) : Color.fromARGB(255, 33, 5, 109);
    Color color2 = value == 1 ?
      Color.fromARGB(255, 14, 196, 93) : value == 2 ?
      Color.fromARGB(255, 245, 182, 75) : Color.fromARGB(255, 68, 21, 149);

    return MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          color1,
          color2,
          sum: sum,
          onRoll: updateSum,
        ),
      ),
    );
  }
}
