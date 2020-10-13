import 'dart:async';
import 'dart:io';
import 'package:deskmaster/helper/JsonParser.dart';
import 'package:deskmaster/helper/url_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Inject extends ChangeNotifier {
  final JsonParser jsonParser = new JsonParser();
  final UrlBuilder urlBuilder = UrlBuilder();
  StreamController resultStreamController;
  Socket socket;
  String currentQuality = "HIGH";
  String currentLanguage = "ENG";
  String connection_ip;
  var movieData;
  List searchResult;
  void updateList({int value, bool action, String type}){
    switch(type){
      case "genres":{

        if(action==true)
          urlBuilder.genres.add(value);
        else
          urlBuilder.genres.remove(value);
      }
      break;
      case "studios":{
        if(action==true)
          urlBuilder.studios.add(value);
        else
          urlBuilder.studios.remove(value);
      }
      break;
      case "festivals":{
        if(action==true)
          urlBuilder.festivals.add(value);
        else
          urlBuilder.festivals.remove(value);
      }
      break;
      case "countries":{
        if(action==true)
          urlBuilder.countries.add(value);
        else
          urlBuilder.countries.remove(value);
      }
      break;
    }
  }
  void updateYear({String value, String type }){
    switch(type){
      case "from":{
        urlBuilder.fromYear = value;
      }
      break;
      case "till":{
        urlBuilder.tillYear = value;
      }
      break;
    }
  }
  void updateGroupValue(String gval){
    urlBuilder.groupValue=gval;
    notifyListeners();
  }

  String genUrl({int page=1}){
    return urlBuilder.searchUrl = Uri.encodeFull("https://api.imovies.cc/api/v1/search?keywords=${urlBuilder.searchWord}&filters%5Btype%5D=movie%2Ccast&per_page=${urlBuilder.perPage}");

  }
  void searchForWord() async {
    if(urlBuilder.searchWord != null){
      urlBuilder.searchUrl = this.genUrl();
      http.Response response = await http.get(urlBuilder.searchUrl);
      this.searchResult = json.decode(response.body)["data"];
    }else{
      this.searchResult=null;
    }
    notifyListeners();
  }
  Future<List<dynamic>> justSearch(url,page) async {
    http.Response response = await http.get(url+"&page=${page}");
    var data = json.decode(response.body)["data"];
    // print(data.runtimeType);
    return data;
  }

}
