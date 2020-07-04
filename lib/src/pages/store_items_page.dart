import 'package:app_tiendita/src/modelos/producto.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/product_card.dart';
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
                //margin: EdgeInsets.only(bottom: 16),
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: kDefaultPaddin,
                      mainAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 3 / 5,
                    ),
                    itemBuilder: (context, index) {
                      return ProductItemCard();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
