import 'package:flutter/material.dart';
import 'package:flutter_carousel/Carousel/Transition/transition.dart';

class CarouselView<T> extends StatefulWidget {

  CarouselView._({
    required this.itemCount,
    required this.height,
    required this.width,
    required this.pageSnapping,
    required this.viewportFraction,
    required this.showDots,
    required this.items,
    required this.carouselTransitionStyle,
    this.onPageChanged,
  });

  CarouselView({
    Key? key,
    required this.itemCount,
    this.height = double.infinity,
    this.width = double.infinity,
    this.viewportFraction = 1,
    this.pageSnapping = false,
    this.onPageChanged,
    this.physics = const BouncingScrollPhysics(),
    this.showDots = true,
    required this.items,
    required this.carouselTransitionStyle,
  }) : super(key: key);

  int itemCount;
  double height;
  double width;
  double viewportFraction;
  bool pageSnapping;
  bool showDots;
  List<Widget> items;
  ValueChanged<T>? onPageChanged;
  CarouselTransitionStyle carouselTransitionStyle;
  ScrollPhysics? physics;

  @override
  _CarouselViewState<T> createState() => _CarouselViewState<T>();
}

class _CarouselViewState<T> extends State<CarouselView> {

  late final PageController _pageController = PageController(viewportFraction: widget.viewportFraction);
  double currentPageValue = 0;

  @override
  void initState() {
    super.initState();
    widget.carouselTransitionStyle.setItems(widget.items);
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page ?? 0;
        // print("");
        // print("page is scrolling ${currentPageValue}");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: widget.width,
            height: widget.height,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.itemCount,
              onPageChanged: widget.onPageChanged,
              physics: widget.physics,
              itemBuilder: (context, index){
                return widget.carouselTransitionStyle.build(context, index, currentPageValue);
              },
            )
        ),
      ],
    );
  }
}
