import 'package:flutter/material.dart';
import 'package:quiz_assignment/screens/quiz_screen.dart';

class NavigationModel with ChangeNotifier {
  void navigateToQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Quiz_Screen()),
    );
  }
}
