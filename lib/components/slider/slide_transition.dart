part of slider;

class SlideTransition extends AnimatedWidget {
  final Widget child;

  final AxisDirection direction;

  const SlideTransition({
    super.key,
    this.direction = AxisDirection.left,
    required super.listenable,
    required this.child,
  });

  // https://blog.logrocket.com/understanding-offsets-flutter/#:~:text=What%20are%20Offsets%3F,be%20interpreted%20as%20a%20vector.
  double get offsetDirection {
    switch (direction) {
      case AxisDirection.right:
        return 0 * pi / 180;
      case AxisDirection.up:
        return 90 * pi / 180;
      case AxisDirection.left:
        return 180 * pi / 180;
      case AxisDirection.down:
        return 270 * pi / 180;
      default:
        return 0;
    }
  }

  @override
  Widget build(Object context) {
    final animation = listenable as Animation<double>;
    var distance = 1 - animation.value;
    if (animation.status == AnimationStatus.reverse) {
      distance = -distance;
    }
    return FadeTransition(
      opacity: animation,
      child: FractionalTranslation(
        translation: Offset.fromDirection(offsetDirection, distance),
        child: child,
      ),
    );
  }
}
