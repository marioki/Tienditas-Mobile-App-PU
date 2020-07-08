import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

final _categoryColors = <String, Color>{
  'tecnologia': catTecnologia,
  'moda': catModa,
  'deportes': catDeportes,
  'gastronomia': catGastronomia,
  'salud': catMedicina,
  'mascotas': catMascotas,




//  'tecnologia': arcoAzul,
//  'moda': arcoRojo,
//  'deportes': arcoAmarillo,
//  'gastronomia': arcoVerde,
//  'salud': arcoLila,
//  'mascotas': arcoNaranja,
};


Color getCategoryColor(String categoryName) {
  return _categoryColors[categoryName];
}