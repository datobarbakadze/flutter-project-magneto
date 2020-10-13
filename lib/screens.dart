import 'package:deskmaster/screens/login/login.dart';
import 'package:deskmaster/screens/home/home.dart';
import 'package:deskmaster/screens/search/search.dart';
import 'package:deskmaster/screens/movie/movie.dart';
import 'package:deskmaster/screens/device/device.dart';


abstract class Screens {
  final Map<String, Map<String, dynamic>> _screens = {
    "/": {
      "widget": () =>  MyHomePage(),
    },
    "/search":{
      "widget": (String url) => SearchPage(url: url,)
    },
    "/movie": {
      "widget": (int movieId) => MoviePage(movieId: movieId),
    },
    "/login":{
      "widget": () => LoginPage()
    },
    "/device":{
      "widget": () => Device()
    }
  };

  Map<String, Map<String, dynamic>> get screens => _screens;
}