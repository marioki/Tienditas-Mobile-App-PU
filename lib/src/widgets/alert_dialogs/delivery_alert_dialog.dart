import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class DeliveryAlertDialogWidget extends StatefulWidget {
  @override
  _DeliveryAlertDialogWidgetState createState() =>
      _DeliveryAlertDialogWidgetState();
}

class _DeliveryAlertDialogWidgetState extends State<DeliveryAlertDialogWidget> {
  int radioGroup = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.directions_car,
            size: 35,
          ),
          Text(
            'Opciones De Envío',
            style: TextStyle(
              fontSize: 20,
              color: azulTema,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Container(
        padding: EdgeInsets.all(16),
        width: 350,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  radioGroup = 1;
                });
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Opcion #1'),
                          Text(
                            'Entrega por las cumbres, San Fransico',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text('\$2.00'),
                  ),
                  Radio(
                    groupValue: radioGroup,
                    value: 1,
                    activeColor: Colors.green,
                    onChanged: (int value) {
                      print(value);
                      setState(() {
                        radioGroup = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.5),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  radioGroup = 2;
                });
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Opcion #1'),
                          Text(
                            'Entrega por las cumbres, San Francisco',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text('\$2.00'),
                  ),
                  Radio(
                    groupValue: radioGroup,
                    value: 2,
                    activeColor: Colors.green,
                    onChanged: (int value) {
                      print(value);
                      setState(() {
                        radioGroup = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.5),
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  radioGroup = 3;
                });
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Opcion #1'),
                          Text(
                            'Entrega por las cumbres, San Fransico',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text('\$2.00'),
                  ),
                  Radio(
                    groupValue: radioGroup,
                    value: 3,
                    activeColor: Colors.green,
                    onChanged: (int value) {
                      print(value);
                      setState(() {
                        radioGroup = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.5),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
          textColor: Colors.grey,
        ),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok')),
      ],
    );
  }
}
