import 'package:app_tiendita/src/modelos/credit_card_result.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/providers/user/crear_tarjeta_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrearNuevaTarjeta extends StatefulWidget {
  @override
  _CrearNuevaTarjetaState createState() => _CrearNuevaTarjetaState();
}

class _CrearNuevaTarjetaState extends State<CrearNuevaTarjeta> {
  var cardNumber = '';
  var expiryDate = '';
  var cardHolderName = '';
  var cvvCode = '';
  var isCvvFocused = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grisClaroTema,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
        ),
        centerTitle: true,
        backgroundColor: azulTema,
        title: Text(
          'Agregar Tarjeta',
          style: appBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused, //
                    // true when you want to show cvv(back) view
                  ),
                  CreditCardForm(
                    themeColor: azulTema,
                    onCreditCardModelChange: (CreditCardModel data) {
                      onCreditCardModelChange(data);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Guardar',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (!isLoading) {
                        setState(() {
                          isLoading = true;
                        });
                        await sendNewCard();
                      }
                    },
                    color: azulTema,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future<void> sendNewCard() async {
    CreditCard newCard = CreditCard(
      holderName: cardHolderName,
      cvv: cvvCode,
      expirationDate: expiryDate,
      number: cardNumber,
    );
    final firebaseUser = Provider.of<LoginState>(context).getFireBaseUser();
    final userTokenId = Provider.of<LoginState>(context).currentUserIdToken;
    var response = await CreateNewCreditCard()
        .sendNewCreditCard(firebaseUser, userTokenId, newCard);
    if (response.statusCode == 200) {
      ResponseTienditasApi responseTienditasApi =
          responseFromJson(response.body);
      if (responseTienditasApi.statusCode == 200) {
        print(responseTienditasApi.body.message);
        isLoading = false;
        Navigator.of(context).pop();
      } else {
        print(responseTienditasApi.body.message);
        isLoading = false;
      }
    }
  }
}
