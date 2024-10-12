import 'package:flutter/material.dart';

class FeedPicturesSliders extends StatelessWidget {
  FeedPicturesSliders({super.key});
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    const imageCount = 4;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: imageCount,
            itemBuilder: (context, index){
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/temp/carousel-item.png',
                  height: 210,
                  // width: double.infinity,
                  fit: BoxFit.cover,),
              );
            }),

        Positioned(
            bottom: 10,
            child: _SliderIndicator(totalCount: imageCount, pageController: _pageController,))

      ],
    );
  }
}

class _SliderIndicator extends StatefulWidget {
  final int totalCount;
  final PageController pageController;
  const _SliderIndicator({super.key, required this.totalCount, required this.pageController});

  @override
  State<_SliderIndicator> createState() => _SliderIndicatorState();
}

class _SliderIndicatorState extends State<_SliderIndicator> {

  int activeIndex = 0;
  @override
  void initState() {
    super.initState();

    widget.pageController.position.addListener(() {
      setState(() {
        activeIndex = widget.pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(widget.totalCount, (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: index != activeIndex ? 4 : 20,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.5)
          ),
        ))
      ],
    );
  }
}

