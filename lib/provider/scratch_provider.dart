import 'dart:math';
import 'package:flutter/material.dart';

class ScratchCardProvider with ChangeNotifier {
  bool isScratched = false;
  String prize = '';
  String prizeImage = '';

  ScratchCardProvider() {
    _selectRandomPrize();
  }

  void _selectRandomPrize() {
    final random = Random();
    if (random.nextDouble() < 0.3) {
      final prizes = [
        {'name': 'iPhone 14', 'image': 'images/img_3.png'},
        {'name': 'Headphones', 'image': 'images/img_1.png'},
        {'name': 'Smart Watch', 'image': 'images/smartwatch.png'}
      ];
      final selectedPrize = prizes[random.nextInt(prizes.length)];
      prize = "Congratulations!\nYou won a ${selectedPrize['name']}!";
      prizeImage = selectedPrize['image']!;
    } else {
      prize = "Better luck\nnext time!";
      prizeImage = 'images/img_4.png';
    }
  }

  void markScratched() {
    isScratched = true;
    notifyListeners();
  }
}
