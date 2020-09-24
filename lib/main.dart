import 'package:flutter/material.dart';
import 'package:fluter_timeApp/screens/home.dart';
import 'package:fluter_timeApp/screens/loading.dart';
import 'package:fluter_timeApp/screens/choose_location.dart';


void main() => runApp(
  MaterialApp(
    initialRoute: '/',
routes:  {
  '/' : (context) => Loading(),
  '/home' : (context) => Home(),
  '/location': (context) => ChooseLocation(),
},
));   