import 'package:deskmaster/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
@override
class Routing extends Screens{
  Route<dynamic> onRouteGen(RouteSettings settings){
    var routeName = settings.name;
    if(!super.screens.containsKey(routeName))
      return this.errorRoute();

    Function _widget = super.screens[routeName]["widget"];
    return MaterialPageRoute(settings: settings,builder: (_){
      return settings.arguments != null ? _widget(settings.arguments) : _widget();
    });
  }
  Route<dynamic> errorRoute(){

    return MaterialPageRoute(builder: (_){
      return Scaffold(
      appBar: AppBar(title: Text("Error")),
      body:Center(
        child: Text("404 Error"),
      ),
      );
    });
  }
}




