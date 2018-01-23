# Lamp

A Flutter plugin to access the device's lamp/torch on Android and iOS.

## Usage
To use this plugin, add `lamp` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

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