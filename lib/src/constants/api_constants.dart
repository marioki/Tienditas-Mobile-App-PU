import 'package:flutter/foundation.dart' as Foundation;

 const String productionUrl =
    'https://lnw0tmrts2.execute-api.us-east-1.amazonaws.com/prod';
const String developUrl =
    'https://8s27xrnoq8.execute-api.us-east-1.amazonaws.com/dev';


//URL Base Para todas las operaciones. Se cambia dependiando del build mode en el main
String baseApiUrl = 'https://8s27xrnoq8.execute-api.us-east-1.amazonaws.com/dev';

//URL Imagen Por defecto Cuando se crea un producto nuevo
 String defaultProductImageURL =
    "https://tienditas-dev-images.s3.amazonaws.com/products/inventory/default_producto.jpg";
