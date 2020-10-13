import 'dart:async';

import 'package:flutter/material.dart';
import 'package:deskmaster/screens/search/search_widgets.dart';
import 'package:deskmaster/inject.dart';
import 'package:provider/provider.dart';
import 'package:deskmaster/widgets/app_bars.dart';
class SearchPage extends StatefulWidget {
  SearchPage({this.url});
  final dynamic url;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  StreamController streamControler = StreamController<dynamic>();
  Inject inject;
  @override
  void dispose() {
    super.dispose();
    this.streamControler.close();
    this.inject.resultStreamController.close();
    this.streamControler = null;
  }
  @override
  Widget build(BuildContext context) {
    this.inject = Provider.of<Inject>(context);
    this.inject.resultStreamController = streamControler;
    return Scaffold(
      appBar: AppBars.defaultAppBar("Search results"),
      body: Container(
        child: GenerateMainSearchList(url:widget.url),
      ),
    );
  }
}
