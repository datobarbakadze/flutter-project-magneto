
import 'package:flutter/material.dart';
import 'package:deskmaster/core/router.dart';
import 'inject.dart';
import 'package:provider/provider.dart';
import 'package:deskmaster/services/net_data.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    Routing router = new Routing();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Inject>(create: (context) => Inject(),),
        StreamProvider<MovieState>(
          initialData: MovieState(),
            catchError: (context,object){
              print(object);
              return MovieState();
            },
            create: (context) => UpdateState.getData(context)
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: "/device",
        onGenerateRoute: router.onRouteGen,
      ),
    );
  }
}



