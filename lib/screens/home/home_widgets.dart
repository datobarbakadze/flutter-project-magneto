import 'package:deskmaster/inject.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:deskmaster/widgets/global_widgets.dart';

class CheckBoxGenerator extends StatefulWidget {
  final Map value;
  final String type;
  CheckBoxGenerator({key:Key,@required this.value, @required this.type});
  @override
  _CheckBoxGeneratorState createState() => _CheckBoxGeneratorState();
}
class _CheckBoxGeneratorState extends State<CheckBoxGenerator> {
  bool _checked = false;
  final Color _activeTextColor = Colors.white;
  final Color _activeBgColor = Colors.black;
  final Color _disabledTextColor = Colors.white;
  final Color _disabledBgColor = Colors.teal[800];
  final Color _checkBoxActiveColor = Colors.teal[800];
  final Color _checkBoxCheckColor = Colors.white;
  Color _initialBgColor;
  Color _initialTextColor;

  @override
  void initState() {
    this._initialBgColor = this._disabledBgColor;
    this._initialTextColor = this._disabledTextColor;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Inject>(context, listen: false);
    String title = widget.value["secondaryName"] ?? widget.value["name"];

    return Card(
      color: this._initialBgColor,
      shadowColor: Colors.tealAccent,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width:50,
        child: CheckboxListTile(
          activeColor: this._checkBoxActiveColor,
          checkColor: this._checkBoxCheckColor,
          value: _checked,
          title: Text(
            "$title",
            style: TextStyle(
              color: this._initialTextColor,
              letterSpacing: 2.0,
              fontSize: 14.0,
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool value) {
            setState((){
              _checked = value;
              if(value==true){
                this._initialBgColor = this._activeBgColor;
                this._initialTextColor = this._activeTextColor;
              }else{
                this._initialBgColor = this._disabledBgColor;
                this._initialTextColor = this._disabledTextColor;
              }
              provider.updateList(value: widget.value["id"], action: value, type: widget.type);
            });
          },
          selected: true,
        ),
      ),
    );
  }
}


class RadioButtonGenerator extends StatelessWidget {
  RadioButtonGenerator({this.value});

  final Color _initialTextColor = Colors.white;
  final Color _initialBgColor = Colors.teal[800];
  final Color _radioButtonActiveColor = Colors.white;
  final Map<String, dynamic> value;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Inject>(context);
    return Card(
      color: this._initialBgColor,
      shadowColor: Colors.tealAccent,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width:50,
        child: RadioListTile(
          activeColor: this._radioButtonActiveColor,
          value: this.value["code"],
          groupValue: provider.urlBuilder.groupValue,
          title: Text(
            "${this.value['secondaryName']}",
            style: TextStyle(
              color: this._initialTextColor,
              letterSpacing: 2.0,
              fontSize: 14.0,
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (value) {
            provider.updateGroupValue(value);
          },
        ),
      ),
    );
  }


}


class YearTextField extends StatelessWidget {
  YearTextField({this.label,this.type}) : super();
  final String label;
  final String type;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Inject>(context, listen: false);
    return Container(
      width:90.0,
      height: 50.0,
      child: TextField(
        maxLength: 4,
        style: TextStyle(
          color: Colors.black,

        ),
        cursorColor: Colors.red,
        decoration: InputDecoration(
          hintText: this.label,
          hintStyle: TextStyle(color:Colors.black,fontSize: 12.0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal[800],
              width:3.0,
            )
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (String value){
          if(value==""){
            value=null;
          }
          provider.updateYear(value: value, type: type);
          print("${provider.urlBuilder.tillYear} | ${provider.urlBuilder.fromYear}");
        },
      ),
    );
  }
}


class ShowIMDBSlider extends StatefulWidget {
  @override
  _ShowIMDBSliderState createState() => _ShowIMDBSliderState();
}
class _ShowIMDBSliderState extends State<ShowIMDBSlider> {

  double rating = 1;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Inject>(context, listen: false);
    return Container(
      child: Slider.adaptive(
        value: rating,
        onChanged: (double newRating) {
          setState(() {
            rating = newRating;
          });
        },
        onChangeEnd: (_){
          provider.urlBuilder.rating = rating.toInt();
        },
        divisions: 8,
        label: "> ${rating.toInt()}",
        min:1.0,
        max:9.0,
        activeColor: Colors.teal[800],
        inactiveColor: Colors.grey,

      ),

    );
  }
}


