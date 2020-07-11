import 'dart:io';

import 'package:app_tiendita/src/maps/categories_map.dart';
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
    return Column(
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
                        AssetImage('assets/images/Huella_perro_Mascota.png'),
                  )),
              width: 75,
              height: 75,
              color: getColorFromHex(color)),
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

  Future<Image> getImageWithAuth() async {
    Image categoryIcon = await Image(
      image: NetworkImage(
        image,
        headers: {
          HttpHeaders.authorizationHeader:
              "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijc2MjNlMTBhMDQ1MTQwZjFjZmQ0YmUwNDY2Y2Y4MDM1MmI1OWY4MWUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGV2LXRpZW5kaXRhcyIsImF1ZCI6ImRldi10aWVuZGl0YXMiLCJhdXRoX3RpbWUiOjE1OTQ0MTc4NzMsInVzZXJfaWQiOiJxSDZZVE5tREtRZE9nQjdEMDZXeVAzeHVRR3cyIiwic3ViIjoicUg2WVRObURLUWRPZ0I3RDA2V3lQM3h1UUd3MiIsImlhdCI6MTU5NDQxNzg3MywiZXhwIjoxNTk0NDIxNDczLCJlbWFpbCI6Im1hcmlva2lydmVuLm1rQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJtYXJpb2tpcnZlbi5ta0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.SVaHjxU3JBdGj5--gimGvI21AY3d5IDbX6nd_j6JH7QwfxYUw2ZsujX4foeA-koru3zfTn21WLCixeOcIrswMH_qEME0tDeItec6Tn_as2ZSJOaigM0he89LTk7ed6Zzt8IjE65j4J8Cle6UEwoscYt8GZzTjTc6ESqHP2_jDhGM33nJRd0xO_a3YVA3YqfDU7qwVs7-jV_XiDdttiGtZ0lW-jArH_mZRPvydwOb4nzJRqrVI4KUIIqae45YrQd_j1baMIo36NayTS3_1sNyxy_qnM__yL6K2XJTQUyDg7SGnFzNHaPTushyBS33YweKQN8Wh7DnqOEcq_ZSrLFDDA"
        },
      ),
    );
  }
}
