import 'package:app_tiendita/src/modelos/user/user_order_batch.dart';
import 'package:app_tiendita/src/pages/user/user_order_detail.dart';
import 'package:app_tiendita/src/providers/user/user_tienditas_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserBatchPage extends StatefulWidget {
  UserBatchPage({this.userEmail});

  final String userEmail;

  @override
  UserBatchPageState createState() => UserBatchPageState();
}

class UserBatchPageState extends State<UserBatchPage> {
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
          'Mis Ordenes',
          style: appBarStyle,
        ),
      ),
      body: FutureBuilder(
        future: UsuarioTienditasProvider().getUserOrders(
            Provider.of<LoginState>(context).currentUserIdToken,
            widget.userEmail),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            UserOrderBatchModel batchResult = snapshot.data;
            if (batchResult.body.batches.length > 0) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemCount: batchResult.body.batches.length,
                itemBuilder: (context, index) {
                  return UserOrderCard(
                    batch: batchResult.body.batches[index],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserOrderDetail(
                              batch: batchResult.body.batches[index]),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Container(
                height: 400,
                child: Center(child: Text("No hay ordenes registradas")),
              );
            }
          } else {
            return Container(
              height: 400,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

class UserOrderCard extends StatelessWidget {
  UserOrderCard({this.onPressed, this.batch});

  final Function onPressed;
  final Batch batch;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(top: 8, bottom: 8),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Orden #${batch.batchId.substring(1, 8)}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito"),
                    ),
                    Text(
                      "Total \$${batch.totalAmount}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Fecha: ${batch.batchDate}",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Nunito"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
