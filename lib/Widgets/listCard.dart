import 'dart:ffi';
import 'dart:math';
import 'dart:ui';
import 'package:forasan/main.dart';
import 'package:flutter/material.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/main.dart';
import 'package:forasan/Widgets/sliders.dart';
import 'package:forasan/Widgets/pieceCard.dart';
import 'package:flip_card/flip_card.dart';
import 'package:path_provider/path_provider.dart';



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
  List<bool> _selectedMode = <bool>[true, false];
  bool changeMode = false;

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

          Container(
            child: Stack(
              children: [
                Container(
                  child: FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                      side: CardSide.FRONT,
                      speed: 1000,
                      onFlipDone: (status) {
                      print(status);
                      },
                      front: Container(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(65, 0, 0, 0),
                                    alignment: Alignment.bottomLeft,
                                    width: MediaQuery.of(context).size.width,
                                    child: Text('Group',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.blueAccent
                                      ),),
                                  ),
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
                      back: Container(
                        width: 400,
                        height: 585,
                        child: ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  pieceCard(pieceName: 'Glass', boardNumber: '1', mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient),
                                  pieceCard(pieceName: 'Glass2', boardNumber: '2', mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient),
                                  pieceCard(pieceName: 'Glass3', boardNumber: '3', mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient),
                                  pieceCard(pieceName: 'Glass4', boardNumber: '4', mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient)
                                ],
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => Divider(),
                            itemCount: 1)
                      )),
                )
              ],
            ),
          ),

          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: 450,
                  child: Container()
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