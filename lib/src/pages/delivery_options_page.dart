import 'package:app_tiendita/src/modelos/delivery_options_response.dart';
import 'package:app_tiendita/src/pages/escoger_direcciones_page.dart';
import 'package:app_tiendita/src/providers/store/store_delivery_options_provider.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/alert_dialogs/delivery_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryOptionsPage extends StatefulWidget {
  @override
  _DeliveryOptionsPageState createState() => _DeliveryOptionsPageState();
}

class _DeliveryOptionsPageState extends State<DeliveryOptionsPage> {
  Future<List<StoreDeliveryInfo>> listOfDeliveryOptions;

  @override
  void initState() {
    super.initState();
    setState(() {
      listOfDeliveryOptions = fetchDeliveryOptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool nextButtonIsEnabled = true;
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
          'Delivery',
          style: appBarStyle,
        ),
      ),
      body: FutureBuilder(
        //Todo el metodo de getStoreDeliveryOptions retorne una lista de listas
        future: listOfDeliveryOptions,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<StoreDeliveryInfo> listOfStores = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: listOfStores.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index < listOfStores.length) {
                          StoreDeliveryInfo deliveryInfo = listOfStores[index];

                          return InfoTile(
                            deliveryInfo: deliveryInfo,
                            index: index,
                            listOfStores: listOfStores,
                          );
                        } else {
                          return SizedBox(
                            height: 100,
                          );
                        }
                      }),
                ],
              ),
            );
          } else {
            return Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'COSTO DE ENV??O',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: grizSubtitulo,
                  ),
                ),
                Text(
                  '\$${getTotalDeliveryFee().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    color: azulTema,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton(
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
                    if (Provider.of<UserCartState>(context, listen:false)
                            .selectedDeliveryOptions
                            .length ==
                        Provider.of<UserCartState>(context, listen:false)
                            .filterParentStoreTagList()
                            .length) {
                      Provider.of<UserCartState>(context, listen:false).setDeliveryInfoList();

                      Provider.of<UserCartState>(context, listen:false)
                          .setDeliveryTotalCost(calculateTotalDeliveryFee());

                      Provider.of<UserCartState>(context, listen:false)
                          .calculateTotalAmountOfBatch();

                      Provider.of<UserCartState>(context, listen:false).generateOrderList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EscogerDirecciones(),
                        ),
                      );
                    } else
                      null;
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

  getDeliveryOptionsRadioGruop(StoreDeliveryInfo storeDeliveryInfo) {
    int radioGroup;
    return ListView.builder(
      itemCount: storeDeliveryInfo.deliveryOptions.length,
      itemBuilder: (context, index) {
        return FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              radioGroup = index + 1;
            });
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(storeDeliveryInfo.deliveryOptions[index].method),
                      Text(
                        storeDeliveryInfo.deliveryOptions[index].fee,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(storeDeliveryInfo.deliveryOptions[index].fee),
              ),
              Radio(
                groupValue: radioGroup,
                value: index + 1,
                activeColor: Colors.green,
                onChanged: (int value) {
                  print(value);
                  setState(() {
                    radioGroup = value;
                  });
                },
              ),
            ],
          ),
        );
      },
      shrinkWrap: true,
    );
  }

  Widget showSelectedOption() {
    return Text('Opcion Sleccionada');
  }

  double getTotalDeliveryFee() {
    double totalFee = 0;
    List<DeliveryOption> selectedOptions =
        Provider.of<UserCartState>(context).selectedDeliveryOptions;
    if (selectedOptions.isNotEmpty) {
      selectedOptions.forEach((element) {
        totalFee += double.parse(element.fee);
      });
    }

    return totalFee;
  }

  double calculateTotalDeliveryFee() {
    double totalFee = 0;
    List<DeliveryOption> selectedOptions =
        Provider.of<UserCartState>(context, listen: false).selectedDeliveryOptions;
    if (selectedOptions.isNotEmpty) {
      selectedOptions.forEach((element) {
        totalFee += double.parse(element.fee);
      });
    }

    return totalFee;
  }

  Future<List<StoreDeliveryInfo>> fetchDeliveryOptions() {
    return DeliveryOptionsProvider().getStoresDeliveryInfo(
        context,
        Provider.of<UserCartState>(context, listen: false)
            .filterParentStoreTagList());
  }
}

class InfoTile extends StatefulWidget {
  final listOfStores;
  final index;
  final deliveryInfo;

  InfoTile({
    Key key,
    this.listOfStores,
    this.index,
    this.deliveryInfo,
  }) : super(key: key);

  @override
  _InfoTileState createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  String displayText = 'Escoge el m??todo de entrega';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        var val = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return DeliveryAlertDialogWidget(
              listOfOptions: widget.listOfStores,
              index: widget.index,

            );
          },
        );
        setState(() {
          print('+++++++Seleccionaste: $val +++++++++');
          displayText = val == null ? 'Escoge el m??todo de entrega' : val;
          print(displayText);
        });
      },
      title: Text(widget.deliveryInfo.storeName),
      subtitle: Text(displayText),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
