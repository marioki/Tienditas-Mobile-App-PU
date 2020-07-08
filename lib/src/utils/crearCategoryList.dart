import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/category_card_widget.dart';
import 'package:flutter/material.dart';

//Esta funcion crea una lista de CategoryCard Widgets de las categorias disponibles en la tienda, y los devuelve como un List<CategoryCard>
List<CategoryCard> getCategories() {
  return [
    CategoryCard(
      name: 'Tecnologia',
      image: Image(
        image: AssetImage('assets/images/tecnologia.png'),
      ),
      color: catTecnologia,
    ),
    CategoryCard(
      name: 'Moda',
      image: Image(
        image: AssetImage('assets/images/Shoes1.png'),
      ),
      color: catModa,
    ),
    CategoryCard(
      name: 'Deportes',
      image: Image(
        image: AssetImage('assets/images/Bicicleta_Deporte.png'),
      ),
      color: catDeportes,
    ),
    CategoryCard(
      name: 'Gastronomia',
      image: Image(
        image: AssetImage('assets/images/Ensalada_Comida.png'),
      ),
      color: catGastronomia,
    ),
    CategoryCard(
      name: 'Salud',
      image: Image(
        image: AssetImage('assets/images/Medicina_1.png'),
      ),
      color: catMedicina,
    ),
    CategoryCard(
      name: 'Mascotas',
      image: Image(
        image: AssetImage('assets/images/Perro_Hogar.png'),
      ),
      color: catMascotas,
    ),
  ];
}
