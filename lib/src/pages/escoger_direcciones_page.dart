import 'package:app_tiendita/src/modelos/batch_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/pages/metodo_de_pago.dart';
import 'package:app_tiendita/src/pages/user/create_user_address.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/state_providers/user_cart_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EscogerDirecciones extends StatefulWidget {
  @override
  _EscogerDireccionesState createState() => _EscogerDireccionesState();
}

class _EscogerDireccionesState extends State<EscogerDirecciones> {
  int groupRadio = 0;

  @override
  Widget build(BuildContext context) {
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
          'Dirección',
          style: appBarStyle,
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 50,
              ),
            ),
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
                  setUserAddres();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MetodoDePago();
                  }));
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
      body: Container(
          margin: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: Provider.of<LoginState>(context,listen: true)
                    .getTienditaUser()
                    .address
                    .length +
                1,
            itemBuilder: (context, index) {
              if (index <
                  Provider.of<LoginState>(context,listen: false)
                      .getTienditaUser()
                      .address
                      .length) {
                UserTienditas user = Provider.of<LoginState>(context,listen: false).getTienditaUser();
                return _getDireccionCard(
                    context,
                    index,
                    user.address[index].name,
                    user.address[index].referencePoint);
              } else {
                return FlatButton(
                  onPressed: () {
                    UserTienditas user =
                        Provider.of<LoginState>(context, listen:false).getTienditaUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CreateUserAddress(
                            userEmail: user.userEmail,
                          );
                        },
                      ),
                    ).then((value) =>
                        Provider.of<LoginState>(context, listen:false).reloadUserInfo());
                  },
                  child: Text('+ Agregar Dirección'),
                );
              }
            },
          )),
    );
  }

  _getDireccionCard(
      BuildContext context, int index, String title, String subtitle) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: FlatButton(
        onPressed: () {
          setState(() {
            groupRadio = index;
            print(groupRadio);
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

  void setUserAddres() {
    Address address =
        Provider.of<LoginState>(context, listen:false).getTienditaUser().address[groupRadio];

    UserAddress userAddress = UserAddress(
        addressLine1: address.addressLine1,
        country: address.country,
        phoneNumber: address.phoneNumber,
        province: address.province,
        referencePoint: address.referencePoint,
        latitude: address.latitude,
        longitude: address.longitude);

    Provider.of<UserCartState>(context, listen:false).setUserAddressToOrders(userAddress);
  }
}
