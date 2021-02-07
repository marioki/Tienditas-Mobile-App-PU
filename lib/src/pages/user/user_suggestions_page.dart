import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/providers/user/user_tienditas_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class SuggestionPage extends StatefulWidget {
  SuggestionPage({this.email});
  final String email;
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final _formKey = GlobalKey<FormState>();
  var response;
  String suggestion;
  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(message: 'Guardando...');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Sugerencias',
          style: appBarStyle,
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                            "Cuentanos que sugerencias tienes que te gustaría ver en el app",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nunito"),
                          ),
                          TextFormField(
                            onChanged: (String value) {
                              suggestion = value;
                            },
                            maxLines: 5,
                            minLines: 1,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Ingresar una sugerencia';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: ''),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              alignment: Alignment(0.0, 0.0),
                              child: RaisedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    pr.style(
                                      message: 'Enviando',
                                      progressWidget: Container(
                                        height: 400,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                    await pr.show();
                                    response = await UsuarioTienditasProvider().sendSuggestion(
                                        Provider.of<LoginState>(context, listen: false).currentUserIdToken,
                                        widget.email,
                                        suggestion
                                    );
                                    if (response.statusCode == 200) {
                                      pr.hide();
                                      ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
                                      if (responseTienditasApi.statusCode == 200) {
                                        print(responseTienditasApi.body.message);
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(builder: (context, setState) {
                                              return AlertDialog(
                                                elevation: 10,
                                                title: Column(
                                                  children: <Widget>[
                                                    Image(
                                                      width: 60,
                                                      height: 60,
                                                      image: AssetImage(
                                                          "assets/images/icons/idea.png"),
                                                    ),
                                                    Text(
                                                      "¡Gracias!",
                                                      style: TextStyle(
                                                          color: Color(0xFF191660),
                                                          fontSize: 25,
                                                          fontWeight: FontWeight.normal,
                                                          fontFamily: "Nunito"),
                                                    ),
                                                  ],
                                                ),
                                                content: Text(
                                                  "Gracias por tu tiempo, estaremos leyendo tu sugerencia para hacerla realidad en el app",
                                                  style: TextStyle(
                                                      color: Color(0xFF191660),
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                      fontFamily: "Nunito"),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Cerrar'),
                                                    color: Color(0xFF191660),
                                                    onPressed: () async {
                                                      var count = 0;
                                                      Navigator.popUntil(context, (route) {
                                                          return count++ == 2;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                          },
                                        );
                                      } else {
                                        pr.hide();
                                        print(responseTienditasApi.body.message);
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
                        ]),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}