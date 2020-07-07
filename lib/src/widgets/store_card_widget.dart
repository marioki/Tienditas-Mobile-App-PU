import 'package:app_tiendita/src/maps/categories_map.dart';
import 'package:app_tiendita/src/modelos/store_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class StoreCardWidget extends StatelessWidget {
  final String name;
  final String handle;
  final int followers;
  final String image;
  final String category;

  const StoreCardWidget(
      {Key key,
      @required this.name,
      @required this.handle,
      @required this.followers,
      @required this.image,
      this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.pushNamed(
          context,
          'store_items_page',
          arguments: Tienda(
            name: name,
            handle: handle,
            followers: followers,
            category: category,
            image: image,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 8,
        ),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        color: getCategoryColor(category),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          fit: BoxFit.contain,
                          image: NetworkImage(image),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name, style: storeTitleCardStyle),
                    SizedBox(height: 10),
                    Text(handle, style: storeDetailsCardStyle),
                    Text('Seguidores: ' + followers.toString(),
                        style: storeDetailsCardStyle),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
