import 'package:flutter/material.dart';
import 'package:deskmaster/inject.dart';
import 'package:provider/provider.dart';

class IpCard extends StatefulWidget {
  IpCard({@required this.ip});
  final String ip;
  @override
  _IpCardState createState() => _IpCardState();
}

class _IpCardState extends State<IpCard> {

  @override
  Widget build(BuildContext context) {
    Inject inject = Provider.of<Inject>(context, listen:false);
    return Container(
      height:70,
      child: GestureDetector(
        onTap: (){
          inject.connection_ip = widget.ip;
          return Navigator.of(context).pushNamed("/login");
        },
        child: Card(
          elevation: 5,
          color: Colors.teal[700],
          child: Center(
            child: Text(
                "IP: "+widget.ip,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
            ),
          ),

        ),
      ),
    );
  }
}
