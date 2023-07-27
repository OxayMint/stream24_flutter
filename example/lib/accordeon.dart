import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Accordeon extends StatefulWidget {
  final String label;
  Widget widget;
  bool defaultOpen;
  // List<String> selectedItems;

  Accordeon({
    required this.label,
    required this.widget,
    this.defaultOpen = false,
  });
  @override
  _AccordeonState createState() => _AccordeonState(defaultOpen);
}

class _AccordeonState extends State<Accordeon> with TickerProviderStateMixin {
  bool _isOpen;
  _AccordeonState(this._isOpen);
  late AnimationController arrowController;

  @override
  void initState() {
    arrowController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 5),
      curve: Curves.decelerate,
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isOpen = !_isOpen;
                if (_isOpen) {
                  arrowController.forward();
                } else {
                  arrowController.reverse();
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  AnimatedBuilder(
                      animation: arrowController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: arrowController.value * pi,
                          child: child,
                        );
                      },
                      child: Icon(Icons.keyboard_arrow_down_rounded)),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
          ),
          Offstage(offstage: !_isOpen, child: widget.widget)
        ],
      ),
    );
  }
}
