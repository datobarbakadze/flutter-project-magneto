import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deskmaster/inject.dart';
import 'package:deskmaster/widgets/global_widgets.dart';
import 'package:deskmaster/services/net_data.dart';


class GenerateCover extends StatelessWidget {
  GenerateCover(this.movieData);
  final Map movieData;
  final String noImagePng = "https://www.staticwhich.co.uk/static/images/products/no-image/no-image-available.png";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              movieData["covers"] == null || movieData["covers"]["data"]["1920"] == "" ? this.noImagePng : movieData["covers"]["data"]["1920"],
            ),
        ),
      ),
      child: Center(
        child: Text(movieData["secondaryName"],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40,color: Colors.white),
        )),
    );
  }
}

class GeneratePanel extends StatelessWidget {
  GeneratePanel(this.movieData);
  final Map movieData;
  @override
  Widget build(BuildContext context) {
    final List plots = movieData["plots"]["data"];
    String description = "There is no description";
    if(plots.length > 0){
      if(plots ==1 ){
        description = plots[0]['description'];
      }else{
        description = plots[1]["description"];
      }
    }

    return Container(
      color: Colors.black,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 5.0,
            shadowColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Center(child: Icon(Icons.drag_handle,size: 30.0,color: Colors.white,)),
            bottom: TabBar(
              tabs: [
                Tab(child: Icon(Icons.gamepad)),
                Tab(child: Icon(Icons.settings)),
                Tab(child: Icon(Icons.info_outline)),
              ],
            ),
          ),
          body: Container(
            color: Colors.black,
            child: TabBarView(children: [
              SingleChildScrollView(
                child: ControllerTab()
              ),
              SingleChildScrollView(
                child: SettingsTab(),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Description:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(
                        "${description }",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 1.0
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
            ),
          ),
        ),
      )
    );
  }
}

class ControllerTab extends StatelessWidget {

  // skip add
  // forward
  // backward
  // volume up
  // volume down
  // theater mode
  // fullscreen
  const ControllerTab({
    Key key,
  }) : super(key: key);
  final int default_flex = 2;
  @override
  Widget build(BuildContext context) {
    Inject inject = Provider.of<Inject>(context);
    double movieLengthSeconds = (inject.movieData["duration"]*60).toDouble();
    int division = inject.movieData["duration"]*60;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(child: ControllerIconButton(Icons.play_arrow,"Volume down",Colors.white,"big_play",radius: 40,background: Colors.teal[800],)),
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Container(child: Icon(Icons.volume_down,color: Colors.white,),),
              ),
              Expanded(
                flex:11,
                child: VolumeController(color: Colors.teal[800],),
              ) // volume
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Container(child: Icon(Icons.timelapse,color: Colors.white,),),
              ),
              Expanded(
                flex:11,
                child: TimeSlider(color: Colors.blue[900],max:movieLengthSeconds ,division: division,),
              ) // volume
            ],
          ),

          SizedBox(height: 20.0,),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: this.default_flex,
                child: ControllerIconButton(Icons.fast_rewind,"Rewind",Colors.black,"rewind"),
              ),
              Expanded(
                flex: this.default_flex,
                child: ControllerIconButton(Icons.play_arrow,"Play",Colors.black,"play"),
              ),
              Expanded(
                flex: this.default_flex,
                child: ControllerIconButton(Icons.fast_forward,"Fast forward",Colors.black,"fast_forward"),
              ),
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 5,
                  child: ControllerButton(icon: Icons.skip_next,label: "Skip ads",command: "skip_ads")
              ),
              Expanded(flex:2,child: SizedBox(height: 0.0)),
              Expanded(
                  flex: 5,
                  child: ControllerButton(icon: Icons.fullscreen,label: "Fullscreen",command: "fullscreen")
              ),

            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 5,
                  child: ControllerButton(icon: Icons.closed_caption,label: "Captions",command: "captions")
              ),
              Expanded(flex:2,child: SizedBox(height: 0.0)),
              Expanded(
                  flex: 5,
                  child: ControllerButton(icon: Icons.exit_to_app,label: "Escape age",command: "escape_age")
              ),

            ],
          ),
        ],
      ),
    );
  }
}


