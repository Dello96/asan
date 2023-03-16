import 'dart:ffi';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/main.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String mqttTopic1 = "CONTROL/59/1";
  String mqttTopic2 = "CONTROL/59/2";
  String mqttTopic3 = "CONTROL/59/3";
  String mqttTopic4 = "CONTROL/59/4";
  double _currentSliderValue = 0;
  final oneSec = Duration(seconds: 2);
  bool changeGlass = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 90,
              width: 100,
              child: Text(widget.pieceName, style: TextStyle(fontFamily: 'BebasNeue-Regular', fontSize: 20))
          ),
          Positioned(
              top: 20,
              left: 10,
              child: FloatingActionButton(
                  heroTag: "button",
                  backgroundColor: changeGlass ? Colors.grey : Colors.white,
                  child: Container(
                    child: Text(changeGlass ? "OFF" : "ON",
                        style: TextStyle(color: changeGlass ? Colors.black : Color(0xff0785F2), fontFamily: 'BebasNeue-Regular', fontSize: 20)),
                  ),
                  onPressed: () {
                    setState(() {
                      if(changeGlass == false) {
                        changeGlass = !changeGlass;
                        widget.mqttClient!.mqttPub(mqttTopic1, '{\"value\" : 0}', widget.client);
                        _currentSliderValue = 0.0;
                      } else {
                        changeGlass = !changeGlass;
                        widget.mqttClient!.mqttPub(mqttTopic1, '{\"value\" : 100}', widget.client);
                        _currentSliderValue = 100.0;
                      }
                    });
                  }
              )
          ),
          Positioned(
              width: 280,
              top: 40,
              left: 80,
              child: SliderTheme(
                data: SliderThemeData(
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20)
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
                        if(_currentSliderValue == 0.0) {
                          changeGlass == false;
                        } else {changeGlass == true;}
                        _currentSliderValue = value;
                        widget.mqttClient!.mqttPub(mqttTopic1,'{\"value\" : ${_currentSliderValue.round().toString()}}', widget.client);
                        print(_currentSliderValue.round().toString());
                      });
                    }),
              ),
          ),
          Positioned(
              width: 120,
              top: 0,
              left: 250,
              child: Container(
                alignment: Alignment.center,
                child: Text('${_currentSliderValue.round().toString()} %',
                  style: TextStyle(
                      fontSize: 30,
                      color: changeGlass ? Colors.black : Color(0xff0785F2)
                  ),),
              ))
        ],
      ),
    );
  }
}



class pieceCard2 extends StatefulWidget {
  String pieceName;
  String boardNumber;
  MqttClient? mqttClient;
  MqttServerClient? client;
  pieceCard2({required this.pieceName, required this.boardNumber, required this.mqttClient, required this.client, Key? key}) : super(key: key);

  @override
  State<pieceCard2> createState() => _pieceCard2State();
}

class _pieceCard2State extends State<pieceCard2> {


