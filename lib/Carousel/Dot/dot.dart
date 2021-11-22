import 'package:flutter/material.dart';
import 'package:flutter_carousel/Carousel/Dot/dot_option.dart';

class Dot extends StatelessWidget {
  DotOption dotOption;
  VoidCallback onTap;
  Curve curve;
  bool isSelected;
  int index;

  Dot({
    Key? key,
    required this.dotOption,
    required this.index,
    required this.onTap,
    required this.isSelected,
    this.curve = Curves.easeInOutCubic
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        curve: curve,
        width: isSelected ? dotOption.dotSize : dotOption.dotSize * 0.6,
        height: isSelected ? dotOption.dotSize : dotOption.dotSize * 0.6,
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          color: isSelected ? dotOption.selectedDotColor : dotOption.unselectedDotColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
