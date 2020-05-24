import 'package:flutter/material.dart';

import 'Screens/HomePage.dart';
import 'Screens/Workout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Exercise App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          cursorColor: Colors.blue,
          textSelectionHandleColor: Colors.blue,
        ),
        home:Workout(),
        initialRoute: "/WorkoutPage",
        routes: <String, WidgetBuilder>{
          "/WorkoutPage": (BuildContext context) => Workout(),
          "/HomePage": (BuildContext context) => HomePage()
        });
  }
}
