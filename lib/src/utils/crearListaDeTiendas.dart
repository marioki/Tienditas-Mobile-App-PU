import 'package:app_tiendita/src/widgets/store_card_widget.dart';
import 'package:flutter/material.dart';

List<Widget> getStoreList() {
  return [
    StoreCardWidget(
      name: 'MakeupLove Store',
      handle: '@makeuplove.store',
      followers: 3200,
      image: 'https://static.rfstat.com/renderforest/images/v2/logo-homepage'
          '/flat_3.png',
      category: 'moda',
    ),
    StoreCardWidget(
      name: 'My Veggies',
      handle: '@veggiesstore',
      followers: 3200,
      image:
          'https://images-platform.99static.com//KqmCySklj6opxlEx-rTDR64qz0Y=/11'
          '9x100:880x861/fit-in/590x590/99designs-contests-attachments/76/76'
          '534/attachment_76534862',
      category: 'gastronomia',
    ),
    StoreCardWidget(
      name: 'Sports',
      handle: '@sports.store',
      followers: 3200,
      image:
          'https://logos-marcas.com/wp-content/uploads/2020/04/Nike-Logo.png',
      category: 'deportes',
    ),
    StoreCardWidget(
      name: 'Ropa Tamos Kros',
      handle: '@tamos.kros',
      followers: 320000,
      image:
          'https://es.freelogodesign.org/Content/img/logo-samples/bobbygrill.png',
      category: 'moda',
    ),
    StoreCardWidget(
      name: 'Impesiones leon',
      handle: '@impresiones_leon',
      followers: 3200,
      image:
          'https://i.pinimg.com/originals/33/b8/69/33b869f90619e81763dbf1fccc896d8d.jpg',
      category: 'tecnologia',
    ),
    StoreCardWidget(
      name: 'jugosRicos',
      handle: '@jugos.ricos',
      followers: 3200,
      image:
          'https://www.tailorbrands.com/wp-content/uploads/2019/09/Juicy-logo-100-1-300x300.jpg',
      category: 'gastronomia',
    ),
  ];
}
