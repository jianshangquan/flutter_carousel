import 'package:flutter/material.dart';
import 'package:flutter_carousel/Carousel/Transition/transition.dart';
import 'Dot/dot.dart';
import 'package:flutter_carousel/Carousel/Dot/dot_option.dart';

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
    required this.initialIndex,
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
    this.initialIndex = 0,
    required this.itemBuilder,
    required this.carouselTransitionStyle,
  }) : super(key: key);

  int itemCount;
  int initialIndex;
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
  late final PageController _pageController;
  late ValueNotifier<int> _currentSelectedPage;
  double _currentPageValue = 0;

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
  /// [carouselTransitionStyle.buildWidgetOnTranforming] function define how the widget
  /// item should be
  ///

  @override
  void initState() {
    super.initState();
    _currentSelectedPage = ValueNotifier(widget.initialIndex);
    widget.carouselTransitionStyle.setItemBuilder(widget.itemBuilder);
    _pageController = PageController(viewportFraction: widget.viewportFraction, initialPage: widget.initialIndex);
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
    _currentSelectedPage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.carouselTransitionStyle.widgetBuilder == null)
      widget.carouselTransitionStyle.setItemBuilder(widget.itemBuilder);
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
              return widget.carouselTransitionStyle.buildWidgetOnTranforming(context, index, _currentPageValue);
            },
          )),
    ];

    if (widget.dotOption != null) {
      List<Dot> dots = [];
      for(var i = 0; i < widget.itemCount; i++){
        dots.add(Dot(
          index: i,
          dotOption: widget.dotOption!,
          isSelected: (_currentSelectedPage.value == i),
          onTap: (){
            _currentSelectedPage.value = i;
            _pageController.animateToPage(i, duration: widget.dotOption!.duration, curve: widget.curve);
          },
        ));
      }

      col.addAll([
        const SizedBox(height: 10),
        SizedBox(
          height: widget.dotOption!.dotSize * 1.2,
          child: ValueListenableBuilder(
            valueListenable: _currentSelectedPage,
            builder: (context, index, child){
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: dots,
              );
            },
          ),
        )
      ]);
    }

    return Column(children: col);
  }
}
