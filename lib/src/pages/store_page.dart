import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Name'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
                child: _getSearchBar(),
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(50, (index) {
                    return Card(
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(20),
                        child: Column(mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  child: Image(
                                    image: AssetImage('images/spotify.png'),
                                  ),
                                )
                              ],
                            ),
                            Text('Mancuernas'),
                            Text('Por Pedido'),
                            Text('\$50'),
                            FlatButton(
                              onPressed: () {},
                              child: Text('Al Carrito'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//  Widget _createAppBar() {
//    return SliverAppBar(
//        expandedHeight: 150.0,
//        flexibleSpace: const FlexibleSpaceBar(
//          title: Text('Available seats'),
//        ),
//        actions: <Widget>[
//          IconButton(
//            icon: const Icon(Icons.add_circle),
//            tooltip: 'Add new entry',
//            onPressed: () {
//              /* ... */
//            },
//          ),
//        ]);
//  }

  Widget _getSearchBar() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        hintText: ('Buscar productos'),
        labelText: 'Buscar productos',
        suffixIcon: Icon(Icons.search),
      ),
      onChanged: (valor) {
        setState(() {});
      },
    );
  }
}
