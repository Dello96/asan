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
  final MqttServerClient? client;


  GlassCard({required this.glassname, required this.itemCount2, this.mqttClient, this.client, Key? key}) : super(key: key);

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  double _opacity = 0;
  bool coNNectingStatus = true;
  double vvalue = 0;
  List<bool> _selectedMode = <bool>[true, false];
  bool changeMode = false;
  MqttServerClient? client = null;
  int delayMiliseconds = 100;
  double _currentSliderValue = 0;


  @override

  Future<void> setClient() async{
    while(client == null) {
      client = await widget.mqttClient!.getMqttClient();
      await Future.delayed((Duration(milliseconds: delayMiliseconds)));
      delayMiliseconds = delayMiliseconds * 2;
      print('$client  $delayMiliseconds');
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                    width: 300,
                    height: 460,
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                        side: CardSide.FRONT,
                        speed: 1000,
                        onFlipDone: (status) {
                        print(status);
                        },
                        front: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              left: 30,
                              child: Container(
                                child: Text('Group',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Color(0xff0785F2)
                                  ),),
                              ),
                            ),
                            Positioned(
                              top: 50,
                                left: 28,
                                child: GlassSlider(mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient)
                            ),

                          ],
                        ),
                        back: Container(
                          width: 400,
                          height: 424,
                          child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    pieceCard(pieceName: 'Glass1', boardNumber: '1', mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient),
                                    Divider(
                                      thickness: 2,),
                                    pieceCard2(pieceName: 'Glass2', boardNumber: '2', mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient),
                                    Divider(
                                      thickness: 2,),
                                    pieceCard3(pieceName: 'Glass3', boardNumber: '3', mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient),
                                    Divider(
                                      thickness: 2,),
                                    pieceCard4(pieceName: 'Glass4', boardNumber: '4', mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient)
                                  ],
                                );
                              },
                              itemCount: 1)
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}