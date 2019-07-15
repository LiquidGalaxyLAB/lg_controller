import 'package:flutter/material.dart';
import 'package:lg_controller/src/ui/SliderDots.dart';
import 'package:lg_controller/src/utils/SizeScaling.dart';

class CardSlider extends StatefulWidget {
  @override
  _CardSliderState createState() => new _CardSliderState(card_content);

  /// List of widgets to be shown.
  final List<Widget> card_content;

  CardSlider(this.card_content);
}

class _CardSliderState extends State<CardSlider> {
  /// Controller for the page view.
  PageController controller;

  /// Current page position.
  int currentpage = 0;

  /// Instance of slider dots for indication.
  final SliderDots sliderDots;

  /// List of widgets to be shown.
  final List<Widget> card_content;

  _CardSliderState(this.card_content)
      : sliderDots = new SliderDots(card_content.length);

  @override
  initState() {
    super.initState();
    controller = new PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 0.6,
    );
    sliderDots.sliderDotsState.setSliderDotsListener(changePage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  sliderDots.sliderDotsState.setCurrentSelection(value);
                  currentpage = value;
                });
              },
              itemCount: card_content.length,
              controller: controller,
              itemBuilder: (context, index) => getContent(index),
            ),
          ),
          sliderDots,
        ],
      ),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Get content for each card slide.
  Widget getContent(int index) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page - index;
          value = (1 - (value.abs() * 0.5));
        } else {
          if (index != 0) {
            value = value / 2.0;
          }
        }
        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) *
                220 *
                SizeScaling.getWidthScaling(),
            width: Curves.easeOut.transform(value) *
                440 *
                SizeScaling.getWidthScaling(),
            child: Card(
              margin: EdgeInsets.all(
                  16.0 + 16.0 * 0.5 * (SizeScaling.getWidthScaling() - 1)),
              color: Colors.white70,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Container(
                  padding: EdgeInsets.all(
                      8.0 + 8.0 * 0.5 * (SizeScaling.getWidthScaling() - 1)),
                  width: 440 * SizeScaling.getWidthScaling(),
                  height: 220 * SizeScaling.getWidthScaling(),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
      child: card_content[index],
    );
  }

  /// External access to change page.
  changePage(int index) {
    controller.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}
