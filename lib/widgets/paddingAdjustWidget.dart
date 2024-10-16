import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaddingAdjustWidget extends StatelessWidget {

  @required
  final Widget child;
  @required
  final int index;
  @required
  final int itemInRow;
  @required
  final int length;

  PaddingAdjustWidget({required this.child, required this.index, required this.itemInRow ,required this.length});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: index < itemInRow ? const EdgeInsets.fromLTRB(0,5,0,0) : index >= length - itemInRow ? const EdgeInsets.fromLTRB(0,0,0,5) : const EdgeInsets.all(0.0),
      child: child,
    );
  }
}