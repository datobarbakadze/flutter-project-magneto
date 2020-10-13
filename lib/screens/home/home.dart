import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:deskmaster/screens/home/home_widgets.dart';
import 'package:deskmaster/inject.dart';
import 'package:deskmaster/widgets/app_bars.dart';

class MyHomePage extends StatelessWidget {

  final String genresJsonPath = "assets/json/genre.json";
  final String countriesJsonPath = "assets/json/countries.json";
  final String studiosJsonPath = "assets/json/studios.json";
  final String languagesJsonPath = "assets/json/languages.json";
  final String festivalsJsonPath = "assets/json/festivals.json";
  final double _listContainerHeight = 135.0;
  final double _listContainerWidth = 180.0;
  dynamic langGroupValue = "";
  // BuildContext overlayContext;
  // void invoke(){
  //   FloatThis(context: this.overlayContext,top: 50,left: 100,child: Container(height: 50,width: 50, color: Colors.red,)).init();
  // }
  @override
  Widget build(BuildContext context) {
    final inject = Provider.of<Inject>(context, listen: false);
    // Icons.ce
    // this.overlayContext = context;
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBars.defaultAppBar("Search filters"),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              GenerateMainSearchField(),
              Consumer<Inject>(builder: (_,data,__){
                return GenerateSearchList(list: data.searchResult,);
              }),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      GenerateFilterLabel(text:"Genres",icon: Icons.movie,),
                      GenerateFilterList(jsonPath: this.genresJsonPath,provider: inject,type:"genres"),
                    ],
                  ),
                  Column(
                    children: [
                      GenerateFilterLabel(text:"Countries", icon: Icons.outlined_flag),
                      GenerateFilterList(jsonPath: this.countriesJsonPath,provider: inject,type:"countries"),
                    ],
                  ),
                ],
              ),
              SizedBox(height:30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      GenerateFilterLabel(text:"Studios",icon: Icons.camera_alt),
                      GenerateFilterList(jsonPath: this.studiosJsonPath,provider: inject,type:"studios"),
                    ],
                  ),
                  Column(
                    children: [
                      GenerateFilterLabel(text:"language",icon: Icons.language),
                      GenerateFilterList(jsonPath: this.languagesJsonPath,provider: inject,radio: true,),
                    ],
                  ),
                ],
              ),
              SizedBox(height:30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        GenerateFilterLabel(text:"Festivals",icon: Icons.cake),
                        GenerateFilterList(jsonPath: this.festivalsJsonPath,provider: inject,type:"festivals"),
                      ],
                    ),
                    Column(
                      children: [
                        GenerateFilterLabel(text: "Release year",icon: Icons.date_range),
                        Container(
                            width: this._listContainerWidth,
                            height: this._listContainerHeight,
                            child : Column(
                              children: [
                                YearTextField(label: "From year",type: "from",),
                                YearTextField(label: "Till Year", type: "till",),
                              ],
                            )
                        )
                      ],
                    )
                  ]
              ),
              SizedBox(height: 20),

              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                    child:Center(child:GenerateFilterLabel(text: "IMDB Rating",icon: Icons.star_border)),
                  ),
                  ShowIMDBSlider(),
                ],
              ),
              SizedBox(height:20)

            ],
          ),

        ),
      ),
    );
  }
}