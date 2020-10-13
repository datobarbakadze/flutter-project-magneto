import 'dart:async';

import 'package:deskmaster/inject.dart';
import 'package:flutter/material.dart';
import 'package:deskmaster/screens/login/login_widgets.dart';
import 'package:deskmaster/widgets/app_bars.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[800],
      appBar: AppBars.defaultAppBar("Authenticate"),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenerateTextField(),
            SizedBox(height: 10.0,),
            GenerateAuthButton(),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}
