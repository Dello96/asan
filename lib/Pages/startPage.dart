import 'package:flutter/material.dart';
import 'package:forasan/Widgets/listCard.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/MQTTClient.dart';

class StartPage extends StatefulWidget {
  MqttClient? mqttClient;
  final MqttServerClient? client;
  StartPage({required this.mqttClient, this.client, Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  MqttServerClient? client = null;
  int delayMiliseconds = 100;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: GlassCard(glassname: 'Group', itemCount2: 1, mqttClient: widget.mqttClient),
      ),
    );
  }
}
