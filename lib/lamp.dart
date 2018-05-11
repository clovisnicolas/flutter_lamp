import 'dart:async';

import 'package:flutter/services.dart';

class Lamp {

  static const MethodChannel _channel = const MethodChannel('github.com/clovisnicolas/flutter_lamp');
  static Future turnOn({double intensity = 1.0}) => _channel.invokeMethod('turnOn', {'intensity' : intensity.clamp(0.01, 1.0)});
  static Future turnOff() => _channel.invokeMethod('turnOff');
  static Future<bool> get hasLamp async => await _channel.invokeMethod('hasLamp');
  static Future flash(Duration duration) => turnOn().whenComplete(() => new Future.delayed(duration, () => turnOff()));

}
