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



  String percentageModifier(double value) {
    final roundedValue = value.ceil().toInt().toString();
    return '$roundedValue';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child:
          Container(
            width: 250,
            height: 300,
            //slider size change
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                animationEnabled: false,
                size: 120,
                customWidths: CustomSliderWidths(
                  progressBarWidth: 28,
                  trackWidth: 20,
                  handlerSize: 20,
                ),
                infoProperties: InfoProperties(
                  modifier: percentageModifier,
                    mainLabelStyle: TextStyle(
                        fontSize: 30
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
                  widget.mqttClient!.mqttPub(mqttTopic,'{\"value\" : ${percentageModifier(value)}}', widget.client);
                  if(changeGlass = true) {
                    percentageModifier(value) == 0.0;
                  } else {percentageModifier(value) == 100.0;}
                  print(percentageModifier(value));
                });
              },
            ),
          ),
        ),
        Positioned(
          top: 180,
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
                      print(widget.client!.connectionStatus!.state);
                      changeGlass = !changeGlass;
                      widget.mqttClient!.mqttPub(mqttTopic, '{\"value\" : 0}', widget.client);
                      percentageModifier(0);
                    } else {
                      changeGlass = !changeGlass;
                      widget.mqttClient!.mqttPub(mqttTopic, '{\"value\" : 100}', widget.client);
                      percentageModifier(100);
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

