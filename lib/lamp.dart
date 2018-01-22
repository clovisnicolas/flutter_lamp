import 'dart:async';

import 'package:flutter/services.dart';

class Lamp {

  static const MethodChannel _channel = const MethodChannel('github.com/clovisnicolas/lamp');
  static Future turn(bool on) => _channel.invokeMethod('turn',{"on" : on});
  static Future<bool> get hasFlash => _channel.invokeMethod('hasFlash');
}
