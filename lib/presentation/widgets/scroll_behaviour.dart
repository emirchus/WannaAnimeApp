import 'package:flutter/material.dart';

class NoGlowBehaviour extends ScrollBehavior{
  const NoGlowBehaviour();
  @override
  Widget buildViewportChrome( BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}