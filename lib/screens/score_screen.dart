import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_assignment/database/database_helper.dart';
import 'package:quiz_assignment/provider/quiz_model.dart';
import 'package:quiz_assignment/screens/quiz_screen.dart';
import 'package:confetti/confetti.dart';
import 'package:quiz_assignment/screens/scratch_card.dart';

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _coinAnimationController;
  late Animation<double> _coinAnimation;
  int _coins = 0;
  int _totalCoins = 0;
  bool _showScratchCard = false;
  final int _maxCoins = 10;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 10));

    _coinAnimationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _coinAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _coinAnimationController, curve: Curves.easeOut),
    );

    final quizModel = Provider.of<QuizModel>(context, listen: false);
    final score = quizModel.score;

    // Calculate coins based on score
    if (score == 8) {
      _coins = 3;
    } else if (score == 7) {
      _coins = 2;
    } else if (score == 6) {
      _coins = 1;
    }

    // Load existing coins from the database
    _loadCoins();

    if (score >= 6) {
      _confettiController.play();
      _coinAnimationController.forward();
    }
  }

  Future<void> _loadCoins() async {
    int currentCoins = await DatabaseHelper.instance.getCoinCount();
    setState(() {
      _totalCoins = currentCoins + _coins;

      // Check if total coins reaches 10
      if (_totalCoins >= _maxCoins) {
        _showScratchCard = true;
        // Reset coins to 0 after reaching 10
        _totalCoins = _totalCoins - _maxCoins;
      }

      // Save the updated coin count back to the database
      DatabaseHelper.instance.updateCoinCount(_totalCoins);
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _coinAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final score = quizModel.score;
    final totalQuestions = 8;
    final percentage = (score / totalQuestions * 100).toInt();

    String _getScoreMessage() {
      if (score == 0) return "Study Hard!";
      if (score == 8) return "Science Genius!";
      if (score >= 6) return "Excellent Work!";
      if (score >= 4) return "Good Job!";
      return "Keep Practicing!";
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/img.png',
              fit: BoxFit.cover,
            ),
          ),

          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            colors: [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.purple],
            gravity: 0.5,
          ),

          // Total coins display at top right
          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.amber, size: 24),
                SizedBox(width: 4),
                Text(
                  '$_totalCoins/$_maxCoins',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getScoreMessage(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 20),

                if (_coins > 0) ...[
                  FadeTransition(
                    opacity: _coinAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.monetization_on, color: Colors.amber, size: 32),
                        SizedBox(width: 8),
                        Text(
                          '+$_coins coins!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],

                if (_showScratchCard)
                  ElevatedButton(
                    onPressed: () {
                      ScratchCard.show(context);
                      setState(() {
                        _showScratchCard = false;
                      });
                    },
                    child: Text('Claim Scratch Card!',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 220, 169, 17),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),

                SizedBox(height: 40),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: CircularProgressIndicator(
                        value: score / totalQuestions,
                        strokeWidth: 15,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(percentage >= 70
                            ? Colors.green
                            : percentage >= 40
                            ? Colors.orange
                            : Colors.red),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$percentage%',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$score/$totalQuestions',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            quizModel.resetQuiz();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Quiz_Screen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            backgroundColor: Color.fromARGB(255, 154, 64, 4),
                          ),
                          child: Text('Restart Quiz', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            quizModel.resetQuiz();
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            backgroundColor: Color.fromARGB(255, 154, 64, 4),
                          ),
                          child: Text('Exit', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
