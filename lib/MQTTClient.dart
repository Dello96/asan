// ignore_for_file: avoid_print
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClient{
  final topic = 'CONTROL/BetterTint';
  final message = '{"value": 0}';
  late final MqttServerClient client;
  MqttClient(String ip) {
    client = MqttServerClient(ip, '1883');
  }
  // mqtt connect
  Future<MqttServerClient> getMqttClient() async{

    try{
      client.setProtocolV311();
      client.port = 1883;
      client.keepAlivePeriod = 60;
      client.autoReconnect = true;

      final connMess = MqttConnectMessage()
          .withWillTopic('willtopic') // If you set this you must set a will message
          .withWillMessage('My Will message')
          .startClean() // Non persistent session for testing
          .withWillQos(MqttQos.atLeastOnce);
      print('EXAMPLE::Mosquitto client connecting....');
      client.connectionMessage = connMess;

      await client.connect();
    } on NoConnectionException catch(e){
      print('client exception - $e');
      client.disconnect();
    } on SocketException catch(e){
      print('client exception - $e');
      client.disconnect();
    }

    /// Check we are connected
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      print(
          'Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      // exit(-1);
    }
    return client;
  }



  // get connected client
  MqttServerClient get getClient => client;

  // mqtt publish function
  void mqttPub(String pubTopic, String message, MqttServerClient? connectedClient){
    print(pubTopic+ '  '+message);
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    try{
      connectedClient!.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
      print('topic : $pubTopic , message : $message');
    }catch(e){
      print('mqtt pub error');
      print(e);
    }
  }

}