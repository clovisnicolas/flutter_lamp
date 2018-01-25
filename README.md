# Lamp
[![pub package](https://img.shields.io/pub/v/lamp.svg)](https://pub.dartlang.org/packages/lamp)
A Flutter plugin to access the device's lamp/torch on Android and iOS.

## Usage
To use this plugin, add `lamp` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

For android, add the following to your manifest

``` 
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.FLASHLIGHT" />
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera.autofocus" />
<uses-feature android:name="android.hardware.camera.flash" />
``` 

## Example
``` dart
// Import package
import 'package:lamp/lamp.dart';

// Turn the lamp on:
Lamp.turnOn();

// Turn the lamp off:
Lamp.turnOff();

// Turn the lamp with a specific intensity (only affects iOS as of now):
Lamp.turnOn(intensity: 0.4);

// Check if the device has a lamp:
bool hasLamp = await Lamp.hasLamp;

```
