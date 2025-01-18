import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int currentQuestionIndex;
  final int totalQuestions;

  const NextButton({
    super.key,
    required this.onPressed,
    required this.currentQuestionIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          currentQuestionIndex < totalQuestions - 1 ? 'Next Question' : 'See Score',
          style: TextStyle(color: Colors.white)
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 18, 67, 142),
        ),
      ),
    );
  }
}