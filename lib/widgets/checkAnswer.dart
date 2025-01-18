import 'package:flutter/material.dart';
import 'package:quiz_assignment/models/ques_model.dart';

class CheckAnswer extends StatefulWidget {
  final Option option;
  final Function(Option) onOptionSelected;
  final Color containerColor;
  final Color textColor;

  const CheckAnswer({
    super.key,
    required this.option,
    required this.onOptionSelected,
    required this.containerColor,
    required this.textColor,
  });

  @override
  State<CheckAnswer> createState() => _CheckAnswerState();
}

class _CheckAnswerState extends State<CheckAnswer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => widget.onOptionSelected(widget.option),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.containerColor,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.option.text,
            style: TextStyle(
              fontSize: 16,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}