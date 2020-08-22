import 'package:app_tiendita/src/modelos/credit_card_result.dart';
import 'package:app_tiendita/src/pages/resumen_de_compra_page.dart';
import 'package:app_tiendita/src/providers/user_card_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetodoDePago extends StatefulWidget {
  @override
  _MetodoDePagoState createState() => _MetodoDePagoState();
}

class _MetodoDePagoState extends State<MetodoDePago> {
  int groupRadio = 0;
  List<CreditCard> listCreditCard = List();

  @override
  Widget build(BuildContext context) {
    bool nextButtonIsEnabled = false;
    return Scaffold(
      backgroundColor: grisClaroTema,
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
          'Metodo de Pago',
          style: appBarStyle,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: FutureBuilder(
            future: UserCreditCardProvider().getUserCreditCards(context,
                Provider.of<LoginState>(context).getFireBaseUser().email),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                listCreditCard = snapshot.data;
                nextButtonIsEnabled = true;

                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: listCreditCard.length + 1,
                      itemBuilder: (context, index) {
                        if (index < listCreditCard.length) {
                          return _creditCardItem(
                              context,
                              index,
                              listCreditCard[index].type,
                              listCreditCard[index].number);
                        } else {
                          return FlatButton(
                            onPressed: () {},
                            child: Text('+ Agregar Tarjeta'),
                          );
                        }
                      },
                    ),
                  ],
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
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 20),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: FlatButton(
                child: Text(
                  'SIGUIENTE',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (nextButtonIsEnabled) {
                    setUserCreditCard();
                    setCurrentBatchTotalAmount();
                    setCurrentBatchPaymentMethod();
                    setCurrentBatchUserInfo();
                    setCurrentBatchPhoneNumber();
                    print('=====Iniciar Creación del Batch de Compra=====');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return ResumenDeCompra();
                      }),
                    );
                  }
                },
                color: azulTema,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _creditCardItem(
      BuildContext context, int index, String title, String subtitle) {
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
          trailing: Radio(
            activeColor: Colors.green,
            onChanged: (value) {
              setState(() {
                groupRadio = value;
                print(groupRadio);
              });
            },
            groupValue: groupRadio,
            value: index,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    );
  }

  void setUserCreditCard() {
    String selectedCardId = listCreditCard[groupRadio].id;
    Provider.of<UserCartState>(context)
        .addUserCreditCardToBatch(selectedCardId);
  }

  void setCurrentBatchTotalAmount() {
    Provider.of<UserCartState>(context).setCurrentBatchTotalAmount();
  }

  void setCurrentBatchPaymentMethod() {
    Provider.of<UserCartState>(context).setCurrentBatchPaymentMethod();
  }

  void setCurrentBatchUserInfo() {
    final firebaseUser = Provider.of<LoginState>(context).getFireBaseUser();
    Provider.of<UserCartState>(context).setCurrentBatchUserInfo(firebaseUser);
  }

  setCurrentBatchPhoneNumber() {
    Provider.of<UserCartState>(context).setCurrentBatchPhoneNumber();
  }
}
