import 'package:flutter/material.dart';

class InstructionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/img.png'), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Scrollable content with instructions
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    Center(
                      child: Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.7),
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Instruction content
                    Text(
                      '''1. Quiz contains 8 questions.\n
2. Each question carries one point.\n
3. Scoring System:
   • If you score 6, you get 1 point.
   • If you score 7, you get 2 points.
   • If you score 8, you get 3 points.
   • Less than 6 results in 0 points.\n
4. When you earn a total of 10 points, you will unlock a prize through a scratch card, but the prize depends on your luck, as you have to scratch the card.\n
5. After claiming the prize from the scratch card, your score will reset to 0.\n
6. If your previous score exceeded 10 points, the remaining points will be added to your new score.''',
                      textAlign: TextAlign.start, // Left-aligns the text
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        height: 1.5, // Line height for better readability
                        shadows: [
                          Shadow(
                            blurRadius: 3,
                            color: Colors.black.withOpacity(0.7),
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Additional design or elements (if needed)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Navigate back or to another screen
                        },
                        child: Text('Got it!', style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
