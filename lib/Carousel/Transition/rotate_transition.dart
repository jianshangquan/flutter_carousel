import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_carousel/Carousel/Transition/transition.dart';

class RotateCardTransition extends CarouselTransitionStyle {
  RotateCardTransition({
    required List<Widget> items,
  }) : super(items: items);

  @override
  Widget build(BuildContext context, int index, double transitingValue) {
    return Container();
  }
}
