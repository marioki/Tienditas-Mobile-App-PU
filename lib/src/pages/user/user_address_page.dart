import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAddressPage extends StatefulWidget {
  @override
  _UserAddressPageState createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<LoginState>(context).getTienditaUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Direcciones'),
      ),
      body: ListView.separated(
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
                  Text(user.address[index].referencePoint),
                ],
              ),
              trailing: FlatButton(
                onPressed: () {},
                child: Text('Editar'),
              ),
            );
          } else {
            return FlatButton(
              onPressed: () {},
              child: Text('+ Agregar Dirección'),
            );
          }
        },
      ),
    );
  }
}