class GenerateFilterLabel extends StatelessWidget {
  GenerateFilterLabel({this.text,this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 5.0),
        Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}

class GenerateMainSearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Inject>(context,listen: false);
    return LayoutBuilder(builder: (context, constraints){
      return Container(
        width: constraints.maxWidth,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
          ),
          decoration: InputDecoration(
          hintText: "Search word",
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.teal[800],
                  width:1.0,
                )
            ),
        ),
        onChanged: (String word) {
          if(word=="")
            word=null;

          provider.urlBuilder.searchWord=word;
          provider.searchForWord();
          // print("word ${provider.urlBuilder.simpleSearchUrl}");
        },
      ),
      );
    });
  }
}

class GenerateSearchList extends StatelessWidget {
  GenerateSearchList({this.list});
  final List list;
  final double _simpleSearchResultListHeight = 400.0;
  final String noImagePng = "https://www.staticwhich.co.uk/static/images/products/no-image/no-image-available.png";
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Inject>(context,listen: false);
    if(provider.urlBuilder.searchWord!=null){
      return Column(
        children: [
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: this._simpleSearchResultListHeight),
              duration: Duration(seconds: 1),
              builder: (_,data, Widget child) => Container(
                height: data,
                child: child,
              ),
              child: ListView.builder(
                itemCount: list.length,
                cacheExtent: list.length.toDouble(),
                itemBuilder: (BuildContext context,index){
                  bool isTvShow = list[index]["isTvShow"];
                  // print("build $index");
                    return Card(
                    elevation: 5.0,
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).pushNamed("/movie",arguments: list[index]["id"]);
                      },
                      title: Center(child:Text('${list[index]["secondaryName"]}')),
                      leading: Image.network(
                        list[index]["covers"] == null || list[index]["covers"]["data"]["145"] == "" ? this.noImagePng : list[index]["covers"]["data"]["145"],

                        loadingBuilder: (_,child, progress ){
                          return progress==null ? child : CircularProgressIndicator() ;
                        },
                        scale: 0.3,
                      ),
                      trailing: DisplayType(isTvShow),
                    ),
                  );


                }),
              ),
              GenerateSearchMoreButton(),
        ],
      );
    }else{
      return Text(" ");
    }

  }
}


class GenerateSearchMoreButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Inject inject = Provider.of<Inject>(context);
    return Container(
        margin: EdgeInsets.only(top:10.0),
        color: Colors.deepPurpleAccent[800],
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 0.2,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
        ),
        child: FlatButton.icon(
          onPressed: (){
            Navigator.of(context).pushNamed("/search", arguments: inject.urlBuilder.searchUrl);
          },
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          label: Text("Show All Results",style: TextStyle(fontSize: 22.0)),
          icon: Icon(Icons.search),color: Colors.pink[800],

        ),
    );
  }
}

class GenerateFilterList extends StatelessWidget {
  GenerateFilterList({@required this.jsonPath, @required this.provider,this.type, this.radio=false});
  final String jsonPath;
  final double _listContainerHeight = 135;
  final double _listContainerWidth = 0.45;
  final String type;
  final provider;
  final bool radio;
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Container(
      height: this._listContainerHeight,
      width: media.size.width*this._listContainerWidth,
      child: FutureBuilder(
          future: this.provider.jsonParser.parseGenres(jsonPath: jsonPath),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  if(this.radio)
                    return RadioButtonGenerator(value: snapshot.data[index]);
                  else
                    return CheckBoxGenerator( value: snapshot.data[index], type: this.type,);
                },
                itemCount: snapshot.data.length,
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Icon(Icons.error_outline, color: Colors.red[800],);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }
}




class FloatThis{
  FloatThis({this.context, this.child,this.top,this.bottom,this.right,this.left,this.height,this.width});
  init(){
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          top: this.top,
          right: this.right,
          bottom: this.bottom,
          left: this.left,
          width: this.width,
          height: this.height,
          child: child,

      );
    });
    overlayState.insert(overlayEntry);
    return child;
  }
  BuildContext context;
  Widget child;
  double top;
  double left;
  double right;
  double bottom;
  double height;
  double width;

}






