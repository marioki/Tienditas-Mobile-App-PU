import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/providers/user/user_tienditas_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import 'create_user_address.dart';
import 'edit_user_address.dart';

// ignore: must_be_immutable
class UserAddressPage extends StatefulWidget {
  UserAddressPage({@required this.address, @required this.email});

  final String email;
  List<Address> address;
  @override
  _UserAddressPageState createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      Provider.of<LoginState>(context, listen: false).reloadUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Direcciones',
          style: appBarStyle,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: widget.address.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.address.length) {
            return GestureDetector(
              onTap: () async {
                final addressResult = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUserAddress(
                      userEmail: widget.email,
                      address: widget.address[index]
                    ),
                  ),
                );
                setState(() {
                  widget.address[index].name = addressResult.name;
                  widget.address[index].addressLine1 = addressResult.addressLine1;
                  widget.address[index].referencePoint = addressResult.referencePoint;
                  widget.address[index].province = addressResult.province;
                  widget.address[index].latitude = addressResult.latitude;
                  widget.address[index].longitude = addressResult.longitude;
                  widget.address[index].phoneNumber = addressResult.phoneNumber;
                  Provider.of<LoginState>(context, listen: false).reloadUserInfo();
                });
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.only(top: 8, bottom: 8),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.address[index].name),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.address[index].addressLine1,
                            maxLines: 4,
                          ),
                          Text(widget.address[index].province+
                              ',' +
                              ' ' +
                              widget.address[index].country),
                          Text(
                            "Referencia: " + widget.address[index].referencePoint,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ]
                  ),
                  trailing: PopupMenuButton<int>(
                    onSelected: (int value) async {
                      if (value == 1) {
                          final userTokenId = Provider.of<LoginState>(context, listen: false).currentUserIdToken;
                          ProgressDialog pr = ProgressDialog(context);
                          pr.style(
                              message: 'Procesando...',
                              progressWidget: Container(
                                height: 400,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ));
                          await pr.show();
                          var response = await UsuarioTienditasProvider().deleteAddress(userTokenId, widget.address[index].id, widget.email);
                          if (response.statusCode == 200) {
                            ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
                            if (responseTienditasApi.statusCode == 200) {
                              pr.hide();
                              print(responseTienditasApi.body.message);
                              setState(() {
                                widget.address.removeAt(index);
                              });
                            } else {
                              print(responseTienditasApi.body.message);
                              pr.hide();
                            }
                          }
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text("Eliminar"),
                        ),
                      ],
                  )
                  //_simplePopup(widget.address[index], widget.email, index),
                ),
              ),
            );
          } else {
            return FlatButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateUserAddress(
                      userEmail: widget.email
                    ),
                  ),
                );
                final userTokenId = Provider.of<LoginState>(context, listen: false).currentUserIdToken;
                var _userTienditas = await UsuarioTienditasProvider().getUserInfo(userTokenId, widget.email);
                setState(() {
                  widget.address = _userTienditas.address;
                });
              },
              child: Text('+ Agregar Dirección'),
            );
          }
        },
      ),
    );
  }

  Future _getThingsOnStartup() async {
    await Future.sync(() => null);
  }
}
