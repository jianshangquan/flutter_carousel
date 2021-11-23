import 'package:flutter/material.dart';

import 'transition.dart';

class ThreeDCardTransition extends CarouselTransitionStyle{

  @override
  Widget buildWidgetOnTranforming(BuildContext context, int index, double transitingValue) {
    return Container();
  }
}