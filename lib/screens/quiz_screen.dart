import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_assignment/screens/score_screen.dart';
import 'package:quiz_assignment/widgets/checkAnswer.dart';
import 'package:quiz_assignment/widgets/completed.dart';
import 'package:quiz_assignment/widgets/loader.dart';
import 'package:quiz_assignment/widgets/next_button.dart';
import 'package:quiz_assignment/provider/quiz_model.dart';

class Quiz_Screen extends StatelessWidget {
  const Quiz_Screen({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text('Are you sure?'),
        content: Text('Do you want to exit the quiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Reset the quiz before exiting
              Provider.of<QuizModel>(context, listen: false).resetQuiz();
              Navigator.of(context).pop(true);
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Initialize quiz data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizModel>(context, listen: false).initQuiz();
    });

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Consumer<QuizModel>(
        builder: (context, quizModel, child) {
          return Scaffold(
            body: SafeArea(
              child: quizModel.isLoading
                  ? Center(child: Loader())
                  : quizModel.questions.isEmpty
                      ? Center(child: Text('No questions available'))
                      : Stack(
                          children: [
                            // Background image
                            Positioned.fill(
                              child: Image.asset(
                                'images/img.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  // Progress bar with updated colors
                                  SizedBox(height: 40),
                                  isDone(
                                    currentQuestionIndex: quizModel.currentQuestionIndex,
                                    questions: quizModel.questions,
                                  ),
                                  SizedBox(height: 40),

                                  // Question
                                  Text(
                                    quizModel.questions[quizModel.currentQuestionIndex].description,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),

                                  // Options with updated colors
                                  if (quizModel.questions[quizModel.currentQuestionIndex].options.isEmpty)
                                    Center(child: Text('No options available'))
                                  else
                                    ...quizModel.questions[quizModel.currentQuestionIndex].options.map((option) {
                                      Color containerColor = Colors.white;
                                      Color textColor = Colors.black;

                                      if (quizModel.isAnswered) {
                                        if (option == quizModel.selectedOption) {
                                          if (option.isCorrect) {
                                            containerColor = Colors.green;
                                            textColor = Colors.white;
                                          } else {
                                            containerColor = Colors.red;
                                            textColor = Colors.white;
                                          }
                                        } else {
                                          if (!option.isCorrect) {
                                            containerColor = Colors.white;
                                            textColor = Colors.black;
                                          }
                                        }
                                      }

                                      return CheckAnswer(
                                        option: option,
                                        onOptionSelected: (option) {
                                          quizModel.checkAnswer(option);
                                        },
                                        containerColor: containerColor,
                                        textColor: textColor,
                                      );
                                    }).toList(),

                                  Expanded(child: SizedBox()),

                                  // Next button
                                  if (quizModel.isAnswered)
                                    NextButton(
                                      onPressed: () {
                                        if (quizModel.currentQuestionIndex < quizModel.questions.length - 1) {
                                          quizModel.nextQuestion(context);
                                        } else {
                                          Navigator.pushReplacement(
                                            context,
                                            _fadeTransition(ScoreScreen()),
                                          );
                                        }
                                      },
                                      currentQuestionIndex: quizModel.currentQuestionIndex,
                                      totalQuestions: quizModel.questions.length,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }
  PageRouteBuilder _fadeTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
