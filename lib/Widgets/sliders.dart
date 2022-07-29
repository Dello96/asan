import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/main.dart';

class GlassSlider extends StatefulWidget {
  MqttClient? mqttClient;
  MqttServerClient? client;
  String mqttTopic;
  String mqttMassage;
  GlassSlider({required this.mqttClient, required this.client, required this.mqttTopic,required this.mqttMassage, Key? key}) : super(key: key);

  @override
  State<GlassSlider> createState() => _GlassSliderState();
}

class _GlassSliderState extends State<GlassSlider> {
  String _values = '';
  MqttClient mqttClient = MqttClient();
  MqttServerClient client = MqttServerClient('192.168.0.220', '');
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 200,
      child: Slider(
          value: _currentSliderValue,
          max: 100,
          min: 0,
          divisions: 100,
          label: _currentSliderValue.round().toString(),
          thumbColor: Colors.white,
          inactiveColor: Colors.black,
          activeColor: Colors.lightBlueAccent,
          onChanged: (double value){
            setState(() {
              _currentSliderValue = value;
              widget.mqttClient!.mqttPub(widget.mqttTopic, '{\"value\": \'${widget.mqttClient}\'}', widget.client);
              print(_currentSliderValue.round().toString());
            });
          }),
    );
  }
}

