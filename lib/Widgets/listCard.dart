import 'dart:ffi';
import 'dart:ui';
import 'package:forasan/main.dart';
import 'package:flutter/material.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/main.dart';
import 'package:forasan/Widgets/sliders.dart';

class GlassCard extends StatefulWidget {
  String glassname;
  int itemCount2;
  final MqttClient? mqttClient;


  GlassCard({required this.glassname, required this.itemCount2, this.mqttClient, Key? key}) : super(key: key);
  double _currentSliderValue = 0;
  String mqttTopic1 = 'CONTROL/BetterTint';
  int mqttMessage1 = 0;

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
                            child: GlassSlider(mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient, mqttTopic: widget.mqttTopic1, mqttMassage: '${_currentSliderValue.round()}',)
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












