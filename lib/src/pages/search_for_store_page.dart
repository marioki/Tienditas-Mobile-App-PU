import 'package:flutter/material.dart';

class SearchForStorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(),
        actions: <Widget>[],
      ),
      body: Center(
        child: Text('Search results here'),
      ),
    );
  }
}
