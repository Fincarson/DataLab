import 'dart:math';
import 'package:flutter/material.dart';
import 'styled_text.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key, required this.onStateChanged});
  final void Function(String state) onStateChanged;

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;
  var currentScore = 0;
  var currentChance = 5;
  var currentState = "play";
  var currentIdx = 0 ;

  List<String> labels = ["1st", "2nd", "3rd", "4th", "5th"];
  List<int> labelScores = [0, 0, 0, 0, 0];

  // Reset
  void reset(){
    setState((){
      currentDiceRoll = 2;
      currentScore = 0;
      currentChance = 5;
      currentState = "play";

      for(var i = 0; i < 5; i++){labelScores[i] = 0;}
      currentIdx = 0;
    });
    widget.onStateChanged("play");
  }

  // Roll Dice
  void rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
      currentScore += currentDiceRoll;
      currentChance -= 1;
      if(currentScore >= 20 && currentChance >= 0) {
        currentState = "win";
        widget.onStateChanged("win");
      }
      else if(currentScore < 20 && currentChance <= 0) {
        currentState = "lose";
        widget.onStateChanged("lose");
      }

      labelScores[currentIdx++] = currentDiceRoll;
    });

    if (currentState == "win" || currentState == "lose") {
      widget.onStateChanged(currentState);
    }
  }

  // Text Title
  Widget textTitle(){
    return currentState == "win" ? const StyledText("You win") :
           currentState == "lose" ? const StyledText("You lose") :
           const StyledText("Your score");
  }

  // Score Title
  Widget scoreTitle(){
    return StyledText("$currentScore/20", font_size: 48,);
  }

  // Progress Bar
  Widget progressBar(){
    final double progress = (currentScore / 20).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 6,
          backgroundColor: Colors.purple,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueGrey),
        ),
      ),
    );
  }

  // Table Score
  Widget tableScore(){
    const columnWidths = <int, TableColumnWidth>{
      0: FlexColumnWidth(),
      1: FlexColumnWidth(),
      2: FlexColumnWidth(),
      3: FlexColumnWidth(),
      4: FlexColumnWidth(),
    };

    Widget cellText(String text, {double size = 18, FontWeight weight = FontWeight.w600}){
      return Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
            fontWeight: weight,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Table(
        columnWidths: columnWidths,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: List.generate(5, (i) => SizedBox(height: 34, child: cellText(labels[i], size: 18))),),
          TableRow(children: List.generate(5, (i) => SizedBox(height: 44, child: cellText(labelScores[i] == 0 ? "--" : labelScores[i].toString(), size: 32, weight: FontWeight.w500))),),
        ],
      ),
    );
  }

  // Show Dice or Not
  Widget dice(){
    if(currentScore == 0){
      return const SizedBox(width: 200, height:200);
    }

    return Image.asset (
      "assets/images/dice-$currentDiceRoll.png",
      width: 200
    );
  }

  // Button
  Widget button(){
    return TextButton(
      onPressed: currentState == "win" || currentState == "lose" ? reset : rollDice,
      style: TextButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 38),
      ),
      child: currentState == "win" || currentState == "lose" ? const StyledText("Play again") : const StyledText("Roll dice"),
    );
  }

  // Print Chances
  Widget chances(){
    if(currentState == "play") {return StyledText("Chance left: $currentChance", font_size: 18,);}
    else {return const StyledText("");}
  }

  // Build
  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 70),
        textTitle(),
        const SizedBox(height: 10),
        scoreTitle(),
        const SizedBox(height: 20),
        progressBar(),
        const SizedBox(height: 20),
        tableScore(),
        const SizedBox(height: 20),
        dice(),
        const SizedBox(height: 20),
        button(),
        const SizedBox(height: 10),
        chances(),
      ],
    );
  }
}
