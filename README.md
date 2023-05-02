### 心得
1. 最重要的是去改變 AnimationSwitcher child 的 key 值，誘發 TransitionBuilder 重 build。
2. 預設的 Transition 是淡入淡出，我們可以透過指定 transitionBuilder，將 Transition 換成其他 Transition 或者客製的 Transition。
3. 整個過程我們可以指定動畫長度即可，不必另外產一個 Animation 物件。