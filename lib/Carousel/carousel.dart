import 'package:flutter/material.dart';
import 'package:flutter_carousel/Carousel/Transition/transition.dart';
import 'package:flutter_carousel/Carousel/dot_option.dart';

class CarouselView<T> extends StatefulWidget {
  CarouselView._({
    required this.itemCount,
    required this.height,
    required this.width,
    required this.pageSnapping,
    required this.viewportFraction,
    required this.itemBuilder,
    required this.carouselTransitionStyle,
    required this.curve,
    this.dotOption,
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
    this.curve = Curves.easeInOutCubic,
    this.dotOption,
    required this.itemBuilder,
    required this.carouselTransitionStyle,
  }) : super(key: key);

  int itemCount;
  double height;
  double width;
  double viewportFraction;
  bool pageSnapping;
  ValueChanged<T>? onPageChanged;
  CarouselTransitionStyle carouselTransitionStyle;
  ScrollPhysics? physics;
  IndexedWidgetBuilder itemBuilder;
  Curve curve;
  DotOption? dotOption;

  @override
  _CarouselViewState<T> createState() => _CarouselViewState<T>();
}

class _CarouselViewState<T> extends State<CarouselView> {
  late final PageController _pageController = PageController(viewportFraction: widget.viewportFraction);
  double _currentPageValue = 0;

  // int _currentSelectedPage = 0;
  ValueNotifier<int> _currentSelectedPage = ValueNotifier(0);

  /// setSate => get called and update [_currentPageValue] position of page scroll
  /// every time the page was scrolled by pixel by user
  ///
  ///
  /// every time [setSate] get called in [_pageController] when user
  /// scroll every pixel and the flutter framework rebuild the PageView
  /// and call the [itemBuilder] function in the PageView Widget
  ///
  ///
  /// [carouselTransitionStyle] call the build function to build the
  /// widget item, how the position or transition of the widget should be,
  /// by providing [index] [_currentPageValue] of each pixel scroll by user
  ///
  ///
  /// [carouselTransitionStyle.build] function define how the widget
  /// item should be
  ///

  @override
  void initState() {
    super.initState();
    widget.carouselTransitionStyle.setItemBuilder(widget.itemBuilder);
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page ?? 0;
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
    List<Widget> col = [
      SizedBox(
          width: widget.width,
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.itemCount,
            onPageChanged: (index) {
              _currentSelectedPage.value = index;
              widget.onPageChanged!(index);
            },
            physics: widget.physics,
            itemBuilder: (context, index) {
              return widget.carouselTransitionStyle.build(context, index, _currentPageValue);
            },
          )),
    ];

    if (widget.dotOption != null) {
      col.addAll([
        const SizedBox(height: 10),
        SizedBox(
          height: widget.dotOption!.dotSize * 1.2,
          child: ValueListenableBuilder(
            valueListenable: _currentSelectedPage,
            builder: (context, index, child){
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  dotBuilder(0),
                  dotBuilder(1),
                  dotBuilder(2),
                  dotBuilder(3),
                  dotBuilder(4),
                  dotBuilder(5),
                  dotBuilder(6),
                ],
              );
            },
          ),
        )
      ]);
    }

    return Column(children: col);
  }

  Widget dotBuilder(int index) {
    return GestureDetector(
      onTap: () {
        _currentSelectedPage.value = index;
        _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: widget.curve);
      },
      child: AnimatedContainer(
        curve: widget.curve,
        width: (index == _currentSelectedPage.value) ? widget.dotOption!.dotSize : widget.dotOption!.dotSize * 0.6,
        height: (index == _currentSelectedPage.value) ? widget.dotOption!.dotSize : widget.dotOption!.dotSize * 0.6,
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          color: (index == _currentSelectedPage.value) ? widget.dotOption!.selectedDotColor : widget.dotOption!.unselectedDotColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
