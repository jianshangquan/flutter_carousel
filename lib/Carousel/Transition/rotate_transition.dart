import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'transition.dart';

class RotateCardTransition extends CarouselTransitionStyle {

  final double maxRotateDeg;
  Offset origin;

  RotateCardTransition({
    required this.maxRotateDeg,
    this.origin = const Offset(0,0)
  });


  /// STYLE 1
  /// maxRotateDeg: 1,
  /// origin: const Offset(0, 0),
  ///
  /// STYLE 2
  /// maxRotateDeg: 0.5,
  /// origin: const Offset(0, 100),
  ///
  /// STYLE 3
  /// maxRotateDeg: 0.5,
  /// origin: const Offset(200, 100),
  ///
  /// STYLE 4
  /// maxRotateDeg: 0.2,
  /// origin: const Offset(-200, 200),

  @override
  Widget buildWidgetOnTranforming(BuildContext context, int index, double transitingValue) {
    assert(widgetBuilder == null);
    double rotateDeg = 0;
    double dx = index - transitingValue;
    late Offset offset;
    print("index $index, dx: $dx");
    if (dx > 0) {
      rotateDeg = maxRotateDeg * dx;
      offset = Offset(
        origin.dx * dx,
        origin.dy * dx,
      );
    } else if (dx < 0) {
      rotateDeg = -maxRotateDeg * dx;
      offset = Offset(
        -origin.dx * dx,
        -origin.dy * dx,
      );
    } else {
      rotateDeg = 0;
      offset = const Offset(0,0);
    }
    return Transform.rotate(
      angle: rotateDeg,
      origin: offset,
      child: widgetBuilder!(context,index),
    );
  }
}
