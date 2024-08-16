import 'dart:async';

import 'package:flutter/material.dart';

class MarqueeListView extends StatefulWidget {
  final Widget? Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final double height;
  final int? animationSeconds;
  const MarqueeListView({
    super.key,
    required this.itemBuilder,
    required this.height,
    required this.itemCount,
    this.animationSeconds,
  });

  @override
  State<MarqueeListView> createState() => _MarqueeListViewState();
}

class _MarqueeListViewState extends State<MarqueeListView> {
  ScrollController scrollController = ScrollController();
  bool isScrolling = false;
  Timer? scrollTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startAutoScroll();
    });
  }

  void startAutoScroll() {
    if (scrollController.hasClients && !isScrolling) {
      double minScrollExtent = scrollController.position.minScrollExtent;
      double maxScrollExtent = scrollController.position.maxScrollExtent;
      animateToMaxMin(maxScrollExtent, minScrollExtent, maxScrollExtent, widget.animationSeconds ?? 25,
          scrollController);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        startAutoScroll();
      });
    }
  }

  animateToMaxMin(
    double max,
    double min,
    double direction,
    int seconds,
    ScrollController scrollController,
  ) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then(
      (value) {
        if (!isScrolling) {
          direction = direction == max ? min : max;
          animateToMaxMin(max, min, direction, seconds, scrollController);
        }
      },
    );
  }

  void restartAutoScroll() {
    scrollTimer?.cancel();
    scrollTimer = Timer(const Duration(seconds: 1), () {
      setState(() {
        isScrolling = false;
      });
      startAutoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          setState(() {
            isScrolling = true;
          });
        } else if (notification is ScrollEndNotification) {
          restartAutoScroll();
        }
        return false;
      },
      child: SizedBox(
        height: widget.height,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.itemCount,
          itemBuilder: widget.itemBuilder,
        ),
      ),
    );
  }
}
