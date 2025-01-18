import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_assignment/provider/navigation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'instructions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image covering the entire screen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/img.png'), // Path to your image
                fit: BoxFit.cover, // Ensures the image covers the whole screen
              ),
            ),
          ),
          // Instructions button at top
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.info_outline, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructionScreen()),
                );
              },
            ),
          ),
          // Positioned text with glowing effect
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "QUIZ APP" text with a glowing effect and animation
                TypewriterAnimatedTextKit(
                  isRepeatingAnimation: true,
                  speed: Duration(milliseconds: 400),
                  text: ['QUIZ APP'],
                  textStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.white, // Glow color
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5), // Space between heading and tagline
                // Tagline text
                Text(
                  'The Ultimate Trivia Challenge',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 270, // Adjust distance from the bottom
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                context.read<NavigationModel>().navigateToQuiz(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color.fromARGB(255, 154, 64, 4), // Adjust the button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Rounded corners
                ),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: Text('Start',style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
