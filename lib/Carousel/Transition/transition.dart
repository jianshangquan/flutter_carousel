import 'package:flutter/material.dart';

abstract class CarouselTransitionStyle{
  List<Widget> items;
  CarouselTransitionStyle({required this.items});
  Widget build(BuildContext context, int index, double transitingValue);
}