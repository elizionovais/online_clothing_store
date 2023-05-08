import 'package:flutter/material.dart';

class GradientApp extends StatelessWidget {
  GradientApp({
    super.key,
    required this.colors,
    required this.begin,
    required this.end,
  });
  List<Color> colors = [];
  Alignment begin;
  Alignment end;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}
