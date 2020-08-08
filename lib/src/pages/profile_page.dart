import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('Mis Ordenes'),
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Direcciones'),
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Metodos de Pago'),
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Ayuda'),
          ),
          Divider(color: Colors.grey),
          ListTile(
            onTap: () => Provider.of<LoginState>(context).logout(),
            leading: Icon(Icons.account_circle),
            title: Text('Cerrar sesión'),
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
