import 'package:flutter/material.dart';


/// [CarouselTransitionStyle] define the prototype of
/// how the element will be position or transition
/// when the user scroll on every each pixel from Carousel class
///
///
/// [buildWidgetOnTranforming] function
/// how the each element of visible carousel item
/// will be positioned or transition duration scrolling by user
///
/// the pageController will call setState on each scroll and therefore
/// build method will be rebuild and therefore
/// that function will get called on [PageView] itemBuilder and
///


abstract class CarouselTransitionStyle{
  late IndexedWidgetBuilder widgetBuilder;
  CarouselTransitionStyle();
  setItemBuilder(IndexedWidgetBuilder widgetBuilder){
    this.widgetBuilder = widgetBuilder;
  }
  Widget buildWidgetOnTranforming(BuildContext context, int index, double transitingValue);
}