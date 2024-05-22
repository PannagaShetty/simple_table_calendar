import 'package:flutter/material.dart';

class HeaderStyle {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final TextStyle headerTextStyle;
  final Widget? leftArrowIcon;
  final Widget? rightArrowIcon;
  final double arrowSize;
  final Color arrowColor;
  final Color disabledArrowColor;

  HeaderStyle({
    this.padding = const EdgeInsets.all(12.0),
    this.margin = const EdgeInsets.all(0.0),
    this.headerTextStyle = const TextStyle(fontSize: 16),
    this.leftArrowIcon,
    this.rightArrowIcon,
    this.arrowSize = 20,
    this.arrowColor = Colors.black,
    this.disabledArrowColor = Colors.grey,
  });
}
