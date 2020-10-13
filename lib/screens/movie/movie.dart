import 'package:deskmaster/inject.dart';
import 'package:flutter/material.dart';
import 'package:deskmaster/screens/movie/movie_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:deskmaster/widgets/app_bars.dart';
import 'package:provider/provider.dart';
import 'package:deskmaster/widgets/global_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MoviePage extends StatefulWidget {
  MoviePage({this.movieId});
  final int movieId;
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  Inject inject;
  Future<Map> grabMovieData() async {
    http.Response response = await http.get("https://api.imovies.cc/api/v1/movies/${widget.movieId}?filters%5Bwith_directors%5D=10");
    var data = json.decode(response.body)["data"];
    // print(data.runtimeType);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    this.inject = Provider.of<Inject>(context, listen: false);
    this.inject.socket.writeln("url|${generateUrl(widget.movieId.toString(),"ENG","HIGH")}");

    return Scaffold(
      appBar: AppBars.defaultAppBar("Movie"),
      body: Container(
        child: FutureBuilder(
          future:  this.grabMovieData(),
          builder: (context, snapshot){
            if(snapshot.hasError)
              return Center(child: Text("Error 404"));
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(),);
            this.inject.movieData = snapshot.data;
            return  SlidingUpPanel(
                panel: GeneratePanel(snapshot.data),
                body: GenerateCover(snapshot.data)
            );
          },
        ),
      ),
    );
  }
}