import 'package:app_tiendita/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class OrdenExitosaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 200,
          ),
          Text('Compra Realizada!'),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              color: Colors.green,
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return HomePage();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}
