import 'package:flutter/material.dart';

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, required this.color})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Flex(
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
          ),
        );
      },
    );
  }
}

class DashedLine extends StatelessWidget {
  final double height;
  final double heightContainer;
  final Color color;

  const DashedLine(
      {this.height = 8, required this.color, this.heightContainer = 90});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightContainer,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxHeight = constraints.constrainHeight();
          final dashWidth = 1.0;
          final dashHeight = height;
          final dashCount = (boxHeight / (2 * dashHeight)).floor();
          return Flex(
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.vertical,
          );
        },
      ),
    );
  }
}
