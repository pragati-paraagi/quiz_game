import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_assignment/models/ques_model.dart';
import 'package:quiz_assignment/screens/score_screen.dart';
import 'package:quiz_assignment/services/api.dart';
import 'dart:math';

class QuizModel extends ChangeNotifier {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  bool isAnswered = false;
  int score = 0;
  List<int> answers = []; // Store answers to change the color of options
  Option? selectedOption; // Track the selected option for color change
  bool isLoading = true;
  bool isQuizFinished = false; // Track if quiz is finished

  // Optional Timer fields
  int timeRemaining = 60; // Set a time limit for each question (in seconds)
  late Timer _timer;
  
  // Add BuildContext for navigation
  BuildContext? _context;
  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> initQuiz() async {
    isLoading = true;
    isQuizFinished = false; // Reset quiz finished state
    notifyListeners();
    await loadQuestions();
    startTimer(); // Start timer when quiz is initialized
  }

  // Timer method
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        timeRemaining--;
        notifyListeners(); // Notify listeners every second
      } else {
        _timer.cancel();
        if (_context != null) {
          nextQuestion(_context!); // Pass context to nextQuestion
        }
      }
    });
  }

  // Stop Timer
  void stopTimer() {
    _timer.cancel();
  }

  Future<void> loadQuestions() async {
    try {
      final apiService = ApiServices();
      List<Question> fetchedQuestions = await apiService.getQues();

      // Debugging: print fetched questions and options
      for (var question in fetchedQuestions) {
        print('Question: ${question.description}');
        question.options.forEach((option) {
          print('Option: ${option.text}');
        });
      }

      // Randomly select 8 questions
      if (fetchedQuestions.length > 8) {
        fetchedQuestions.shuffle(Random());
        questions = fetchedQuestions.take(8).toList();
      } else {
        questions = fetchedQuestions;
      }

      isLoading = false;
      notifyListeners(); // Notify listeners about the state change
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void checkAnswer(Option selectedOption) {
    if (!isAnswered) {
      isAnswered = true;
      this.selectedOption = selectedOption; // Store the selected option

      if (selectedOption.isCorrect) {
        score++;
        answers.add(1); // Correct answer
      } else {
        answers.add(0); // Wrong answer
      }
      notifyListeners(); // Notify listeners about the state change
    }
  }

  void nextQuestion(BuildContext context) {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      isAnswered = false;
      selectedOption = null; // Reset selected option for next question
      timeRemaining = 60; // Reset timer for the next question
      startTimer(); // Restart the timer for the next question
      notifyListeners(); // Notify listeners about the state change
    } else {
      isQuizFinished = true; // Set quiz as finished
      notifyListeners();
      stopTimer(); // Stop the timer after quiz completion
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(),
        ),
      );
    }
  }

  void resetQuiz() {
    currentQuestionIndex = 0;
    isAnswered = false;
    score = 0;
    answers.clear();
    selectedOption = null;
    timeRemaining = 60; // Reset timer
    isQuizFinished = false; // Reset finished state
    notifyListeners();
  }

  // Optionally, retrieve correct answers for review
  List<Option> getCorrectAnswers() {
    return questions
        .where((question) => question.options
        .any((option) => option.isCorrect && answers[questions.indexOf(question)] == 1))
        .expand((question) => question.options.where((option) => option.isCorrect))
        .toList();
  }

  // Get the total number of correct answers for review
  int getTotalCorrectAnswers() {
    return answers.where((answer) => answer == 1).length;
  }
}
