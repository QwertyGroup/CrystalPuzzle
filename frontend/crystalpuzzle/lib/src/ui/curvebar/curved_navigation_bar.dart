import 'dart:ui';

import 'package:crystalpuzzle/src/ui/curvebar/clip_path.dart';
import 'package:crystalpuzzle/src/ui/curvebar/nav_button.dart';
import 'package:crystalpuzzle/src/ui/curvebar/nav_custom_painter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CurvedNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int index;
  final Color color;
  final Color buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int> onTap;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final bool useSlide;

  CurvedNavigationBar({
    Key key,
    @required this.items,
    this.index = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.backgroundColor = Colors.blueAccent,
    this.onTap,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.height = 75.0,
    this.useSlide = true,
  })  : assert(items != null),
        assert(items.length >= 1),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar>
    with SingleTickerProviderStateMixin {
  double _startingPos;
  int _endingIndex = 0;
  double _pos;
  double _buttonHide = 0;
  Widget _icon;
  AnimationController _animationController;
  int _length;

  @override
  void initState() {
    super.initState();
    _icon = widget.items[widget.index];
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void slide(Offset offset, Offset delta) {
      {
        // print(delta.distanceSquared);
        if (delta.distanceSquared > 15) {
          return;
        }
        var idx = (offset.dx * _length) ~/ size.width;
        if (idx < 0) idx = 0;
        if (idx >= _length) idx = _length - 1;
        _buttonTap(idx);
      }
    }

    Widget decorateWithSlide(Widget wg) {
      if (widget.useSlide) {
        return GestureDetector(
            onHorizontalDragUpdate: (upd) => slide(
                  upd.localPosition,
                  upd.delta,
                ),
            onHorizontalDragDown: (upd) => slide(
                  upd.localPosition,
                  Offset.zero,
                ),
            child: wg);
      } else {
        return wg;
      }
    }

    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: -40 - (75.0 - widget.height),
            left: Directionality.of(context) == TextDirection.rtl
                ? null
                : _pos * size.width,
            right: Directionality.of(context) == TextDirection.rtl
                ? _pos * size.width
                : null,
            width: size.width / _length,
            child: Center(
              child: Transform.translate(
                offset: Offset(
                  0,
                  -(1 - _buttonHide) * 80,
                ),
                child: Material(
                  color: Color(0x44000000),
                  type: MaterialType.circle,
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _icon,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0 - (75.0 - widget.height),
            // child: CustomPaint(
            //   painter: NavCustomPainter(
            //       _pos, _length, widget.color, Directionality.of(context),),
            //   child: Container(
            //     height: 75.0,
            //   ),
            // ),
            child: ClipPath(
              clipper: CustomClipPath(
                _pos,
                _length,
                widget.color,
                Directionality.of(context),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: CustomPaint(
                  painter: NavCustomPainter(
                    _pos,
                    _length,
                    Color(0x44000000),
                    // widget.color,
                    Directionality.of(context),
                  ),
                  child: Container(
                    height: 75.0,
                    // color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0 - (75.0 - widget.height),
            child: SizedBox(
              height: 100.0,
              child: decorateWithSlide(Row(
                  children: widget.items.map((item) {
                return NavButton(
                  onTap: _buttonTap,
                  position: _pos,
                  length: _length,
                  index: widget.items.indexOf(item),
                  child: item,
                );
              }).toList())),
            ),
          ),
        ],
      ),
    );
  }

  void setPage(int index) {
    _buttonTap(index, notifyListener: false);
  }

  int _currentExecuting;

  void _buttonTap(int index, {bool notifyListener = true}) {
    if (_currentExecuting != null && _currentExecuting == index) {
      return;
    }
    if (notifyListener && widget.onTap != null) {
      widget.onTap(index);
    }
    _currentExecuting = index;
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    });
  }
}
