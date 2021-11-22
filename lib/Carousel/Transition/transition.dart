import 'package:flutter/material.dart';


/// [CarouselTransitionStyle] define the prototype of
/// how the element will be position or transition
/// when the user scroll on every each pixel from Carousel class


abstract class CarouselTransitionStyle{
  late List<Widget> items;
  CarouselTransitionStyle();
  setItems(List<Widget> items){
    this.items = items;
  }
  Widget build(BuildContext context, int index, double transitingValue);
}