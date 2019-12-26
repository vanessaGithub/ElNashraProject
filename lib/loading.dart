import 'package:flutter/material.dart';

class Loading extends StatefulWidget {



  @override
  _LoadingState createState() => _LoadingState();
}



class _LoadingState extends State<Loading> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
          child: Image.asset('assets/elnashralogo.png'),
            
        ),
    );
  }
}
