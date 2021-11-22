import 'package:flutter/material.dart';

import 'Carousel/Transition/card_transition.dart';
import 'Carousel/Transition/rotate_transition.dart';
import 'Carousel/carousel.dart';

void main() {
  List<Widget> items = [
    Container(
      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: const Text("0", style: TextStyle(fontSize: 50)),
    ),
    Container(
      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: const Text("1", style: TextStyle(fontSize: 50)),
    ),
    Container(
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: const Text("2", style: TextStyle(fontSize: 50)),
    ),
    Container(
      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: const Text("3", style: TextStyle(fontSize: 50)),
    ),
    Container(
      decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: const Text("4", style: TextStyle(fontSize: 50)),
    ),
    Container(
      decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: const Text("5", style: TextStyle(fontSize: 50)),
    ),
    Container(
      decoration: BoxDecoration(color: Colors.limeAccent, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: const Text("6", style: TextStyle(fontSize: 50)),
    )
  ];

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Carousel"),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CarouselView(
              items: items,
              itemCount: items.length,
              height: 200,
              viewportFraction: 0.7,
              onPageChanged: (index) {
                print('page changed $index');
              },
              carouselTransitionStyle: CardTransition(),
            ),
          )),
    ),
  );
}
