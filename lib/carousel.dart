import 'package:flutter/material.dart';

class CarouselView extends StatefulWidget {
  CarouselView({
    Key? key,
    required this.items,
    this.height = double.infinity,
    this.width = double.infinity,
    this.viewportFraction = 1,
  }) : super(key: key);

  CarouselView.builder({
    Key? key,
    required this.itemCount,
    this.height = double.infinity,
    this.width = double.infinity,
    this.viewportFraction = 1,
  }) : super(key: key);

  int? itemCount;
  double height;
  double width;
  double viewportFraction;
  List<Widget>? items;

  @override
  _CarouselViewState createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {

  late final PageController _pageController = PageController(viewportFraction: widget.viewportFraction);
  double currentPageValue = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page ?? 0;
        print("");
        print("page is scrolling ${currentPageValue}");
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
              itemCount: widget.items?.length ?? 0,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index){
                double scale = 0;
                if(index == currentPageValue.floor()){ // pre
                  print('floor');
                  scale = 0.9 * (1 - (currentPageValue - index));
                }else if(index == currentPageValue.floor() + 1){ // current
                  print('floor + 1');
                  scale = 0.8 * (index - currentPageValue);
                }else{ // next
                  print("else");
                  scale = 0.8;
                }
                print("build $index, scale: $scale");
                print("-----------------");
                return Transform.scale(
                    scale: scale,
                    child: widget.items![index]
                );
              },
            )
        ),
      ],
    );
  }
}
