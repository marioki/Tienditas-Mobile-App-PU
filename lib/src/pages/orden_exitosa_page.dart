import 'package:app_tiendita/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class OrdenExitosaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 200,
            ),
            Text('Compra Confirmada!'),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                child: Text('OK'),
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
      ),
    );
  }
}
