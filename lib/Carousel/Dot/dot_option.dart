import 'package:flutter/material.dart';

class DotOption {
  Color selectedDotColor;
  Color unselectedDotColor;
  double dotSize;
  Duration duration;

  DotOption({
    this.selectedDotColor = Colors.black,
    this.unselectedDotColor = Colors.grey,
    this.dotSize = 20,
    this.duration = const Duration(milliseconds: 250)
  });
}