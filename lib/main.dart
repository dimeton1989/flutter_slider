import 'package:flutter/material.dart' hide Slider;
import 'components/slider/slider.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: Slider(
        slides: <Widget>[
          Text('slide 1'),
          Text('slide 2'),
          Text('slide 3'),
          Text('slide 4'),
          Text('slide 5'),
        ],
      ),
    ),
  );
}
