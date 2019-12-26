import 'dart:io';

import 'package:elnashra_flutter_project/loading.dart';
import 'package:elnashra_flutter_project/newsdetails.dart';
import 'package:elnashra_flutter_project/newsfirstpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'news.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

void main() {
  //debug configuration
//  CatcherOptions debugOptions =
//  CatcherOptions(NotificationReportMode(), [ConsoleHandler()]);
//
//  //release configuration
//  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
//    EmailManualHandler(["recipient@email.com"])
//  ]);
//
//  //profile configuration
//  CatcherOptions profileOptions = CatcherOptions(
//    NotificationReportMode(),
//    [ConsoleHandler(), ToastHandler()],
//    handlerTimeout: 10000,
//    customParameters: {"example": "example_parameter"},
//  );
//
//  //MyApp is root widget
//  Catcher(MyApp(),
//      debugConfig: debugOptions,
//      releaseConfig: releaseOptions,
//      profileConfig: profileOptions);

  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    // In debug mode, use the normal error widget which shows
    // the error message:
    if (inDebug)
      return ErrorWidget(details.exception);
    // In release builds, show a yellow-on-blue message instead:
    return Scaffold(
      body: Container(
        color: Colors.grey[700],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      color: Colors.red[300],
                      size: 60.0,
                      semanticLabel: '',
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Something Went Wrong...',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 20.0),

                    Text(
                      'World Time Application has crashed! Try again later',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        wordSpacing: 2,
                      ),
                    ),

                    SizedBox(height: 30.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          color: Colors.red[300],
                          onPressed: () {
                            exit(0); // To close the dialog
                          },
                          child: Text(
                            'Close Application',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  };

//  Container(
//    color: Colors.grey[100],
//    child: Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Dialog(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(10),
//          ),
//          elevation: 0.0,
//          backgroundColor: Colors.blue,
//          child: Text(
//            'Close Application',
//            style: TextStyle(
//              fontSize: 18,
//              fontFamily: 'RobotoMono',
//              color: Colors.black,
//            ),
//          ),
//        ),
//      ],
//    ),
//  )

//return runApp(MyApp(key: rootkey));

  return runApp(MyApp());

}


class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key:key);


  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
        initialRoute: ('/'),
        routes: {
          '/': (context) => MyHomePage(),
          '/home': (context) => MyHomePage(),
          '/newsdetails': (context) => NewsDetails(),
        }
    );
  }

}