class ControllerButton extends StatefulWidget{
  ControllerButton({Key key,@required this.icon, @required this.label, @required this.command}) : super(key:key);
  final IconData icon;
  final String label;
  final String command;
  @override
  _ControllerButtonState createState() => _ControllerButtonState();
}

class _ControllerButtonState extends State<ControllerButton> {
  Inject inject;
  Widget icon = circularProgress();

  @override
  Widget build(BuildContext context) {
    this.inject = Provider.of<Inject>(context, listen:false);
    final movieState = Provider.of<MovieState>(context);
    if(movieState!=null){
      if(widget.command=="fullscreen" && movieState.fullscreen)
        this.icon = Icon(Icons.fullscreen_exit_outlined,size: 24);
      else
        this.icon = Icon(widget.icon,size: 24);
    }else if(movieState==null && widget.command == "fullscreen")
      this.icon = circularProgress();

    return FlatButton.icon(
      padding: EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      icon: this.icon,
      label: Text(widget.label),
      color: Colors.white,
      onPressed: (){
        this.inject.socket.writeln(widget.command);
      },
    );
  }
}


class ControllerIconButton extends StatelessWidget {
  const ControllerIconButton(this.icon, this.toolTip,this.color,this.command,
      { this.radius = 30.0, this.background = Colors.white, Key key,
  }) : super(key: key);

  final IconData icon;
  final String toolTip;
  final Color color;
  final String command;
  final double radius;
  final Color background;
  @override
  Widget build(BuildContext context) {
    Widget icon_cont = Icon(this.icon,size:24);
    final inject = Provider.of<Inject>(context, listen: false);
    final movieState = Provider.of<MovieState>(context);
    if(movieState!=null){
      if(this.command=="play" && movieState.playing)
        icon_cont = Icon(Icons.pause,size: 24);
      else
        icon_cont = Icon(this.icon,size: 24);
    }else if(movieState==null && this.command == "play")
      icon_cont = circularProgress();


    return  CircleAvatar(
          backgroundColor: background,
          radius: this.radius,
          child: IconButton(
            padding: EdgeInsets.all(0),
              onPressed: (){
                inject.socket.writeln(command);
              },
              icon: icon_cont,
              iconSize: 30,
              color: color,
              tooltip: this.toolTip,
          ),
      );
  }
}

class VolumeController extends StatefulWidget {
  const VolumeController({
    Key key,
    this.color,
    this.min=0.0,
    this.max=1.0,
    this.division=10,
  }) : super(key: key);

  final Color color;
  final double min;
  final double max;
  final int division;
  @override
  _VolumeControllerState createState() => _VolumeControllerState();
}

class _VolumeControllerState extends State<VolumeController> {
  double realVolume = 0;
  double label;
  @override
  Widget build(BuildContext context){
    final inject = Provider.of<Inject>(context, listen: false);
    final movieState = Provider.of<MovieState>(context);

    if (movieState != null){
      if(movieState.volume==realVolume){
        realVolume = movieState.volume;
      }
    }
    return Slider.adaptive(
        value: realVolume,
        divisions: widget.division,
        min: widget.min,
        max: widget.max,
        onChanged: (double newValue){
          setState(() {
            realVolume = newValue;
            this.label = realVolume*100;
          });

        },
        onChangeEnd: (double newVal){
          inject.socket.writeln("volume|$newVal");
        },
        label: "${this.label}",
        activeColor: widget.color,
        inactiveColor: Colors.grey[350],
    );
  }
}

class TimeSlider extends StatefulWidget {
  const TimeSlider({
    Key key,
    this.color,
    this.min=0.0,
    this.max=1.0,
    this.division=10,
    this.value = "0"
  }) : super(key: key);
  final String value;
  final Color color;
  final double min;
  final double max;
  final int division;
  @override
  _TimeSliderState createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  double label;
  double realTime = 0;
  @override
  Widget build(BuildContext context){
    final inject = Provider.of<Inject>(context,listen: false);
    final movieState = Provider.of<MovieState>(context);
    if (movieState != null){
      if(movieState.time==realTime){
        realTime = movieState.time;
      }
    }
    return Slider.adaptive(
      value: realTime =  realTime,
      divisions: widget.division,
      min: widget.min,
      max: widget.max,
      onChanged: (double newValue){

        setState(() {
          realTime = newValue;
          this.label = roundDouble(realTime/60,2);
        });
      },
      onChangeEnd: (double newVal){
        inject.socket.writeln("time|${newVal}");
      },
      label: "${this.label}",
      activeColor: widget.color,
      inactiveColor: Colors.grey[350],
    );
  }
}


