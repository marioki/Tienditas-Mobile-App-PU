import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_user_address.dart';
import 'edit_user_bank_accounts.dart';

class UserBankAccountsPage extends StatefulWidget {
  @override
  _UserBankAccountsPageState createState() => _UserBankAccountsPageState();
}

class _UserBankAccountsPageState extends State<UserBankAccountsPage> {
  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      Provider.of<LoginState>(context).reloadUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<LoginState>(context).getTienditaUser();

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
          'Cuentas Bancarias',
          style: appBarStyle,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 16),
        separatorBuilder: (context, index) => Divider(),
        itemCount: user.bankAccounts.length + 1,
        itemBuilder: (context, index) {
          if (index < user.bankAccounts.length) {
            return ListTile(
              title: Text(user.bankAccounts[index].bankName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.bankAccounts[index].accountNumber),
                  Text(user.bankAccounts[index].accountType)
                ],
              ),
              trailing: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUserBankAccount(
                        appBarTitle: "Editar Cuenta",
                        userEmail: user.userEmail,
                        method: "put",
                        bankName: user.bankAccounts[index].bankName,
                        accountNumber: user.bankAccounts[index].accountNumber,
                        accountType: user.bankAccounts[index].accountType,
                        id: user.bankAccounts[index].id,
                        isDefault: user.bankAccounts[index].isDefault
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
                    builder: (context) => EditUserBankAccount(
                      appBarTitle: "Agregar Cuenta",
                      userEmail: user.userEmail,
                      method: "post",
                    ),
                  ),
                ).then((value) =>
                    Provider.of<LoginState>(context).reloadUserInfo());
              },
              child: Text('+ Agregar Cuenta'),
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
