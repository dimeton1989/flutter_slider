part of slider;

class SliderState extends State<Slider> {
  int index = 0;
  AxisDirection axisDirection = AxisDirection.right;
  bool isPlaying = false;

  onPointerSignal(event) {
    if (event is! PointerScrollEvent) return;
    if (isPlaying) return;
    if (event.scrollDelta.dx < 0) {
      if (index <= 0) return;
      return setState(() {
        isPlaying = true;
        index -= 1;
        axisDirection = AxisDirection.left;
      });
    }
    if (event.scrollDelta.dx > 0) {
      if (index >= widget.slides.length - 1) return;
      return setState(() {
        isPlaying = true;
        index += 1;
        axisDirection = AxisDirection.right;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: onPointerSignal,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> listenable) {
          // https://stackoverflow.com/questions/64985580/flutter-web-gesturedetector-detect-mouse-wheel-events
          listenable.addStatusListener((status) {
            if (![
              AnimationStatus.dismissed,
              AnimationStatus.completed,
            ].contains(status)) return;
            isPlaying = false; // 不知道為啥這邊包 setState 會錯
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
