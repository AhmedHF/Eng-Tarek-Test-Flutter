import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  final Color color;
  final double scale;
  final double? value;
  const AppLoading({
    Key? key,
    this.color = Colors.white,
    this.scale = 0.7,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: scale,
        child: Platform.isIOS
            ? CupertinoActivityIndicator(
                radius: 15,
              )
            : CircularProgressIndicator(
                color: color,
                value: value,
              ),
      ),
    );
  }
}
