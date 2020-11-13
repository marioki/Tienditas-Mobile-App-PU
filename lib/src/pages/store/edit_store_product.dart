import 'dart:io' as Io;
import 'dart:convert';

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/providers/product_items_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class EditStoreInventory extends StatefulWidget {
  EditStoreInventory({@required this.storeTagName, this.productElement});

  final String storeTagName;
  final ProductElement productElement;

  @override
  _EditStoreInventoryState createState() => _EditStoreInventoryState();
}

class _EditStoreInventoryState extends State<EditStoreInventory> {
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
          'Editar Producto',
          style: appBarStyle,
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: EditDeliveryOptionCard(
          storeTagName: widget.storeTagName,
          productElement: widget.productElement,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EditDeliveryOptionCard extends StatefulWidget {
  EditDeliveryOptionCard({@required this.storeTagName, this.productElement});

  final String storeTagName;
  final ProductElement productElement;

  @override
  _EditDeliveryOptionCardState createState() => _EditDeliveryOptionCardState();
}

class _EditDeliveryOptionCardState extends State<EditDeliveryOptionCard> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  var response;

  Future<Io.File> imageFile;

  Io.File loadedImg;

  var itemImage64;

  //Delivery Time Picker fields
  int deliveryTimeNumber = 1;
  String deliveryRangeValue = 'dias';
  int step = 1;

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
                          GestureDetector(
                            onTap: () {
                              return pickImageFromGallery(ImageSource.gallery);
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image(
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                                image: loadedImg == null
                                    ? NetworkImage(
                                        "${widget.productElement.imageUrl}")
                                    : FileImage(loadedImg),
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                if (loadedImg != null) {
                                  //Update product when image is loaded
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Procesando')));
                                  response = await ProductProvider()
                                      .updateProductWithImage(
                                    userIdToken:
                                        Provider.of<LoginState>(context)
                                            .currentUserIdToken,
                                    productElement: widget.productElement,
                                    itemImage: itemImage64,
                                    deliveryTime: getDeliveryTimeInfo(),
                                  );
                                  if (response.statusCode == 200) {
                                    ResponseTienditasApi responseTienditasApi =
                                        responseFromJson(response.body);
                                    if (responseTienditasApi.statusCode ==
                                        200) {
                                      print(responseTienditasApi.body.message);
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${responseTienditasApi.body.message}'),
                                        ),
                                      );
                                      //Clear Image Cahe
                                      PaintingBinding.instance.imageCache
                                          .clear();
                                      isLoading = false;
                                      Navigator.of(context).pop();
                                    } else {
                                      print(responseTienditasApi.body.message);
                                      isLoading = false;
                                    }
                                  }
                                } else {
                                  //Update product when image is null
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Procesando')));
                                  response =
                                      await ProductProvider().updateProduct(
                                    userIdToken:
                                        Provider.of<LoginState>(context)
                                            .currentUserIdToken,
                                    productElement: widget.productElement,
                                        deliveryTime: getDeliveryTimeInfo(),

                                      );
                                  if (response.statusCode == 200) {
                                    ResponseTienditasApi responseTienditasApi =
                                        responseFromJson(response.body);
                                    if (responseTienditasApi.statusCode ==
                                        200) {
                                      print(responseTienditasApi.body.message);
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${responseTienditasApi.body.message}'),
                                        ),
                                      );
                                      isLoading = false;
                                      var count = 0;
                                      Navigator.popUntil(context, (route) {
                                        return count++ == 2;
                                      });
                                    } else {
                                      print(responseTienditasApi.body.message);
                                      isLoading = false;
                                    }
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
                        initialValue: widget.productElement.itemName,
                        onChanged: (String value) {
                          widget.productElement.itemName = value;
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
                        initialValue: widget.productElement.finalPrice,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          widget.productElement.finalPrice = value;
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
                        initialValue: widget.productElement.basePrice,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          widget.productElement.basePrice = value;
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
                        initialValue: widget.productElement.quantity,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          widget.productElement.quantity = value;
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
                      _buildDeliveryTimeWidget()
                    ]),
              ),
            ),
          ),
        )
      ]),
    );
  }

  pickImageFromGallery(ImageSource source) async {
    imageFile = ImagePicker.pickImage(source: source);
    loadImageFromGallery(await imageFile);
    setState(() {});
  }

  void loadImageFromGallery(Io.File imageFile) async {
    if (imageFile != null) {
      loadedImg = imageFile;
      encodeImage(imageFile);
    }
    setState(() {});
  }

  void encodeImage(Io.File image) async {
    final bytes = image.readAsBytesSync();
    itemImage64 = base64Encode(bytes);
    print(itemImage64);
  }

  String getDeliveryTimeInfo() {
    String deliveryTimeInfo =
        deliveryTimeNumber.toString() + ' ' + deliveryRangeValue;
    print(deliveryTimeInfo);
    print('========================================');
    return deliveryTimeInfo;
  }

  _buildDeliveryTimeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        NumberPicker.integer(
          initialValue: deliveryTimeNumber,
          minValue: 1,
          maxValue: 30,
          highlightSelectedValue: true,
          step: step,
          onChanged: (num value) {
            setState(() {
              deliveryTimeNumber = value;
            });
          },
        ),
        Text('X'),
        DropdownButton(
          items: [
            DropdownMenuItem(
              child: Text('Dias'),
              value: 'dias',
            ),
            DropdownMenuItem(
              child: Text('Semanas'),
              value: 'semanas',
            ),
            DropdownMenuItem(
              child: Text('Meses'),
              value: 'meses',
            ),
          ],
          value: deliveryRangeValue,
          onChanged: (value) {
            setState(() {
              deliveryRangeValue = value;
              print(deliveryRangeValue);
            });
          },
        ),
      ],
    );
  }
}
