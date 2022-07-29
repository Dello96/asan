import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forasan/Pages/startPage.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  MqttClient mqttClient = MqttClient();
  MqttServerClient? client = null;
  int delayMiliseconds = 100;


  void setClient() async{
    while(client == null) {
      client = await mqttClient.getMqttClient();
      await Future.delayed((Duration(milliseconds: delayMiliseconds)));
      delayMiliseconds = delayMiliseconds * 2;
      print('$client  $delayMiliseconds');

    }
  }
  @override
  Widget build(BuildContext context) {
    setClient();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: LoadingPage(
        mqttClient: mqttClient
      )),
    );
  }
}

class LoadingPage extends StatelessWidget {
  final MqttClient? mqttClient;
  LoadingPage({Key? key, @required this.mqttClient}) : super(key: key);

  int delayMiliseconds = 100;

  void moveToControlPage(BuildContext context) async {
    while(mqttClient?.getClient == null){
      if(mqttClient?.getClient != null) {
        print(mqttClient!.getClient);
        break;
      }
      await Future.delayed(Duration(milliseconds: delayMiliseconds));
      delayMiliseconds = delayMiliseconds*2;
    }
    Timer(const Duration(seconds: 2), (){
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: ((builder) => StartPage(
                  mqttClient: mqttClient
              )))
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    moveToControlPage(context);

    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Center(
          child: Container(
            color: Colors.white,
              height: height*0.5,
              child: Image.asset('assets/images/asanlogo3.jpeg', scale: 4,)
          ),
        ),
      ),
    );
  }
}