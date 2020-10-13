import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
class JsonParser  {
  Future<List> parseGenres({String jsonPath}) async {
    String file = await this.loadAsString(jsonPath);
    List genres = json.decode(file);
    return genres;
  }
  Future<String> loadAsString(String path) async{
    return await rootBundle.loadString(path);
  }
}

//
// void main(){
//   dynamic decoded;
//   JsonParser sf = new JsonParser();
//   var genres = sf.parseGenres();
//   genres.then((value) =>decoded = json.decode(value));
//   print(decoded);
// }
