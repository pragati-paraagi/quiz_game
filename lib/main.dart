import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz_assignment/provider/navigation.dart';
import 'package:quiz_assignment/provider/quiz_model.dart';
import 'package:quiz_assignment/provider/scratch_provider.dart';
import 'package:quiz_assignment/screens/home_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationModel()),
        ChangeNotifierProvider(create: (context) => QuizModel()),
        ChangeNotifierProvider(create: (_) => ScratchCardProvider()),
        // Add other providers here as needed
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quiz App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            textTheme: GoogleFonts.gabaritoTextTheme(Theme.of(context).textTheme),
            useMaterial3: true,
          ),
          home: HomeScreen(), // Your HomeScreen can now access the Cubit
      ),
    );
  }
}
