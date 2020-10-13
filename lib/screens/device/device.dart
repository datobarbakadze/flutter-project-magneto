import 'dart:io';

import 'package:flutter/material.dart';
import 'package:deskmaster/widgets/app_bars.dart';
import 'package:deskmaster/screens/device/device_widgets.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:deskmaster/inject.dart';
import 'package:deskmaster/widgets/global_widgets.dart';
import 'package:flutter/services.dart';
// import 'package:wifi/wifi.dart';
// import 'package:flutter_android/android_net.dart' as net;

class DHCP {
  final String ip;
  final String gateway;
  final String netmask;
  final String broadcast;

  DHCP({
    this.ip = "0.0.0.0",
    this.gateway = "0.0.0.0",
    this.netmask = "0.0.0.0",
    this.broadcast = "0.0.0.0",
  });

  DHCP.fromMap(Map<String, String> map)
      : ip = map["ip"],
        gateway = map["gateway"],
        netmask = map["netmask"],
        broadcast = map["broadcast"];
}

class WifiAccess {
  static const MethodChannel _channel = const MethodChannel('wifi_access');

  static Future<DHCP> get dhcp async {
    final dart = await _channel.invokeMethod('getDHCP');
    // print(dart);
    return DHCP.fromMap(
        Map<String, String>.from(dart));
  }


}

// Future<List<Socket>> sockets() async {
//   List<Socket> sockConList = [];
//   for (int i=0; i<256; i++){
//
//     try {
//       Socket sockCon = await Socket.connect(InternetAddress("192.168.16."+i.toString()), 9999,timeout: Duration(microseconds: 500));
//       sockConList.add(sockCon);
//       print(i.toString());
//     } catch (e, s) {
//       continue;
//     }
//   }
//   print("sockets: "+sockConList.toString());
//   return sockConList;
// }

// Future<List<String>> handShake(List<Socket> socketsList) async {
//   List<String> IPS = [];
//   for (Socket sock in socketsList){
//     try {
//       sock.writeln("hello");
//       await sock.listen((event) => event).onData((data) {
//         String decodedData = utf8.decode(data).toString();
//         if(decodedData=="hello"){
//           IPS.add(sock.address.toString());
//         }
//       });
//       sock.close();
//       sock.destroy();
//     } catch (e, s) {
//       continue;
//     }
//   }
//   print(IPS);
//   return IPS;
// }
// socket.listen((event) {}).onData((data) {
// String resp = utf8.decode(data).toString();
// print("datobarbaqadze");
// print(resp);
// if(resp.toString()=="hello"){
// print("datobarbaqadze");
// inject.ip_list.add("192.168.16."+i.toString());
// }
// Future<List> discoverValidDevices(Inject inject) async {
//   List<Socket> socketsList = await sockets();
//   List<String> ips = await handShake(socketsList);
//
//   await print(ips);
//   return inject.ip_list;
// }



class Device extends StatefulWidget {
  @override
  _DeviceState createState() => _DeviceState();
}

class _DeviceState extends State<Device> {

  // void fi()async{
  //   DHCP dhcp = await WifiAccess.dhcp;
  // }
  @override
  Widget build(BuildContext context) {

    Inject inject = Provider.of<Inject>(context, listen:false);
    List<String> ips = ["192.168.16.100","192.168.16.101","192.168.16.102","192.168.16.103",
      "192.168.16.104","192.168.16.105","192.168.16.106","192.168.16.107","192.168.16.108",
      "192.168.16.109","192.168.16.1010","192.168.16.111","192.168.16.112","192.168.16.113",];
    // fi();
    // print(mainList[0].children);
    return Scaffold(
      appBar: AppBars.defaultAppBar("Discovered Devices"),
      body: ListView.builder(
            itemCount: ips.length,
            itemBuilder: (_,index){
              return Container(color:Colors.teal[800],child: ListTile(leading: Icon(Icons.network_check),title: IpCard(ip: ips[index])));
            },
          ),
    );
  }
}
