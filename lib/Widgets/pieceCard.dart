import 'dart:ffi';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/main.dart';

class pieceCard extends StatefulWidget {
  String pieceName;
  String boardNumber;
  MqttClient? mqttClient;
  MqttServerClient? client;
  pieceCard({required this.pieceName, required this.boardNumber, required this.mqttClient, required this.client, Key? key}) : super(key: key);

  @override
  State<pieceCard> createState() => _pieceCardState();
}

class _pieceCardState extends State<pieceCard> {


  String mqttTopic = "CONTROL/BetterTint";
  double _currentSliderValue = 0;
  final oneSec = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 80,
              left: 100,
              child: Container(
                child: Text(widget.pieceName),
              )
          ),
          Positioned(
              top: 0,
              bottom: 50,
              child: Container(
                width: 60,
                height: 60,
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
              )
          ),
          Positioned(
            width: 50,
            top: 50,
            bottom: 50,
            left: 5,
            child: Divider(
              thickness: 1,
              color: Colors.blueGrey,
              indent: 10,
              endIndent: 10,
            ),
          ),
          Positioned(
              top: 50,
              bottom: 0,
              child: Container(
                  width: 60,
                  height: 60,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          widget.mqttClient!.mqttPub(mqttTopic, '{\"value\" : 0}', widget.client);
                          _currentSliderValue = 100.0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/rectangle1.png'))
                        ),
                      )
                  )
              )
          ),
          Positioned(
              width: 300,
              top: 40,
              left: 80,
              child: Container(
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
          ),
          Positioned(
              width: 120,
              top: 0,
              left: 270,
              child: Container(
                alignment: Alignment.center,
                child: Text('${_currentSliderValue.round().toString()} %',
                  style: TextStyle(
                      fontSize: 30
                  ),),
              ))
        ],
      ),
    );
  }
}
