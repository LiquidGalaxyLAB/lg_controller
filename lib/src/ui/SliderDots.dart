import 'package:flutter/material.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

class SliderDots extends StatefulWidget {
  /// Slider dots state instance.
  final _SliderDotsState sliderDotsState;

  @override
  _SliderDotsState createState() => sliderDotsState;

  SliderDots(int itemCount)
      : this.sliderDotsState = new _SliderDotsState(itemCount);
}

class _SliderDotsState extends State<SliderDots>
    with SingleTickerProviderStateMixin {
  /// Number of card slides.
  final int itemCount;

  /// Denotes change in slide.
  Function sliderDotsListener;

  /// Current slide page.
  int current = 0;

  /// Previous slide page.
  int prev = -1;

  /// Controller for the zooming animation of dots.
  AnimationController controller;

  _SliderDotsState(this.itemCount);

  @override
  initState() {
    super.initState();
    current = 0;
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  /// Set current slide page.
  setCurrentSelection(int val) {
    controller.reset();
    controller.forward();
    prev = current;
    setState(() => current = val);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getDots(),
          ),
        ),
      ],
    );
  }

  /// Get the dots widget with appropriate animation.
  getDots() {
    List<Widget> dots = new List<Widget>();
    for (int i = 0; i < itemCount; i++) {
      Animation<double> anim;
      if (i == current)
        anim = Tween<double>(begin: 0, end: 1).animate(controller);
      else if (i == prev)
        anim = Tween<double>(begin: 1, end: 0).animate(controller);
      else if (prev == -1 && i == 0) {
        anim = Tween<double>(begin: 1, end: 1).animate(controller);
      } else
        anim = Tween<double>(begin: 0, end: 0).animate(controller);

      dots.add(AnimatedBuilder(
        animation: anim,
        child: new InkWell(
          onTap: () => sliderDotsListener(i),
        ),
        builder: (BuildContext context, Widget child) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Material(
              color: Colors.white70,
              type: MaterialType.circle,
              child: new Container(
                width: (6 + 6 * 0.6 * (SizeScaling.getWidthScaling() - 1)) +
                    Curves.easeOut.transform(anim.value) *
                        (4 + 4 * 0.3 * (SizeScaling.getWidthScaling() - 1)),
                height: (6 + 6 * 0.6 * (SizeScaling.getWidthScaling() - 1)) +
                    Curves.easeOut.transform(anim.value) *
                        (4 + 4 * 0.3 * (SizeScaling.getWidthScaling() - 1)),
                child: child,
              ),
            ),
          );
        },
      ));
    }
    if (prev == -1) {
      controller.forward();
    }
    return dots;
  }

  /// Set the listner for change in slide page.
  void setSliderDotsListener(Function sliderDotsListener) {
    this.sliderDotsListener = sliderDotsListener;
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}
