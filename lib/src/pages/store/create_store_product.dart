import 'dart:io';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/providers/product_items_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateStoreProduct extends StatefulWidget {
  CreateStoreProduct({@required this.storeTagName, this.productElement});

  final String storeTagName;
  final ProductElement productElement;

  @override
  _CreateStoreProductState createState() => _CreateStoreProductState();
}

class _CreateStoreProductState extends State<CreateStoreProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Agregar Producto',
          style: appBarStyle,
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: EditDeliveryOptionCard(storeTagName: widget.storeTagName),
      ),
    );
  }
}

// ignore: must_be_immutable
class EditDeliveryOptionCard extends StatefulWidget {
  EditDeliveryOptionCard({@required this.storeTagName});

  final String storeTagName;

  @override
  _EditDeliveryOptionCardState createState() => _EditDeliveryOptionCardState();
}

class _EditDeliveryOptionCardState extends State<EditDeliveryOptionCard> {
  ProductElement productElement;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  var response;

  String imageUrl = defaultProductImageURL;

  String basePrice;

  String finalPrice;

  String itemName;

  String quantity;

  Future<File> imageFile;

  File loadedImg;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(
              vertical: 8,
            ),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Image(
                          //   width: 50,
                          //   height: 50,
                          //   image: NetworkImage(
                          //       "$imageUrl"
                          //   ),
                          // ),
                          GestureDetector(
                            child: Image(
                                image: loadedImg == null
                                    ? AssetImage(
                                        "assets/images/tienditas_placeholder.png")
                                    : FileImage(loadedImg),
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain),
                            onTap: () {
                              return pickImageFromGallery(ImageSource.gallery);
                            },
                          ),
                          RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Procesando')));
                                response = await ProductProvider()
                                    .createProduct(
                                        Provider.of<LoginState>(context)
                                            .currentUserIdToken,
                                        itemName,
                                        finalPrice,
                                        basePrice,
                                        quantity,
                                        widget.storeTagName);
                                if (response.statusCode == 200) {
                                  ResponseTienditasApi responseTienditasApi =
                                      responseFromJson(response.body);
                                  if (responseTienditasApi.statusCode == 200) {
                                    print(responseTienditasApi.body.message);
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${responseTienditasApi.body.message}'),
                                      ),
                                    );
                                    isLoading = false;
                                    Navigator.of(context).pop();
                                  } else {
                                    print(responseTienditasApi.body.message);
                                    isLoading = false;
                                  }
                                }
                              }
                            },
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            textColor: Colors.white,
                            child: Text(
                              "Guardar",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Nunito"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Nombre del producto",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      TextFormField(
                        onChanged: (String value) {
                          itemName = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ingresar nombre del producto';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'nombre del producto'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Precio de venta",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          finalPrice = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ingresar precio de venta';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'precio de venta'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Costo",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          basePrice = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ingresar costo del producto';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white, hintText: 'costo'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Cantidad disponible",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          quantity = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ingresar cantidad disponible';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'cantidad disponible'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
              ),
            ),
          ),
        )
      ]),
    );
  }

  pickImageFromGallery(ImageSource source) {
    setState(() async {
      imageFile = ImagePicker.pickImage(source: source);
      loadImageFromGallery(await imageFile);
    });
  }

  void loadImageFromGallery(File imageFile) async {
    if (imageFile != null) {
      loadedImg = imageFile;
    }
    setState(() {});
  }
}
