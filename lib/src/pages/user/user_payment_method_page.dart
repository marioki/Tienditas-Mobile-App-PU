import 'package:app_tiendita/src/modelos/credit_card_result.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/providers/user/delete_credit_card_provider.dart';
import 'package:app_tiendita/src/providers/user/user_card_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../crear_tarjeta_page.dart';

class UserPaymentMethod extends StatefulWidget {
  @override
  UserPaymentMethodState createState() => UserPaymentMethodState();
}

class UserPaymentMethodState extends State<UserPaymentMethod> {
  int groupRadio = 0;
  List<CreditCard> listCreditCard = [];

  @override
  Widget build(BuildContext context) {
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
          'Métodos de Pago',
          style: appBarStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
            future: UserCreditCardProvider().getUserCreditCards(context,
                Provider.of<LoginState>(context,listen: false).getFireBaseUser().email),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                listCreditCard = snapshot.data;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: listCreditCard.length + 1,
                  itemBuilder: (context, index) {
                    if (index < listCreditCard.length) {
                      return _creditCardItem(
                          context,
                          index,
                          listCreditCard[index].type,
                          listCreditCard[index].number,
                          listCreditCard[index]);
                    } else {
                      return FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CrearNuevaTarjeta(),
                            ),
                          );
                        },
                        child: Text('+ Agregar Tarjeta'),
                      );
                    }
                  },
                );
              } else {
                return Container(
                  height: 400,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget _simplePopup(CreditCard creditCard) => PopupMenuButton<int>(
        onSelected: (int value) {
          print(value);
          if (value == 1) {
            deleteCreditCard(creditCard, context);
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Eliminar"),
          ),
        ],
      );

  Widget _creditCardItem(BuildContext context, int index, String title,
      String subtitle, CreditCard creditCard) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: FlatButton(
        onPressed: () {},
        child: ListTile(
          title: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          trailing: _simplePopup(creditCard),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    );
  }

  Future<void> deleteCreditCard(
      CreditCard creditCard, BuildContext context) async {
    final tienditasUser =
        Provider.of<LoginState>(context, listen: false).getTienditaUser();
    final userTokenId = Provider.of<LoginState>(context, listen: false).currentUserIdToken;
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
    var response = await DeleteCreditCard()
        .deleteCreditCard(tienditasUser, userTokenId, creditCard);
    if (response.statusCode == 200) {
      ResponseTienditasApi responseTienditasApi =
          responseFromJson(response.body);
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
}
