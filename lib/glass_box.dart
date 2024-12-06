import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget {
  final _borderRadius = BorderRadius.circular(20);
  final height;
  final width;
  final child;
  GlassBox({
    required this.height,
    required this.width,
    required this.child
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: _borderRadius,
                 
              ),
            ),
            child
          ], 
        ),
      ),
    );
  }
}