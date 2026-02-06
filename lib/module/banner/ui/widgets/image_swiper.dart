import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class FadeCardSwiper extends StatefulWidget {
  final List<Widget> banners;

  const FadeCardSwiper({
    super.key,
    required this.banners,
  });

  @override
  State<FadeCardSwiper> createState() => _FadeCardSwiperState();
}

class _FadeCardSwiperState extends State<FadeCardSwiper> {
  int _active = 0;

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: widget.banners.length,
      autoplay: true,
      autoplayDelay: 3500,
      viewportFraction: 1,
      scale: 1,
      onIndexChanged: (i) => setState(() => _active = i),
      itemBuilder: (context, index) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: index == _active ? 1 : 0,
          child: widget.banners[index],
        );
      },
    );
  }
}
