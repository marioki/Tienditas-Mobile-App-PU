import 'package:app_tiendita/src/modelos/credit_card_result.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/providers/user/crear_tarjeta_provider.dart';
import 'package:app_tiendita/src/providers/user/user_card_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CrearNuevaTarjeta extends StatefulWidget {
  @override
  _CrearNuevaTarjetaState createState() => _CrearNuevaTarjetaState();
}

class _CrearNuevaTarjetaState extends State<CrearNuevaTarjeta> {
  var displayCardNumber = '';
  var cardNumber = '';
  var expiryDate = '';
  var cardHolderName = '';
  var cvvCode = '';
  var isCvvFocused = false;
  bool isLoading = false;
  List<CreditCard> listCreditCard = [];
  final _formKey = GlobalKey<FormState>();
  var response;
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(
        message: 'Cargando...',
        progressWidget: Container(
          height: 400,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
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
                    cardNumber: displayCardNumber,
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
                        await pr.show();
                        await sendNewCard(context);
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
      cardNumber =
          creditCardModel.cardNumber.replaceAll(new RegExp(r"\s+"), "");
      displayCardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future<void> sendNewCard(BuildContext context) async {
    pr = ProgressDialog(context);
    CreditCard newCard = CreditCard(
      holderName: cardHolderName,
      cvv: cvvCode,
      expirationDate: expiryDate,
      number: cardNumber,
    );

    //print(newCard.number);

    final tienditasUser = Provider.of<LoginState>(context, listen: false).getTienditaUser();
    final userTokenId = Provider.of<LoginState>(context, listen: false).currentUserIdToken;
    var response = await CreateNewCreditCard()
        .sendNewCreditCard(tienditasUser, userTokenId, newCard);
    if (response.statusCode == 200) {
      ResponseTienditasApi responseTienditasApi =
          responseFromJson(response.body);
      if (responseTienditasApi.statusCode == 200) {
        print(responseTienditasApi.body.message);
        isLoading = false;
        pr.hide();
        Navigator.of(context).pop();
        _showDialog(context, "Tarjeta Guardada");
      } else {
        print(responseTienditasApi.body.message);
        isLoading = false;
        pr.hide();
        Navigator.of(context).pop();
        _showDialog(context, "No se pudo guardar tarjeta");
      }
    }
  }

  _showDialog(BuildContext context, String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Listo"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
