import 'dart:math';
import 'package:flutter/material.dart';
import 'styled_text.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key, required this.onRoll});

  final void Function(int, int) onRoll;

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;
  var rollCount = 0;

  String text = "Roll dice";
  String yourscore = "Your score";
  
  int currSum = 0;

  void rollDice() {
    rollCount++;
    if(currSum >= 20 && text == "Play again") {
      rollCount = 1;
      setState(() {
        myMap = {
          'roll1': 0,
          'roll2': 0,
          'roll3': 0,
          'roll4': 0,
          'roll5': 0,
        };
      });
    }

    setState(() {
      //text = (rollCount == 5) ? "Play again" : "Roll Dice";
      currentDiceRoll = randomizer.nextInt(6) + 1;
      //currentDiceRoll = 6;
      myMap['roll$rollCount'] = currentDiceRoll;
      text = (rollCount == 5) ? "Play again" : "Roll dice";
    });

    if(currSum >= 20) {
      myMap['roll$rollCount'] = 0;
      rollCount = 0;
    }

    if (rollCount > 5) {
      rollCount = 0;
      setState(() {
        myMap = {
          'roll1': 0,
          'roll2': 0,
          'roll3': 0,
          'roll4': 0,
          'roll5': 0,
        };
      });
    }
    
    int sum = myMap.values.fold(0, (prev, element) => prev + element);
    currSum = sum;

    setState(() {
      if(sum >= 20) {
        yourscore = "You win!";
        text = "Play again";
      }
      else if(sum <= 20 && rollCount == 5) {
        yourscore = "You lose...";
        text = "Play again";
      }
      else yourscore = "Your score";
    });
    widget.onRoll(sum, rollCount);
  }

  Map<String, int> myMap = {
    'roll1': 0,
    'roll2': 0,
    'roll3': 0,
    'roll4': 0,
    'roll5': 0,
  };

  @override
  Widget build(context) {
    int sum = myMap.values.fold(0, (prev, element) => prev + element);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text(yourscore,
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            "$sum/20",
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: LinearProgressIndicator(
            minHeight: 5,
            value: sum / 20,
            backgroundColor: Colors.grey,
            borderRadius: BorderRadius.circular(10),
            valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 245, 191, 255)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Expanded(
              child: Column(
                children: [
                  Text("1st", style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text(
                    myMap['roll1'] == 0 ? '--' : myMap['roll1'].toString(),
                  style: TextStyle(fontSize: 30, color: Colors.white)),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              child: Column(
                children: [
                  Text("2nd", style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text(
                    myMap['roll2'] == 0 ? '--' : myMap['roll2'].toString(),
                  style: TextStyle(fontSize: 30, color: Colors.white)),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              child: Column(
                children: [
                  Text("3rd", style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text(
                    myMap['roll3'] == 0 ? '--' : myMap['roll3'].toString(),
                  style: TextStyle(fontSize: 30, color: Colors.white)),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              child: Column(
                children: [
                  Text("4th", style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text(
                    myMap['roll4'] == 0 ? '--' : myMap['roll4'].toString(),
                  style: TextStyle(fontSize: 30, color: Colors.white)),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              child: Column(
                children: [
                  Text("5th", style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text(
                    myMap['roll5'] == 0 ? '--' : myMap['roll5'].toString(),
                  style: TextStyle(fontSize: 30, color: Colors.white)),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
        Spacer(),
        Image.asset(
          'assets/images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        //const SizedBox(height: 100),
        Spacer(),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.only(
            //   bottom: 20,
            // ),
            backgroundColor: Colors.purple, //bg color
            foregroundColor: Colors.white, //font color
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: Text(text),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 80),
          child: Text(text == "Roll dice" ? "Chance left: ${5-rollCount}" : "",
          style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
