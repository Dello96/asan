import 'dart:ffi';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/main.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(90, 0, 0, 0),
                          alignment: Alignment.center,
                          width: 120,
                          child: Text('${_currentSliderValue.round().toString()} %',
                            style: TextStyle(
                                fontSize: 40
                            ),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                          width: 300,
                          child: SliderTheme(
                            data: SliderThemeData(
                                thumbColor: Colors.white,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 25)
                            ),
                            child: Slider(
                                value: _currentSliderValue,
                                max: 100,
                                min: 0,
                                divisions: 100,
                                inactiveColor: Colors.black,
                                thumbColor: Colors.white,
                                activeColor: Colors.blueAccent,
                                onChanged: (double value){
                                  setState(() {
                                    _currentSliderValue = value;
                                    widget.mqttClient!.mqttPub(mqttTopic,'{\"value\" : ${_currentSliderValue.round().toString()}}', widget.client);
                                    print(_currentSliderValue.round().toString());
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.mqttClient!.mqttPub(mqttTopic, '{\"value\" : 0}', widget.client);
                                  _currentSliderValue = 0.0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/images/rectangle2.png'))
                                ),
                              )
                          )
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          height: 50,
                          child: VerticalDivider(
                            width: 20,
                            thickness: 1,
                            endIndent: 0,
                            indent: 0,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.mqttClient!.mqttPub(mqttTopic, '{\"value\" : 100}', widget.client);
                                  _currentSliderValue = 100.0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/images/rectangle1.png'))
                                ),
                              )
                        )
                        )],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}