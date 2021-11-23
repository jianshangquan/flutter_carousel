import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'transition.dart';

class CardTransition extends CarouselTransitionStyle{
  CardTransition({
    this.minScale = 0.9,
    this.maxScale = 1
  });

  double maxScale;
  double minScale;

  @override
  Widget buildWidgetOnTranforming(context, index, transitingValue) {
    assert(widgetBuilder != null, "widgetBuilder can't be null, try hot restart to solve this problem");
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
        child: widgetBuilder!(context, index)
    );
  }

}