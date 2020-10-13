import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deskmaster/inject.dart';
import 'package:deskmaster/widgets/global_widgets.dart';
class GenerateMainSearchList extends StatefulWidget {
  GenerateMainSearchList({this.url});
  final String url;
  @override
  _GenerateMainSearchListState createState() => _GenerateMainSearchListState();
}


class _GenerateMainSearchListState extends State<GenerateMainSearchList> {
  List<dynamic> resultList = List<dynamic>();
  int page = 1;
  Inject inject;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _updateResultList();
      }
    });
  }
  _updateResultList(){
    inject.justSearch(widget.url,page).then((value) {
      this.resultList..addAll(value);
      inject.resultStreamController.sink.add(this.resultList);
      return this.page+=1;
    }).catchError((error){
      return inject.resultStreamController.addError(error);
    });
  }
  @override
  Widget build(BuildContext context) {
    inject = Provider.of<Inject>(context,listen: false);
    _updateResultList();

    return StreamBuilder(
              stream: inject.resultStreamController.stream,
              builder: (context,snapshot){
                if(snapshot.hasError)
                  return Text("error",key:UniqueKey());
                if(snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());

                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: this.resultList.length+1,
                    cacheExtent: this.resultList.length.toDouble(),
                    itemBuilder: (_,index){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 1),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: index==this.resultList.length ? Center(child: CircularProgressIndicator(),) : GenerateMainListTile(this.resultList,index),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
  }
}

class GenerateMainListTile extends StatelessWidget {
  GenerateMainListTile(this.list,this.index);
  final List list;
  final int index;
  final String noImagePng = "https://www.staticwhich.co.uk/static/images/products/no-image/no-image-available.png";
  String movieImage(){
    try{
      return list[index]["covers"]["data"]["145"];
    }catch(e) {
      return this.noImagePng;
    }
  }
  @override
  Widget build(BuildContext context) {
    final int movieId = this.list[index]["id"];
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed("/movie",arguments: movieId);
      },
      child: ListTile(
        leading: Image.network(
          list[index]["covers"] == null || list[index]["covers"]["data"]["145"] == "" ? this.noImagePng : list[index]["covers"]["data"]["145"],
          scale: 1,
          loadingBuilder: (_,child,progress){
            return progress ==null ? child : CircularProgressIndicator();
          },
        ),
        title: Center(child:Text('${list[index]["secondaryName"]}')),
        trailing: DisplayType(list[index]["isTvShow"]),
      ),
    );
  }
}
