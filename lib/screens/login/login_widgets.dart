
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deskmaster/inject.dart';
import 'dart:convert';
import 'dart:io';
class GenerateTextField extends StatelessWidget {
  final String label = "Password";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: this.label,
          hintStyle: TextStyle(color:Colors.white,fontSize: 20.0),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width:0.5,
              )
          ),
        ),
      ),
    );
  }
}


class GenerateAuthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inject = Provider.of<Inject>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 15),
        onPressed: () async {
          await Socket.connect(
            InternetAddress(inject.connection_ip,type: InternetAddressType.IPv4),
            9999,
            timeout: Duration(seconds: 5)
          ).then((sock) {
            print("Connected");
            inject.socket = sock;
            Navigator.of(context).pushNamed("/");
          }).
          catchError((err) => print(err));
        },
        color: Colors.black,
        child: Text("Authenticate",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

