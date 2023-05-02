part of slider;

class SliderState extends State<Slider> {
  int index = 0;
  AxisDirection direction = AxisDirection.right;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: index > 0,
              child: ElevatedButton(
                onPressed: () => isPlaying
                    ? null
                    : setState(() {
                        direction = AxisDirection.left;
                        index += -1;
                        isPlaying = true;
                      }),
                child: const Text('上一頁'),
              ),
            ),
            Visibility(
              visible: index < widget.slides.length - 1,
              child: ElevatedButton(
                onPressed: () => isPlaying
                    ? null
                    : setState(() {
                        direction = AxisDirection.right;
                        index += 1;
                        isPlaying = true;
                      }),
                child: const Text('下一頁'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
