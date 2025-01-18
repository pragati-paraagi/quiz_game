import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:provider/provider.dart';
import '../provider/scratch_provider.dart';

class ScratchCard extends StatefulWidget {
  const ScratchCard({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing by tapping outside
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ChangeNotifierProvider(
          create: (_) => ScratchCardProvider(), // Provide the ScratchCardProvider
          child: const SizedBox(
            width: 300,
            height: 400, // Increased height for more scratch area
            child: ScratchCard(),
          ),
        ),
      ),
    );
  }

  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  final scratchKey = GlobalKey<ScratcherState>();

  @override
  Widget build(BuildContext context) {
    final scratchProvider = Provider.of<ScratchCardProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Scratcher(
              key: scratchKey,
              brushSize: 30, // Increased brush size
              threshold: 50, // Increased threshold for more scratching area
              color: Colors.amber,
              onChange: (value) {
                if (value >= 0.7 && !scratchProvider.isScratched) {
                  scratchProvider.markScratched(); // Update the state through provider
                }
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      scratchProvider.prizeImage,
                      height: 150, // Increased image size
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      scratchProvider.prize,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22, // Increased text size
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!scratchProvider.isScratched)
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Scratch to reveal!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
