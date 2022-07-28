import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/main.dart';


class GlassCard extends StatefulWidget {
  String glassname;
  int itemCount2;
  final MqttClient? mqttClient;


  GlassCard({required this.glassname, required this.itemCount2, this.mqttClient, Key? key}) : super(key: key);

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {

  double _currentSliderValue = 100;
  String _values = '';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: widget.itemCount2,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Glatic',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey
                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 100,
                              color: Colors.greenAccent,
                              child: Text('Image'),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text('data'),
                          ),
                          Container(
                            child: GlassSlider()
                          ),
                          Container(
                            child: Text(_values
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      });
  }
}










class GlassSlider extends StatefulWidget {
  const GlassSlider({Key? key}) : super(key: key);

  @override
  State<GlassSlider> createState() => _GlassSliderState();
}

class _GlassSliderState extends State<GlassSlider> {
  String _values = '';
  MqttClient mqttclient = MqttClient();
  MqttServerClient mqttServerClient = MqttServerClient('192.168.0.220', '');
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
              _values = '${_currentSliderValue.round().toString()}%';
              print(_currentSliderValue.round().toString());
              mqttclient.topic;
              mqttclient.message;
              mqttclient.client;
            });
          }),
    );
  }
}

