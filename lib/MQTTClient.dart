// ignore_for_file: avoid_print
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClient{
  final topic = String;
  final message = String;
  final client = MqttServerClient('211.40.224.13', '');

  // mqtt connect
  Future<MqttServerClient> getMqttClient() async{
    try{
      client.setProtocolV311();
      client.keepAlivePeriod = 60;
      client.autoReconnect = true;

      final connMess = MqttConnectMessage()
          .withWillTopic(topic.toString()) // If you set this you must set a will message
          .withWillMessage(message.toString())
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