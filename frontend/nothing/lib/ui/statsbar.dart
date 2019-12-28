import 'package:flutter/material.dart';

class StatsBar extends StatelessWidget {
  final double value;
  final double height;
  const StatsBar({
    @required this.value,
    @required this.height,
  }) : assert(value >= 0 && value <= 1);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Container(
                color: Color(0xffd5c4a1), //0xffd65d0e //0xff427b58
                width: constraints.maxWidth,
                height: height,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                color: Color(0xff665c54),
                width: constraints.maxWidth * value,
                height: height,
              ),
            ],
          ),
        ),
      ),
      LayoutBuilder(
        builder: (context, constraints) => Container(
          // color: Color(0xff32302f),
          width: constraints.maxWidth,
          height: height,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(16),
          //   border: Border.all(
          //     color: Color(0xff32302f),
          //     width: 4,
          //   ),
          // ),
        ),
      )
    ]);
  }
}
