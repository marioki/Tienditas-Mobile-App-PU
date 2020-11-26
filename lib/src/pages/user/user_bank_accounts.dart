import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/providers/user/user_tienditas_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
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
      body: ListView.builder(
        padding: EdgeInsets.only(top: 16),
        itemCount: user.bankAccounts.length + 1,
        itemBuilder: (context, index) {
          if (index < user.bankAccounts.length) {
            return _bankAccountItem(
                context,
                index,
                user.bankAccounts[index],
                user.email
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

  Widget _simplePopup(BankAccount bankAccount) => PopupMenuButton<int>(
    onSelected: (int value) {
      print(value);
      if (value == 1) {
        deleteBankAccount(bankAccount, context);
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 1,
        child: Text("Eliminar"),
      ),
    ],
  );

  Widget _bankAccountItem(BuildContext context, int index, BankAccount bankAccount, String userEmail) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditUserBankAccount(
                  appBarTitle: "Editar Cuenta",
                  userEmail: userEmail,
                  method: "put",
                  bankName: bankAccount.bankName,
                  accountNumber: bankAccount.accountNumber,
                  accountType: bankAccount.accountType,
                  id: bankAccount.id,
                  isDefault: bankAccount.isDefault
              ),
            ),
          );
        },
        child: ListTile(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8),
                    Text(
                      bankAccount.bankName,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Tipo: ${bankAccount.accountType}",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Número de cuenta: ${bankAccount.accountNumber}",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
          trailing: _simplePopup(bankAccount),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    );
  }

  Future<void> deleteBankAccount(BankAccount creditCard, BuildContext context) async {
    final firebaseUser = Provider.of<LoginState>(context).getFireBaseUser();
    final userTokenId = Provider.of<LoginState>(context).currentUserIdToken;
    ProgressDialog pr = ProgressDialog(context);
    pr.style(
        message: 'Cargando...',
        progressWidget: Container(
          height: 400,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
    await pr.show();
    var response = await UsuarioTienditasProvider().deleteBankAccount(firebaseUser, userTokenId, creditCard);
    if (response.statusCode == 200) {
      ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
      if (responseTienditasApi.statusCode == 200) {
        pr.hide();
        print(responseTienditasApi.body.message);
        setState(() {});
      } else {
        print(responseTienditasApi.body.message);
        pr.hide();
      }
    }
  }

  Future _getThingsOnStartup() async {
    await Future.sync(() => null);
  }
}
