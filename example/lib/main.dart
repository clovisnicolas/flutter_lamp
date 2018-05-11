import 'package:flutter/material.dart';
import 'package:lamp/lamp.dart';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasFlash = false;
  bool _isOn = false;
  double _intensity = 1.0;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    bool hasFlash = await Lamp.hasLamp;
    print("Device has flash ? $hasFlash");
    setState(() { _hasFlash = hasFlash; });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.pink),
      home: new Scaffold(
        appBar: new AppBar(title: new Text('Lamp plugin example')),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            new Text('Device has flash: $_hasFlash\n Flash is on: $_isOn'),
            new Slider(value: _intensity, onChanged: _isOn ? _intensityChanged : null),
            new RaisedButton(onPressed: () async => await Lamp.flash(new Duration(seconds: 2)), child:  new Text("Flash for 2 seconds"))
          ]),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(_isOn ? Icons.flash_off : Icons.flash_on),
          onPressed: _turnFlash),
      ),
    );
  }

  Future _turnFlash() async {
    _isOn ? Lamp.turnOff() : Lamp.turnOn(intensity: _intensity);
    var f = await Lamp.hasLamp;
    setState((){
      _hasFlash = f;
      _isOn = !_isOn;
    });
  }

  _intensityChanged(double intensity) {
    Lamp.turnOn(intensity : intensity);
    setState((){
      _intensity = intensity;
    });
  }

}
