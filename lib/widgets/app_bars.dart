import 'package:flutter/material.dart';
class AppBars{
  static defaultAppBar(String title, {Color color = Colors.black} ){
    return AppBar(
      backgroundColor: color,
      title: Center(
        child: Text(title),
      ),
    );
  }
}