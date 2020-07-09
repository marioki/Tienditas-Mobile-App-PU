import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

Color getCategoryColor(String categoryName) {
  return _categoryColors[categoryName];
}

final _categoryColors = <String, Color>{
  'tecnologia': mattBlack,
  'moda': mattBrown,
  'deportes': mattRed,
  'gastronomia': mattOrange,
  'salud': mattYellow,
  'mascotas': mattGreen,

//  'tecnologia': catTecnologia,
//  'moda': catModa,
//  'deportes': catDeportes,
//  'gastronomia': catGastronomia,
//  'salud': catMedicina,
//  'mascotas': catMascotas,

//  'tecnologia': arcoAzul,
//  'moda': arcoRojo,
//  'deportes': arcoAmarillo,
//  'gastronomia': arcoVerde,
//  'salud': arcoLila,
//  'mascotas': arcoNaranja,
};
