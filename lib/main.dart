import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forasan/Pages/loginPage.dart';
import 'package:forasan/Pages/startPage.dart';
import 'package:forasan/MQTTClient.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: LoginPage(storage: IpStorage(),)),
    );
  }
}

class IpStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> readIP() async {
    try {
      final file = await _localFile;

      // 파일 읽기
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // 에러가 발생할 경우 error을 반환
      return 'error';
    }
  }

  Future<File> writeIP(String Ip) async {
    final file = await _localFile;

    // 파일 쓰기
    return file.writeAsString(Ip);
  }
}
class LoginPage extends StatefulWidget {
  final IpStorage storage;
  LoginPage({required this.storage, Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  late MqttClient mqttClient;

  MqttServerClient? client = null;

  int delayMiliseconds = 100;

  @override
  void initState() {
    super.initState();
    widget.storage.readIP().then((String _iip) {
      setState(() {
        ipController.text = _iip;
      });
    });

    ipController = TextEditingController();
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });

    // 파일에 String 타입으로 변수 값 쓰기
    return widget.storage.writeIP(ipController.text);
  }

  Future<void> setClient() async{
    while(client == null) {
      client = await mqttClient.getMqttClient();
      await Future.delayed((Duration(milliseconds: delayMiliseconds)));
      delayMiliseconds = delayMiliseconds * 2;
      print('$client  $delayMiliseconds');

    }
  }



  TextEditingController ipController = TextEditingController();

  @override
  void dispose() {
    ipController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: TextField(
                  controller: ipController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Raspberry wifiIP'
                  ),
                  onSubmitted: (String iip) async {
                    widget.storage.writeIP(iip);
                    mqttClient = MqttClient(ipController.text);
                    await setClient();
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => StartPage(mqttClient: mqttClient)));
                  },
                ),
              ),
            ],
          )),
    );
  }
}