  String mqttTopic = "CONTROL/BetterTint";
  String mqttTopic1 = "CONTROL/59/1";
  String mqttTopic2 = "CONTROL/59/2";
  String mqttTopic3 = "CONTROL/59/3";
  String mqttTopic4 = "CONTROL/59/4";
  double _currentSliderValue = 0;
  final oneSec = Duration(seconds: 2);
  bool changeGlass = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 90,
              width: 100,
              child: Text(widget.pieceName, style: TextStyle(fontSize: 20, fontFamily: 'BebasNeue-Regular'),)
          ),
          Positioned(
              top: 20,
              left: 10,
              child: FloatingActionButton(
                  backgroundColor: changeGlass ? Colors.grey : Colors.white,
                  child: Container(
                    child: Text(changeGlass ? "OFF" : "ON",
                        style: TextStyle(color: changeGlass ? Colors.black : Color(0xff0785F2),fontFamily: 'BebasNeue-Regular', fontSize: 20)),
                  ),
                  onPressed: () {
                    setState(() {
                      if(changeGlass == false) {
                        changeGlass = !changeGlass;
                        widget.mqttClient!.mqttPub(mqttTopic2, '{\"value\" : 0}', widget.client);
                        _currentSliderValue = 0.0;
                      } else {
                        changeGlass = !changeGlass;
                        widget.mqttClient!.mqttPub(mqttTopic2, '{\"value\" : 100}', widget.client);
                        _currentSliderValue = 100.0;
                      }
                    });
                  }
              )
          ),
          Positioned(
            width: 280,
            top: 40,
            left: 80,
            child: Container(
              child: SliderTheme(
                data: SliderThemeData(
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20)
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
                        widget.mqttClient!.mqttPub(mqttTopic2,'{\"value\" : ${_currentSliderValue.round().toString()}}', widget.client);
                        print(_currentSliderValue.round().toString());
                      });
                    }),
              ),
            ),
          ),
          Positioned(
              width: 120,
              top: 0,
              left: 250,
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


class pieceCard3 extends StatefulWidget {
  String pieceName;
  String boardNumber;
  MqttClient? mqttClient;
  MqttServerClient? client;
  pieceCard3({required this.pieceName, required this.boardNumber, required this.mqttClient, required this.client, Key? key}) : super(key: key);

  @override
  State<pieceCard3> createState() => _pieceCard3State();
}

class _pieceCard3State extends State<pieceCard3> {


  String mqttTopic = "CONTROL/BetterTint";
  String mqttTopic1 = "CONTROL/59/1";
  String mqttTopic2 = "CONTROL/59/2";
  String mqttTopic3 = "CONTROL/59/3";
  String mqttTopic4 = "CONTROL/59/4";
  double _currentSliderValue = 0;
  final oneSec = Duration(seconds: 2);
  bool changeGlass = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 90,
              width: 100,
              child: Text(widget.pieceName, style: TextStyle(fontSize: 20, fontFamily: 'BebasNeue-Regular'),)
          ),
          Positioned(
              top: 20,
              left: 10,
              child: FloatingActionButton(
                  backgroundColor: changeGlass ? Colors.grey : Colors.white,
                  child: Container(
                    child: Text(changeGlass ? "OFF" : "ON",
                        style: TextStyle(color: changeGlass ? Colors.black : Color(0xff0785F2), fontFamily: 'BebasNeue-Regular', fontSize: 20)),
                  ),
                  onPressed: () {
                    setState(() {
                      if(changeGlass == false) {
                        changeGlass = !changeGlass;
                        widget.mqttClient!.mqttPub(mqttTopic3, '{\"value\" : 0}', widget.client);
                        _currentSliderValue = 0.0;
                      } else {
                        changeGlass = !changeGlass;
                        widget.mqttClient!.mqttPub(mqttTopic3, '{\"value\" : 100}', widget.client);
                        _currentSliderValue = 100.0;
                      }
                    });
                  }
              )
          ),
          Positioned(
            width: 280,
            top: 40,
            left: 80,
            child: Container(
              child: SliderTheme(
                data: SliderThemeData(
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20)
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
                        widget.mqttClient!.mqttPub(mqttTopic3,'{\"value\" : ${_currentSliderValue.round().toString()}}', widget.client);
                        print(_currentSliderValue.round().toString());
                      });
                    }),
              ),
            ),
          ),
          Positioned(
              width: 120,
              top: 0,
              left: 250,
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



class pieceCard4 extends StatefulWidget {
  String pieceName;
  String boardNumber;
  MqttClient? mqttClient;
  MqttServerClient? client;
  pieceCard4({required this.pieceName, required this.boardNumber, required this.mqttClient, required this.client, Key? key}) : super(key: key);

  @override
  State<pieceCard4> createState() => _pieceCard4State();
}

class _pieceCard4State extends State<pieceCard4> {


  String mqttTopic = "CONTROL/BetterTint";
  String mqttTopic1 = "CONTROL/59/1";
  String mqttTopic2 = "CONTROL/59/2";
  String mqttTopic3 = "CONTROL/59/3";
  String mqttTopic4 = "CONTROL/59/4";
  double _currentSliderValue = 0;
  final oneSec = Duration(seconds: 2);
  bool changeGlass = true;
  String _on = "ON";
  String _off = "OFF";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 90,
              width: 100,
              child: Text(widget.pieceName, style: TextStyle(fontSize: 20, fontFamily: 'BebasNeue-Regular'),)
          ),
          Positioned(
            top: 20,
              left: 10,
              child: FloatingActionButton(
                backgroundColor: changeGlass ? Colors.grey : Colors.white,
                child: Container(
                  child: Text(changeGlass ? "OFF" : "ON",
                    style: TextStyle(color: changeGlass ? Colors.black : Color(0xff0785F2), fontFamily: 'BebasNeue-Regular', fontSize: 20)),
                ),
                  onPressed: () {
                    setState(() {
                      if(changeGlass == false) {
                        changeGlass = !changeGlass;
                        widget.mqttClient!.mqttPub(mqttTopic4, '{\"value\" : 0}', widget.client);
                        _currentSliderValue = 0.0;
                      } else {
                        changeGlass = !changeGlass;
                        widget.mqttClient!.mqttPub(mqttTopic4, '{\"value\" : 100}', widget.client);
                        _currentSliderValue = 100.0;
                      }
                    });
                  }
                  )
          ),
          Positioned(
            width: 280,
            top: 40,
            left: 80,
            child: Container(
              child: SliderTheme(
                data: SliderThemeData(
                    thumbColor: Colors.white,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20)
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
                        widget.mqttClient!.mqttPub(mqttTopic4,'{\"value\" : ${_currentSliderValue.round().toString()}}', widget.client);

                        print(_currentSliderValue.round().toString());
                      });
                    }),
              ),
            ),
          ),
          Positioned(
              width: 120,
              top: 0,
              left: 250,
              child: Container(
                alignment: Alignment.center,
                child: Text('${_currentSliderValue.round().toString()} %',
                  style: TextStyle(
                      fontSize: 30
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}