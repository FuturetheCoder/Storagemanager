import 'package:flutter/material.dart';
 
void main() => runApp(MaterialApp(
  home: How2Use(),
  debugShowCheckedModeBanner: false,
));
 
class How2Use extends StatefulWidget {
  How2Use({Key key}) : super(key: key);

  _How2UseState createState() => _How2UseState();
}

class _How2UseState extends State<How2Use> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      
       children:<Widget>[
         Text("how can i advice you to use this app vey well")
       ], 
    );
  }
}