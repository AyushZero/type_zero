import 'dart:async';

class TextFadeTimer {
  static void startFadeTimer(Function callback) {
    Timer(Duration(seconds: 2), () => callback());
  }
}
