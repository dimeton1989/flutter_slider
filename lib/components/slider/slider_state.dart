part of slider;

class SliderState extends State<Slider> {
  int index = 0;
  AxisDirection direction = AxisDirection.right;
  bool isPlaying = false;
  double left = 0;
  double top = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (DragDownDetails event) => setState(() {
        left = 0;
        top = 0;
      }),
      onPanUpdate: (DragUpdateDetails event) => setState(() {
        left += event.delta.dx;
        top += event.delta.dy;
      }),
      onPanEnd: (DragEndDetails event) => setState(() {
        // event.velocity;
        if (left < 0) {
          if (index <= 0) return;
          return setState(() {
            index -= 1;
            direction = AxisDirection.left;
            isPlaying = true;
          });
        }

        if (left > 0) {
          if (index >= widget.slides.length - 1) return;
          return setState(() {
            index += 1;
            direction = AxisDirection.right;
            isPlaying = true;
          });
        }
      }),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> listenable) {
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
