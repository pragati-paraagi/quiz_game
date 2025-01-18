import 'package:flutter/material.dart';

class isDone extends StatefulWidget {
  final int currentQuestionIndex;
  final List<dynamic> questions;

  const isDone({
    super.key,
    required this.currentQuestionIndex,
    required this.questions,
  });

  @override
  State<isDone> createState() => _isDoneState();
}

class _isDoneState extends State<isDone> {
  @override
  Widget build(BuildContext context) {
    return Container(
                              height: 13,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor:
                                    (widget.currentQuestionIndex + 1) / widget.questions.length,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 175, 88, 12), // Changed to orange when complete
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            );
  }
}