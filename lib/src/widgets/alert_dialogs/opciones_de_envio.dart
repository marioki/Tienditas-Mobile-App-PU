import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class OpcionesDeEnvio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.local_car_wash,
            size: 58,
          ),
          Text(
            'Los productos "Por pedido" suelen demorar 15 días hábiles en ser entrgados',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Nunito',
              color: azulOscuro,
            ),
          ),
          SizedBox(height: 20),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 46),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Al Carrito',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            color: rosadoClaro,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          )
        ],
      ),
    );
  }
}
