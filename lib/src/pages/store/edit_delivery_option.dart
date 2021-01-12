import 'dart:ui';

import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/store/store_model.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDeliveryOptions extends StatefulWidget {
  EditDeliveryOptions({@required this.appBarTitle, @required this.storeTagName, this.name, this.method, this.fee, this.id});
  final String appBarTitle;
  final String storeTagName;
  final String name;
  final String fee;
  final String method;
  final String id;
  @override
  _EditDeliveryOptionsState createState() => _EditDeliveryOptionsState();
}

class _EditDeliveryOptionsState extends State<EditDeliveryOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35)
            ),
          ),
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: azulTema,
          title: Text(
            '${widget.appBarTitle}',
            style: appBarStyle,
          ),
        ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: EditDeliveryOptionCard(
          storeTagName: widget.storeTagName,
          name: widget.name,
          method: widget.method,
          fee: widget.fee,
          id: widget.id,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EditDeliveryOptionCard extends StatelessWidget {
  EditDeliveryOptionCard(
      {
        this.name,
        this.method,
        this.fee,
        this.id,
        @required this.storeTagName,
      }
  );

  String name;
  String method;
  String fee;
  final String storeTagName;
  final _formKey = GlobalKey<FormState>();
  final String id;

  bool isLoading = false;
  var response;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Nombre",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"
                            ),
                          ),
                          TextFormField(
                            initialValue: name,
                            onChanged: (String value) {
                              name = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Ingresar nombre del método de envío';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'nombre'
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Método de Envío",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nunito"
                            ),
                          ),
                          TextFormField(
                            initialValue: method,
                            onChanged: (String value) {
                              method = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Ingresar método de envío';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'método'
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Costo",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nunito"
                            ),
                          ),
                          TextFormField(
                            initialValue: fee,
                            keyboardType: TextInputType.number,
                            onChanged: (String value) {
                              fee = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Ingresar costo del método de envío';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: 'costo'
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment(0.0, 0.0),
                          child: RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Procesando...')));
                                // editDeliveryOption
                                if(id != null) {
                                  response = await StoreProvider().editDeliveryOption(
                                      Provider.of<LoginState>(context).currentUserIdToken,
                                      storeTagName,
                                      id,
                                      name,
                                      method,
                                      fee
                                  );
                                } else {
                                  response = await StoreProvider().newDeliveryOption(
                                      Provider.of<LoginState>(context).currentUserIdToken,
                                      storeTagName,
                                      name,
                                      method,
                                      fee
                                  );
                                }
                                if (response.statusCode == 200) {
                                  ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
                                  if (responseTienditasApi.statusCode == 200) {
                                    print(responseTienditasApi.body.message);
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                '${responseTienditasApi.body.message}'
                                            ),
                                        ),
                                    );
                                    isLoading = false;
                                    var count = 0;
                                    Navigator.popUntil(context, (route) {
                                      return count++ == 3;
                                    });
                                    //Navigator.of(context).popUntil((route) => route.isFirst);
                                    //Navigator.of(context).pop(context);
                                  } else {
                                    print(responseTienditasApi.body.message);
                                    isLoading = false;
                                  }
                                }
                              }
                            },
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            textColor: Colors.white,
                            child: Text(
                              "Guardar",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Nunito"
                              ),
                            ),
                          ),
                        )
                      ]
                  ),
                ),
              ),
          ),
            ),
        ]
      ),
    );
  }
}