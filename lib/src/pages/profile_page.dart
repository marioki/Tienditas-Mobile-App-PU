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
    return Center(
      child: RaisedButton(
        onPressed: () {
          Provider.of<LoginState>(context).logout();
        },
        child: Text('Logout'),
      ),
    );
  }
}
