import 'dart:math';
import 'package:flutter/material.dart';
import 'styled_text.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget{
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState(){
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller>{
  var currentDiceRoll = 2;

  void rollDice(){
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });
  }
}