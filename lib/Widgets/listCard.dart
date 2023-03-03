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
  MqttServerClient? client = null;
  int delayMiliseconds = 100;


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
                    height: 450,
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
                              left: 50,
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
                              top: 100,
                                left: 50,
                                child: GlassSlider(mqttClient: widget.mqttClient, client: widget.mqttClient!.getClient)
                            ),

                            Positioned(
                                top: 0,
                                right: 50,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        setClient();}
                                      );
                                    },
                                    child: Text(widget.mqttClient!.client.connectionStatus!.state.toString().substring(20).toUpperCase(), style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),))
                            )
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
                                      thickness: 2,
                                    ),
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