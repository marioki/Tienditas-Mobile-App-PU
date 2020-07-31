import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/color_from_hex.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String name;
  final String color;

  const CategoryCard(
      {Key key, @required this.image, @required this.name, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.pushNamed(context, 'stores_by_category',
            arguments: CategoryElement(
                categoryName: name, hexColor: color, iconUrl: image));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: FadeInImage(
                    image: NetworkImage(
                      image,
                    ),
                    placeholder:
                        AssetImage('assets/images/tienditas_placeholder.png'),
                  )),
              width: 75,
              height: 75,
              color: getColorFromHex(color),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              name,
              style: storeCategoryStyle,
            ),
          ),
        ],
      ),
    );
  }
}
