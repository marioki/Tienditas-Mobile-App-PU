import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/category_card_widget.dart';
import 'package:flutter/material.dart';

//Esta funcion crea una lista de CategoryCard Widgets de las categorias disponibles en la tienda, y los devuelve como un List<CategoryCard>
List<CategoryCard> getCategories() {
  return [
    CategoryCard(
      name: 'Tecnologia',
      image: Image(
        image: AssetImage('assets/images/technology.png'),
      ),
      color: arcoAzul,
    ),
    CategoryCard(
      name: 'Moda',
      image: Image(
        image: AssetImage('assets/images/fashion.png'),
      ),
      color: arcoRojo,
    ),
    CategoryCard(
      name: 'Deportes',
      image: Image(
        image: AssetImage('assets/images/sports.png'),
      ),
      color: arcoAmarillo,
    ),
    CategoryCard(
      name: 'Gastronomia',
      image: Image(
        image: AssetImage('assets/images/food.png'),
      ),
      color: arcoVerde,
    ),
    CategoryCard(
      name: 'Salud',
      image: Image(
        image: AssetImage('assets/images/medical.png'),
      ),
      color: arcoLila,
    ),
    CategoryCard(
      name: 'Mascotas',
      image: Image(
        image: AssetImage('assets/images/pets.ico'),
      ),
      color: arcoNaranja,
    ),
  ];
}
