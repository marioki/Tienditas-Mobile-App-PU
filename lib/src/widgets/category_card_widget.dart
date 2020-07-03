import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Image image;
  final String name;
  final Color color;

  const CategoryCard(
      {Key key,
      @required this.image,
      @required this.name,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              child: image,
            ),
            width: 75,
            height: 75,
            color: color,
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
    );
  }
}
