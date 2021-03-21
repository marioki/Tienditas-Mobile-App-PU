import 'package:app_tiendita/src/modelos/credit_card_result.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/pages/crear_tarjeta_page.dart';
import 'package:app_tiendita/src/pages/resumen_de_compra_page.dart';
import 'package:app_tiendita/src/providers/user/user_card_provider.dart';
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
  Future<List<CreditCard>> listCreditCard;

  List<CreditCard> currentCardList;

  @override
  void initState() {
    super.initState();
    setState(() {
      listCreditCard = fetchCreditCards();
    });
  }

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
            bottomRight: Radius.circular(35),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Metodo de Pago',
          style: appBarStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
            future: listCreditCard,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                currentCardList = snapshot.data;
                nextButtonIsEnabled = true;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentCardList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < currentCardList.length) {
                      return _creditCardItem(
                          context,
                          index,
                          currentCardList[index].type,
                          currentCardList[index].number);
                    } else {
                      return Column(
                        children: [
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return CrearNuevaTarjeta();
                                  },
                                ),
                              ).then((value) => reloadCardList());
                            },
                            child: Text('+ Agregar Tarjeta'),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
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
                  } else {
                    print('===== BTN Siguiente Deshabilitado =====');
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
        onPressed: () {
          setState(() {
            groupRadio = index;
          });
        },
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
    String selectedCardId = currentCardList[groupRadio].id;
    Provider.of<UserCartState>(context, listen: false)
        .addUserCreditCardToBatch(selectedCardId);
  }

  void setCurrentBatchTotalAmount() {
    Provider.of<UserCartState>(context, listen: false)
        .setCurrentBatchTotalAmount();
  }

  void setCurrentBatchPaymentMethod() {
    Provider.of<UserCartState>(context, listen: false)
        .setCurrentBatchPaymentMethod();
  }

  void setCurrentBatchUserInfo() {
    UserTienditas userTienditas =
        Provider.of<LoginState>(context, listen: false).getTienditaUser();
    Provider.of<UserCartState>(context, listen: false)
        .setCurrentBatchUserInfo(userTienditas);
  }

  setCurrentBatchPhoneNumber() {
    UserTienditas userTienditas =
        Provider.of<LoginState>(context, listen: false).getTienditaUser();
    Provider.of<UserCartState>(context, listen: false)
        .setCurrentBatchPhoneNumber(userTienditas);
  }

  Future<List<CreditCard>> fetchCreditCards() {
    return UserCreditCardProvider().getUserCreditCards(
        context,
        Provider.of<LoginState>(
          context,
          listen: false,
        ).getFireBaseUser().email);
  }

  reloadCardList() async {
    setState(() {
      listCreditCard = fetchCreditCards();
    });
  }
}
