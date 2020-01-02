import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  Icon searchIcon = Icon(Icons.search);
  Icon cancelIcon = Icon(Icons.cancel);
  Icon changeIcon;

  MyAppBar({Key key, String title})
      : super(
          key: key,
          iconTheme: new IconThemeData(color: Colors.blueAccent),
          centerTitle: true,
          title:  Text(
            "$title",
            style: TextStyle(
                color: Colors.blueAccent
            ),
          ),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.edit_location),
              onPressed: () {
                print('icon tapped');
              },
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          backgroundColor: Colors.grey[100],
        );
}
