import 'package:app_tiendita/src/modelos/tiendita_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/color_from_hex.dart';
import 'package:flutter/material.dart';

class StoreCardWidget extends StatelessWidget {
  final String name;
  final String handle;
  final int followers;
  final String image;
  final String category;
  final String colorHex;
  final String description;
  final String originalStoreName;

  final String provinceName;

  const StoreCardWidget({
    Key key,
    @required this.name,
    @required this.handle,
    @required this.followers,
    @required this.image,
    @required this.category,
    @required this.colorHex,
    @required this.description,
    @required this.originalStoreName,
    @required this.provinceName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        //Navigator.pushNamed(context, 'place_holder_page');
        Navigator.pushNamed(
          context,
          'store_items_page',
          arguments: Store(
              storeName: name,
              categoryName: category,
              hexColor: colorHex,
              storeTagName: handle,
              iconUrl: image,
              description: description,
              originalStoreName: originalStoreName,
              provinceName: provinceName),
        );
      },
      //Todo: Cambiar el tamaño del widget usando MediaQuery
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(
          vertical: 8,
        ),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        color: getColorFromHex(colorHex),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Circle avatar
              Container(
                margin: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: size.height * .04,
                  child: ClipOval(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FadeInImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(image),
                            placeholder: AssetImage(
                                'assets/images/tienditas_placeholder.png'),
                          )),
                    ),
                  ),
                ),
              ),
              //Store Details Column
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        originalStoreName,
                        maxLines: 2,
                        style: storeTitleCardStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0),
                      Text(handle, style: storeDetailsCardStyle),
                      Text(
                        description,
                        maxLines: 2,
                        style: storeDetailsCardStyle,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
