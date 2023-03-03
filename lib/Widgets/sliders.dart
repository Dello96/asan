import 'dart:ffi';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class GlassSlider extends StatefulWidget {
  MqttClient? mqttClient;
  MqttServerClient? client;
  GlassSlider({required this.mqttClient, required this.client, Key? key}) : super(key: key);

  @override
  State<GlassSlider> createState() => _GlassSliderState();
}

class _GlassSliderState extends State<GlassSlider> {
  String mqttTopic = "CONTROL/BetterTint";
  double _currentSliderValue = 0;
  final oneSec = Duration(seconds: 2);
  bool changeGlass = true;

  @override
  void initState() {
    super.initState();
  }

  String percentage(double value) {
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 60,
          top: 80,
          child: Container(
            alignment: Alignment.center,
            width: 150,
            child: Text('${_currentSliderValue.round().toString()} ',
              style: TextStyle(
                  fontSize: 40
              ),),
          ),
        ),
        Positioned(
          right: 75,
            top: 80,
            child: Container(
              child: Text('%',
              style: TextStyle(
                fontSize: 40
              ),),
            )),
        Positioned(
          child:
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
              animationEnabled: false,
              size: 250,
              customWidths: CustomSliderWidths(
                progressBarWidth: 18,
                trackWidth: 30,
              ),
              infoProperties: InfoProperties(
                  modifier: percentage,
                  mainLabelStyle: TextStyle(
                      fontSize: 20
                  )
              ),
              customColors: CustomSliderColors(
                  trackColor: Colors.white.withOpacity(0.7),
                  dotColor: Colors.white,
                  progressBarColors: [
                    Color(0xff0785F2),
                    Color(0xff3799EE),
                    Color(0xff4FA3EC),
                    Colors.cyan[50]!,
                  ],
                  shadowColor: Colors.white.withOpacity(0.5)
              ),
              startAngle: 190,
              angleRange: 160,
            ),
            min: 0,
            max: 100,
            onChange: (double value) {
              setState(() {
                _currentSliderValue = value;
                widget.mqttClient!.mqttPub(mqttTopic,'{\"value\" : ${_currentSliderValue.round().toString()}}', widget.client);
                print(_currentSliderValue.round().toString());
              });
            },
          ),
        ),
        Positioned(
          top: 150,
          left: 75,
          child: Container(
            width: 100,
            height: 100,
            child: FloatingActionButton(
                heroTag: 'mainbutton',
                backgroundColor: changeGlass ? Colors.grey : Colors.white,
                child: Container(
                  child: Text(changeGlass ? "OFF" : "ON",
                      style: TextStyle(color: changeGlass ? Colors.black : Color(0xff0785F2), fontSize: 20)),
                ),
                onPressed: () {
                  setState(() {
                    if(changeGlass == false) {
                      changeGlass = !changeGlass;
                      widget.mqttClient!.mqttPub(mqttTopic, '{\"value\" : 0}', widget.client);
                      _currentSliderValue = 0.0;
                    } else {
                      changeGlass = !changeGlass;
                      widget.mqttClient!.mqttPub(mqttTopic, '{\"value\" : 100}', widget.client);
                      _currentSliderValue = 100.0;
                    }
                  });
                }
            ),
          )
        ),

      ],
    );
  }
}

