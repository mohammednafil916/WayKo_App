import 'dart:async';
import 'package:flutter/material.dart';

class BannerImages extends StatefulWidget {
  const BannerImages({super.key});

  @override
  State<BannerImages> createState() => _BannerImagesState();
}

class _BannerImagesState extends State<BannerImages> {
  final PageController controller = PageController();
  int currentPage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      currentPage++;
      if (currentPage == 3) {
        currentPage = 0;
      }

      controller.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView(
        controller: controller,
        children: [
          Image.asset("assets/images/wayko-banner1.png", fit: BoxFit.fill),
          Image.asset("assets/images/wayko-banner2.png", fit: BoxFit.fill),
          Image.asset("assets/images/wayko-banner3.png", fit: BoxFit.fill),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }
}
