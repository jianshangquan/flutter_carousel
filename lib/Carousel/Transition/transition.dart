import 'package:flutter/material.dart';

abstract class CarouselTransitionStyle{
  late List<Widget> items;
  CarouselTransitionStyle();
  setItems(List<Widget> items){
    this.items = items;
  }
  Widget build(BuildContext context, int index, double transitingValue);
}