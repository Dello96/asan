import 'package:flutter/material.dart';
import 'package:forasan/Widgets/listCard.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:forasan/MQTTClient.dart';

class StartPage extends StatefulWidget {
  MqttClient? mqttClient;
  StartPage({required this.mqttClient, Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GlassCard(glassname: 'Room1', itemCount2: 1, mqttClient: widget.mqttClient),
      ),
    );
  }
}

// 넘겨줘야 하는 자료들이니 애초에 정해진 자료여야 하는게 아닌가??