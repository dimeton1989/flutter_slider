part of slider;

class SliderState extends State<Slider> {
  int index = 0;
  AxisDirection axisDirection = AxisDirection.right;
  bool isScrolling = false;
  Timer? timer;

  onPointerSignal(event) {
    if (isScrolling) return;
    if (event.scrollDelta.dx == 0) return;
    if (event.scrollDelta.dx < 0) {
      isScrolling = true;
      axisDirection = AxisDirection.left;
      if (index <= 0) return;
      return setState(() => index -= 1);
    }

    if (event.scrollDelta.dx > 0) {
      isScrolling = true;
      axisDirection = AxisDirection.right;
      if (index >= widget.slides.length - 1) return;
      return setState(() => index += 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/64985580/flutter-web-gesturedetector-detect-mouse-wheel-events
    return Listener(
      onPointerSignal: (event) {
        if (event is! PointerScrollEvent) return;
        onPointerSignal(event);
        return;
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> listenable) {
          listenable.addStatusListener((status) {
            if (!isScrolling) return;
            if (status != AnimationStatus.completed) return;
            if (timer?.isActive ?? false) return timer!.cancel();
            timer = Timer(const Duration(milliseconds: 1200), () => isScrolling = false);
          });
          return SlideTransition(
            axisDirection: axisDirection,
            listenable: listenable,
            child: child,
          );
        },
        child: IndexedStack(
          key: ValueKey<int>(index),
          index: index,
          children: widget.slides,
        ),
      ),
    );
  }
}
