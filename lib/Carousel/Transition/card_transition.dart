import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_carousel/Carousel/Transition/transition.dart';

class CardTransition extends CarouselTransitionStyle{
  CardTransition({
    required List<Widget> items,
    required this.minScale,
    required this.maxScale
  }):super(items: items);

  double maxScale;
  double minScale;

  @override
  Widget build(context, index, transitingValue) {
    double scale = maxScale;
    double dx = index - transitingValue;
    if(dx > 0){
      scale =  (1 - (dx.abs() * maxScale)) * maxScale;
    }else if(dx < 0){
      scale =  (1 - (dx.abs() * maxScale)) * maxScale;
    }else{
      scale = maxScale;
    }
    if(scale <= minScale) scale = minScale;
    // print("index $index, dx: $dx, scale: $scale");
    return Transform.scale(
        scale: scale,
        child: items[index]
    );
  }

}