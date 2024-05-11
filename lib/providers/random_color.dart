import 'dart:math';

import 'package:flutter/material.dart';

Random random = Random();

class RandomColor {
  static int generate() {
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    Color color = Color.fromARGB(255, red, green, 255);
    return color.value;
  }
}
