import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  // Question Title
  Widget questionText(Map<String, Object> data){
    return Text(
      data["question"] as String,
      style: GoogleFonts.lato(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // User Answer
  Widget userAnswer(Map<String, Object> data){
    return Text(
      data["user_answer"] as String,
      style: GoogleFonts.lato(
        color: const Color.fromARGB(255, 202, 171, 252),
      ),
    );
  }

  // Correct Answer
  Widget correctAnswer(Map<String, Object> data){
    return Text(
      data["correct_answer"] as String,
      style: GoogleFonts.lato(
        color: const Color.fromARGB(255, 150, 198, 241),
      ),
    );
  }

  // Number Icon
  Widget questionNumber(Map<String, Object> data){
    return Container(
      width: 30, height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: data["user_answer"] == data["correct_answer"]
          ? const Color.fromARGB(255, 150, 198, 241) 
          : const Color.fromARGB(255, 249, 133, 241),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        ((data["question_index"] as int) + 1 ).toString(),
        style: GoogleFonts.lato(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Question Content
  Widget questionContent(Map<String, Object> data){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        questionText(data),
        const SizedBox(height:5),
        userAnswer(data),
        correctAnswer(data),
      ]
    );
  }
 
  // Summary Row
  Widget summaryItem(Map<String, Object> data){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionNumber(data),
          const SizedBox(width: 8.0),
          Expanded(child: questionContent(data),),
        ],
      ),
    );
  }

  // Build
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data){
            return summaryItem(data);
          }).toList(),
        ),
      ),
    );
  }
}
