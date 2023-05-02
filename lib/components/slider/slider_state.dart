part of slider;

class SliderState extends State<Slider> {
  int index = 0;
  AxisDirection direction = AxisDirection.right;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        if (event is! PointerScrollEvent) return;
        if (isPlaying) return;
        log(event.toString(), level: 1000);
        if (event.scrollDelta.dx < 0) {
          if (index <= 0) return;
          return setState(() {
            isPlaying = true;
            index -= 1;
            direction = AxisDirection.left;
          });
        }
        if (event.scrollDelta.dx > 0) {
          if (index >= widget.slides.length - 1) return;
          return setState(() {
            isPlaying = true;
            index += 1;
            direction = AxisDirection.right;
          });
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> listenable) {
          // https://stackoverflow.com/questions/64985580/flutter-web-gesturedetector-detect-mouse-wheel-events
          listenable.addStatusListener((status) {
            if (![
              AnimationStatus.completed,
              AnimationStatus.dismissed,
            ].contains(status)) return;
            isPlaying = false;
          });
          return SlideTransition(
            direction: direction,
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
