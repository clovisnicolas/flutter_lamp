import 'dart:async';

import 'package:flutter/services.dart';

class Lamp {

  static const MethodChannel _channel = const MethodChannel('github.com/clovisnicolas/lamp');
  static Future turnOn() => _channel.invokeMethod('turnOn');
  static Future turnOff() => _channel.invokeMethod('turnOff');
  static Future<bool> get hasLamp => _channel.invokeMethod('hasLamp');
}
