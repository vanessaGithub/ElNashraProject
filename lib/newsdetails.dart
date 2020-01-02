import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MyAppBar.dart';

class NewsDetails extends StatefulWidget {
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {


  Map newsData = {};

  @override


  Widget build(BuildContext context) {

    newsData = newsData.isNotEmpty ? newsData :  ModalRoute.of(context).settings.arguments;

    print('newsData: $newsData');


    return SafeArea(
        child: Scaffold(
          appBar:

//          MyAppBar(
//              title: "ElNashra"
//          ),

          AppBar(
            iconTheme: new IconThemeData(color: Colors.blueAccent),
            centerTitle: true,
            actions: <Widget>[
//              IconButton(
//                icon: Icon(
//                  Icons.menu,
//                  color: Colors.blueAccent,
//                ),
//                onPressed: () {
//                  // do something
//                },
//              )
            ],
            title: Text(

              'ElNashra',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 20,
               color: Colors.blueAccent
              ),
            ),
            backgroundColor: Colors.grey[100],
          ),

          endDrawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        newsData['title'],
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.cairo(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Stack(children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image(
                                height: 200,
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    newsData['image']),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
                SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.fromLTRB(25,0,20,20),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Html (
                      customTextAlign: (_){
                        return TextAlign.justify;
                      },
                      data: newsData['details'],
                      defaultTextStyle: GoogleFonts.cairo(
                      fontSize: 16,
                      ),
                    ),
                  )
                ),

              ],
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
