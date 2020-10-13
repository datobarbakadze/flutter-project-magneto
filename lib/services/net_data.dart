import "dart:async";
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:deskmaster/inject.dart';
class MovieState{
  MovieState({this.volume=1,
    this.time=1,
    this.muted="true",
    this.fullscreen=false,
    this.playing=false
  });

  double time;
  double volume;
  String muted;
  bool fullscreen;
  bool playing;

  MovieState.fromJson(Map json) :
        time = double.parse(json["time"].toString()),
        muted = json["muted"].toString(),
        volume = double.parse(json["volume"].toString()),
        fullscreen = json["fullscreen"].toString() == "true" ? true : false,
        playing = json["paused"].toString() == "false" ? true : false;
}

class UpdateState{
  static Stream<MovieState> getData(BuildContext context){
    final inject = Provider.of<Inject>(context, listen: false);
    // inject.socket.listen((event) {
    //   event.
    //   print(event);
    //   return MovieState(volume: "1",time: "1");
    // }).onData((data){
    //   print(data);
    //   // print("data - "+utf8.decode(data).toString());
    //   // String jsonString =
    //   // Map js = json.decode(jsonString.substring(4));
    //   // MovieState v = MovieState.fromJson(js);
    //   // return js;
    //   return MovieState(volume: "1",time: "1");
    // });


    return inject.socket.map((event) {
      utf8.decode(event).toString();
      return utf8.decode(event).toString();
    }).map((data) {
      // print(data);
         if (data.substring(0,4) == "json"){
           Map js = json.decode(data.substring(4));
           MovieState d = MovieState.fromJson(js);
           return d;
         }
    });



    //     .map((event) {
    //   print("hello - "+event);
    //   if (event.substring(0,4) == "json"){
    //     Map js = json.decode(event.substring(4));
    //     return js;
    //   }else
    //     return Map();
    // }).map((js) {
    //   MovieState v = MovieState.fromJson(js);
    //   print(v.volume);
    //   print(v.time);
    //   return v;
    // });
  }
}