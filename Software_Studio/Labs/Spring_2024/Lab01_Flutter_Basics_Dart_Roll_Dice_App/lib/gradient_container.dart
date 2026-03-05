import 'package:flutter/material.dart';

import 'dice_roller.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

// Change to Stateful
class GradientContainer extends StatefulWidget {
  const GradientContainer(this.color1, this.color2, {super.key});

  const GradientContainer.purple({super.key})
      : color1 = Colors.deepPurple,
        color2 = Colors.indigo;

  final Color color1;
  final Color color2;

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  var currentState = "play";

  // Set State
  void onStateChanged(String newState) {
    setState((){
      currentState = newState;
    });
  }

  // Set Color
  List<Color> get currentColors{
    if(currentState == "win"){
      return const [
        Colors.green,
        Colors.greenAccent
      ];
    } else if(currentState == "lose"){
      return const[
        Colors.red,
        Colors.redAccent
      ];
    } else {
      return const[
        Colors.deepPurple,
        Colors.indigo
      ];
    }
  }

  // Build
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: currentColors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),

      // Changed to get top center
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: DiceRoller(
            onStateChanged: onStateChanged,
          ),
        ),
      ),
    );
  }
}
