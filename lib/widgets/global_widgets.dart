import 'package:flutter/material.dart';
class DisplayType extends StatelessWidget {
  DisplayType(this.isTvShow);
  final bool isTvShow;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      decoration: BoxDecoration(
        color: isTvShow ? Colors.blue[800] : Colors.teal[800],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Text(
        isTvShow ? "TvShow" : "movie",
        style: TextStyle(color:Colors.white),
      ),
    );
  }
}

double roundDouble(double number,int decimalPoint){
  String newNumber = number.toStringAsFixed(decimalPoint);
  return double.parse(newNumber);
}

Widget circularProgress(){
  return Container(
      width:24,
      height:24,
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),));
}

String generateUrl(String movieId,String language,String quality){
  return "https://www.imovies.cc/ka/movies/$movieId/ss/$language/$quality/";
}