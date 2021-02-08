import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_user_address.dart';

class UserAddressPage extends StatefulWidget {
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
    UserTienditas user = Provider.of<LoginState>(context,listen: false).getTienditaUser();

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
          'Direcciones',
          style: appBarStyle,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 16),
        separatorBuilder: (context, index) => Divider(),
        itemCount: user.address.length + 1,
        itemBuilder: (context, index) {
          if (index < user.address.length) {
            return ListTile(
              title: Text(user.address[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.address[index].addressLine1),
                  Text(user.address[index].country +
                      ',' +
                      ' ' +
                      user.address[index].province),
                  Text("Referencia: " + user.address[index].referencePoint),
                ],
              ),
              trailing: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUserAddress(
                        appBarTitle: "Agregar Dirección",
                        userEmail: user.userEmail,
                        method: "put",
                        id: user.address[index].id,
                        name: user.address[index].name,
                        addressLine: user.address[index].addressLine1,
                        referencePoint: user.address[index].referencePoint,
                        provinceName: user.address[index].province,
                      ),
                    ),
                  );
                },
                child: Text('Editar'),
              ),
            );
          } else {
            return FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUserAddress(
                      appBarTitle: "Agregar Dirección",
                      userEmail: user.userEmail,
                      method: "post",
                    ),
                  ),
                ).then((value) =>
                    Provider.of<LoginState>(context, listen: false).reloadUserInfo());
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
