import 'package:app_tiendita/src/widgets/alert_dialogs/delivery_alert_dialog.dart';
import 'package:flutter/material.dart';

class PlaceHolderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dud page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return DeliveryAlertDialogWidget();
              },
            );
          },
          child: Text('Alerta'),
        ),
      ),
    );
  }
}
