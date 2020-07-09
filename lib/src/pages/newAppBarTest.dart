import 'dart:html';

import 'package:flutter/material.dart';

class NewAppBarTestPAge extends StatefulWidget {
  @override
  _NewAppBarTestPAgeState createState() => _NewAppBarTestPAgeState();
}

class _NewAppBarTestPAgeState extends State<NewAppBarTestPAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('New App Bar'),
      ),
    );
  }
}
