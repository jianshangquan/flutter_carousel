import 'package:flutter/material.dart';

class CarouselView extends StatefulWidget {
  CarouselView({
    Key? key,
    required this.items,
    this.height = double.infinity,
    this.width = double.infinity,
  }) : super(key: key);

  CarouselView.builder({
    Key? key,
    required this.itemCount,
    this.height = double.infinity,
    this.width = double.infinity,
  }) : super(key: key);

  int? itemCount;
  double height;
  double width;
  List<Widget>? items;

  @override
  _CarouselViewState createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {

  PageController _pageController = PageController();
  double currentPageValue = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page ?? 0;
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
                print('builder index $index, floor: ${currentPageValue.floor()} pagevalue: ${currentPageValue.toStringAsFixed(2)}, diff:(i-page)  ${(index - currentPageValue).toStringAsFixed(2)}, diff:(page-i)  ${(currentPageValue - index).toStringAsFixed(2)}');
                if (index == currentPageValue.floor()) {
                  print("floor");
                  return Transform.scale(
                      scale: (1 - (currentPageValue - index)) * 0.8,
                      child: widget.items![index]
                  );
                } else if(index == currentPageValue.floor() + 1) {
                  print("floor + 1");
                  return Transform.scale(
                      scale: (1 - (index - currentPageValue)) * 0.8,
                      child: widget.items![index]
                  );
                }else{
                  print('else');
                  return Transform.scale(
                      scale: 0.8,
                      child: widget.items![index]
                  );
                }
              },
            )
        ),
      ],
    );
  }
}