class SettingsTab extends StatelessWidget {
  // final List<String> langs = ["HIGH","MEDIUM","LOW"];
  // final List<String> qual = ["HIGH","MEDIUM","LOW"];
  // final List<String> speed = ["2x","1.5x","NORMAL","0.75x","0.5x","0.25x"];
  // final List<String> subs = ["ENG","RUS","GEO"];
  final double height = 130;
  List langConvert(data){
    List returnVar = List();
    for (Map map in data["data"]){
      returnVar.add(map["code"].toString().toLowerCase());
    }
    return returnVar;
  }

  @override
  Widget build(BuildContext context) {
    final inject = Provider.of<Inject>(context);
    dynamic langs = this.langConvert(inject.movieData["languages"]);
    final List<String> qual = ["HIGH","MEDIUM"];
    final List<String> speed = ["2x","1.5x","NORMAL","0.75x","0.5x","0.25x"];
    final List<String> subs = ["ENG","RUS","GEO"];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex:8,
              child: Column(
                children: [
                  Center(child: Text("Languages",style: TextStyle(color: Colors.white),)),
                  Container(
                    height: this.height,
                    child: ListView.builder(
                        itemCount: langs.length,
                        itemBuilder: (_,index){
                          return GenerateRadioButton(title: langs[index].toUpperCase(), command: "lang",);
                        }),
                  ),
                ],
              ),
            ),
            Expanded(flex:1,child: SizedBox(width: 0.0,)),
            Expanded(
              flex:8,
              child: Column(
                children: [
                  Center(child: Text("Quality",style: TextStyle(color: Colors.white),)),
                  Container(
                    height: this.height,
                    child: ListView.builder(
                        itemCount: qual.length,
                        itemBuilder: (_,index){
                          return GenerateRadioButton(title: qual[index].toUpperCase(),command: "quality",);
                        }),
                  )
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 20.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex:8,
              child: Column(
                children: [
                  Center(child: Text("Speed",style: TextStyle(color: Colors.white),),),
                  Container(
                    height: this.height,
                    child: ListView.builder(
                        itemCount: speed.length,
                        itemBuilder: (_,index){
                          return GenerateRadioButton(title: speed[index].toUpperCase(), command: "speed",);
                        }),
                  )
                ],
              ),
            ),
            Expanded(flex:1,child: SizedBox(width: 0.0,)),
            Expanded(
              flex:8,
              child: Column(
                children: [
                  Center(child: Text("Subtites",style: TextStyle(color: Colors.white),)),
                  Container(
                    height: this.height,
                    child: ListView.builder(
                        itemCount: subs.length,
                        itemBuilder: (_,index){
                          return GenerateRadioButton(title: subs[index].toUpperCase(),command: "sub");
                        }),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class GenerateRadioButton extends StatefulWidget {
  const GenerateRadioButton({Key key, @required this.title, @required this.command}) : super(key:key);
  final String title;
  final String command;
  @override
  _GenerateRadioButtonState createState() => _GenerateRadioButtonState();
}

class _GenerateRadioButtonState extends State<GenerateRadioButton> {
  @override
  Widget build(BuildContext context) {
    final inject = Provider.of<Inject>(context);
    String movieId = inject.movieData["id"].toString();
    return Card(
      shadowColor: Colors.tealAccent,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      color: Colors.teal[800],
      child: FlatButton(
        onPressed: (){
          if(widget.command == "lang" ){
            inject.socket.writeln("url|${generateUrl(movieId,widget.title,inject.currentQuality)}");
            inject.currentLanguage = widget.title;
          }else if(widget.command == "quality"){
            inject.socket.writeln("url|${generateUrl(movieId,inject.currentLanguage,widget.title)}");
            inject.currentQuality = widget.title;
          }else{
            inject.socket.writeln("${widget.command}|${widget.title.toLowerCase()}");
          }

        },
        child: Text(
            "${widget.title}",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
        ),
      ),
    );
  }
}



