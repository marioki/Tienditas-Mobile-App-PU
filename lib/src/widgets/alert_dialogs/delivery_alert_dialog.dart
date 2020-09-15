import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryAlertDialogWidget extends StatefulWidget {
  final List<StoreDeliveryInfo> listOfOptions;
  final int index;

  const DeliveryAlertDialogWidget(
      {Key key, @required this.listOfOptions, @required this.index})
      : super(key: key);

  @override
  _DeliveryAlertDialogWidgetState createState() =>
      _DeliveryAlertDialogWidgetState();
}

class _DeliveryAlertDialogWidgetState extends State<DeliveryAlertDialogWidget> {
  int selectedRadio;
  bool optionIsSelected = false;

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
        child: ListView.builder(
          itemCount: widget.listOfOptions[widget.index].deliveryOptions.length,
          itemBuilder: (context, index) {
            return FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  selectedRadio = index;
                });
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.listOfOptions[widget.index]
                              .deliveryOptions[index].method),
                          Text(
                            widget.listOfOptions[widget.index]
                                .deliveryOptions[index].fee,
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
                    child: Text(widget.listOfOptions[widget.index]
                        .deliveryOptions[index].fee),
                  ),
                  Radio(
                    groupValue: selectedRadio,
                    value: index,
                    activeColor: Colors.green,
                    onChanged: (int value) {
                      print(value);
                      setState(() {
                        selectedRadio = value;
                        optionIsSelected = true;
                      });
                    },
                  ),
                ],
              ),
            );
          },
          shrinkWrap: true,
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
            if (optionIsSelected) {
              Navigator.pop(context);
              print(widget.listOfOptions[widget.index]
                  .deliveryOptions[selectedRadio].method);
              //Aqui estoy agregando la opcion de delivey seleccionada a la lista en el UserCartStateProvider
              DeliveryOption selectedOption = widget
                  .listOfOptions[widget.index].deliveryOptions[selectedRadio];

              selectedOption.selectedIndex = widget.index;
              print(selectedOption.selectedIndex);

              Provider.of<UserCartState>(context)
                  .addSelectedDeliveryOption(selectedOption);
            }
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}
