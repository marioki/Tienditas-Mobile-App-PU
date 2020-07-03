import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/product_card.dart';
import 'package:app_tiendita/src/widgets/store_item_widget.dart';
import 'package:flutter/material.dart';

class StoreItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 16),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: rosadoClaro,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        enableFeedback: true,
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'My Loop Bands',
                            style: storeTitleCardStyle,
                          ),
                          Text(
                            '@myloopbans',
                            style: storeDetailsCardStyle,
                          ),
                          Text(
                            'Seguidores: 3,200',
                            style: storeDetailsCardStyle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        height: 100,
                        width: 100,
                        child: Image(
                          image: AssetImage('assets/images/spotify.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  childAspectRatio: 9/15,
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  crossAxisCount: 2,
                  children: _getStoreProducts(10) //_getStoreItems(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getStoreItems(int cantidad) {
    List<Widget> listaDeStoreItems = List();
    for (int i = 0; i < cantidad; i++) {
      final Widget itemCard = StoreItemCard(
        name: 'Bandas Élasticas',
        deliveryNow: 'Entrega Inmediata',
        price: 50,
        image: 'assets/images/spotify.png',
      );
      listaDeStoreItems.add(itemCard);
    }
    return listaDeStoreItems;
  }

  List<Widget> _getStoreProducts(int cantidad) {
    List<Widget> listaDeStoreItems = List();
    for (int i = 0; i < cantidad; i++) {
      final Widget itemCard = ProductItemCard();
      listaDeStoreItems.add(itemCard);
    }
    return listaDeStoreItems;
  }
}

//AppBar(
//flexibleSpace: Text('hello'),
//title: Text('Store Name here'),
//actions: <Widget>[
//Image(
//image: AssetImage('assets/images/spotify.png'),
//)
//],
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.only(
//bottomLeft: Radius.circular(40),
//bottomRight: Radius.circular(40),
//),
//),
//backgroundColor: rosadoClaro,
//bottom: PreferredSize(
//child: SizedBox(),
//preferredSize: Size(0, 50),
//),
//),

//Container(
//decoration: BoxDecoration(
//color: rosadoClaro,
//borderRadius: BorderRadius.only(
//bottomLeft: Radius.circular(40),
//bottomRight: Radius.circular(40),
//),
//),
//child: ListTile(
//leading: IconButton(
//enableFeedback: true,
//icon: Icon(Icons.keyboard_arrow_left),
//onPressed: () {},
//),
//title: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//Text(
//'My Loop Bands',
//style: storeTitleCardStyle,
//),
//Text(
//'@myloopbans',
//style: storeDetailsCardStyle,
//),
//Text(
//'Seguidores: 3,200',
//style: storeDetailsCardStyle,
//),
//],
//),
//trailing: Container(
//height: 100,
//width: 100,
//child: Image(
//image: AssetImage('assets/images/spotify.png'),
//),
//),
//),
//),
