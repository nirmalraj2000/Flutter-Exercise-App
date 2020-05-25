import 'package:flutter/material.dart';

class CreaterPage extends StatefulWidget {
  @override
  _CreaterPageState createState() => _CreaterPageState();
}

class _CreaterPageState extends State<CreaterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffffffff),
            iconTheme: IconThemeData(color: Colors.blue),
            title: Text(
              "Creater Section",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("Images/createrImage.jpg"),
                    ),
                  ),
                ),
                Text(
                  "Nirmal",
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(
                    "This app was created to people who wish to do their daily routine of workout without any deviation." +
                        " Whenever the user started their workout the application will play the music. The music is stopped during the break time. " +
                        "I took nearly 40 hours to complete this app." +
                        "I created this app with my own curiosity. " +
                        "If any body want to purchase this app, I would surely customize as per the customer's preferences.",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30),
                
                child: Text(r"$ 49",style: TextStyle(fontSize: 40,color: Colors.blue),)
                )
              ],
            ),
          )),
    );
  }
}
