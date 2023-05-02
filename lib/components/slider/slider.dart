library slider;

import 'package:flutter/material.dart' hide Slider;
import 'dart:math';

part 'slider_state.dart';
part 'slide_transition.dart';

class Slider extends StatefulWidget {
  final List<Widget> slides;
  const Slider({super.key, required this.slides});

  @override
  State<StatefulWidget> createState() {
    return SliderState();
  }
}
