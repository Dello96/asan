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

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  double _opacity = 0;
  bool connectingstate = true;
  double vvalue = 0;


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: DecorationImage(
                  scale: 10,
                    image: AssetImage('assets/images/Glatic_logo.png'))
              )
            ),

          Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: 450,
                  child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(65, 0, 0, 0),
                              alignment: Alignment.bottomLeft,
                              width: MediaQuery.of(context).size.width,
                              child: Text(widget.glassname,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.blueAccent
                                ),),
                            ),
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                                child: GlassSlider(mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient)
                            ),
                          ],
                        )
                    ],
                  ),
            ),
                ],
              ),
          Expanded(child: Container(
          ))
        ],
      ),
    );
  }

}














