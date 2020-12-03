import 'package:app_tiendita/src/modelos/banks_model.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/providers/BankProvider.dart';
import 'package:app_tiendita/src/providers/user/user_tienditas_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditUserBankAccount extends StatefulWidget {
  EditUserBankAccount(
      {@required this.appBarTitle,
      @required this.userEmail,
      this.accountNumber,
      this.accountType,
      this.bankName,
      this.isDefault,
      this.id,
      @required this.method});

  final String appBarTitle;
  final String userEmail;
  final String method;
  String accountNumber;
  String accountType;
  bool isDefault;
  String bankName;
  String id;

  @override
  _EditUserBankAccountState createState() => _EditUserBankAccountState();
}

class _EditUserBankAccountState extends State<EditUserBankAccount> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var response;
  List<String> _error = [
    'Hubo problemas de conexión, \nfavor revisar su conexión a internet'
  ];

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(message: 'Guardando...');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          '${widget.appBarTitle}',
          style: appBarStyle,
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
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
                              FutureBuilder(
                                future: BankProvider().getAllBanks(context),
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.hasData) {
                                    BanksModel banksResult = snapshot.data;
                                    var banks = banksResult.body.banks;
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text("Seleccionar banco"),
                                        value: widget.bankName,
                                        onChanged: (newValue) {
                                          setState(() {
                                            widget.bankName = newValue;
                                          });
                                        },
                                        items: banks.map((value) {
                                          return new DropdownMenuItem(
                                            child: new Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  } else {
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: Text("Seleccionar banco"),
                                        onChanged: (newValue) {
                                          print(newValue);
                                        },
                                        items: _error.map((value) {
                                          return new DropdownMenuItem(
                                            child: new Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Text(
                                "Número de cuenta",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Nunito"),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: widget.accountNumber,
                                onChanged: (String value) {
                                  widget.accountNumber = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Ingresar número de cuenta';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: '000000000000000'),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Tipo de cuenta",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Nunito"),
                              ),
                              FutureBuilder(
                                future: BankProvider().getAllBanks(context),
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.hasData) {
                                    BanksModel banksResult = snapshot.data;
                                    var bankAccountType =
                                        banksResult.body.accountType;
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint:
                                            Text("Seleccionar tipo de cuenta"),
                                        value: widget.accountType,
                                        onChanged: (newValue) {
                                          setState(() {
                                            widget.accountType = newValue;
                                          });
                                        },
                                        items: bankAccountType.map((value) {
                                          return new DropdownMenuItem(
                                            child: new Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  } else {
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint:
                                            Text("Seleccionar tipo de cuenta"),
                                        onChanged: (newValue) {
                                          print(newValue);
                                        },
                                        items: _error.map((value) {
                                          return new DropdownMenuItem(
                                            child: new Text(value),
                                            value: value,
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Marcar cuenta como prederteminada",
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Nunito"),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Switch(value: widget.isDefault, onChanged: (value){
                                setState(() {
                                  widget.isDefault = value;
                                });
                              }),
                              SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  alignment: Alignment(0.0, 0.0),
                                  child: RaisedButton(
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
                                          fontFamily: "Nunito"),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        if (widget.bankName != null) {
                                          if (widget.method == "post") {
                                            pr.show();
                                            response =
                                                await UsuarioTienditasProvider()
                                                    .createBankAccount(
                                                        Provider.of<LoginState>(
                                                                context)
                                                            .currentUserIdToken,
                                                        widget.userEmail,
                                                        widget.bankName,
                                                        widget.accountNumber,
                                                        widget.accountType);
                                          }
                                          if (widget.method == "put") {
                                            pr.show();
                                            response =
                                                await UsuarioTienditasProvider()
                                                    .updateBankAccount(
                                                        Provider.of<LoginState>(
                                                                context)
                                                            .currentUserIdToken,
                                                        widget.userEmail,
                                                        widget.bankName,
                                                        widget.accountNumber,
                                                        widget.id,
                                                        widget.isDefault,
                                                        widget.accountType);
                                          }
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Debe seleccionar provincia'),
                                            ),
                                          );
                                        }
                                        if (response.statusCode == 200) {
                                          ResponseTienditasApi
                                              responseTienditasApi =
                                              responseFromJson(response.body);
                                          if (responseTienditasApi.statusCode ==
                                              200) {
                                            //Succes Response, Direccion Guardada
                                            pr.hide();
                                            print(responseTienditasApi
                                                .body.message);
                                            isLoading = false;
                                            Navigator.of(context).pop();
                                          } else {
                                            //Error en guardar o editar La  direccion
                                            pr.hide();
                                            print(responseTienditasApi
                                                .body.message);
                                            isLoading = false;
                                          }
                                        } else {
                                          //Error de conexion
                                          pr.hide();
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Hubo problemas al editar la tienda, \nfavor revisar su conexión a internet'),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  )),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
