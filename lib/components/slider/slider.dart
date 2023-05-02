library slider;

import 'package:flutter/gestures.dart' show PointerScrollEvent;
import 'package:flutter/material.dart' hide Slider;
import 'dart:math' show pi;
import 'dart:developer' show log;

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
