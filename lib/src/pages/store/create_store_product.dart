import 'dart:convert';
import 'dart:io' as Io;

import 'package:app_tiendita/src/constants/api_constants.dart';
import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/providers/product_items_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/edit_product_image_element.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:progress_dialog/progress_dialog.dart';
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
  String finalPrice;
  String itemName;
  String description;
  String quantity;

  //Future<Io.File> imageFile;
  Future<dynamic> imageFile;
  Io.File loadedImg;
  var itemImage64;

  //Upload Multiple Images
  final int maxImageAmount = 3;
  List<Io.File> imageFileList = List();
  List<String> imageBase64List = List();

  //Delivery Time Picker fields
  int deliveryTimeNumber = 1;
  String deliveryRangeValue = 'dias';
  int step = 1;

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(message: 'Guardando...');

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
                      Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            imageFileList.length < maxImageAmount
                                ? GestureDetector(
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 50,
                                    ),
                                    onTap: () {
                                      return _pickImageFromGallery(
                                          ImageSource.gallery);
                                    },
                                  )
                                : Container(),
                            Expanded(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                addAutomaticKeepAlives: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: imageFileList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  if (imageFileList.isNotEmpty &&
                                      imageFileList[index] != null) {
                                    return ProductImgEdt(
                                      productImage:
                                          FileImage(imageFileList[index]),
                                      index: index,
                                      onDelete: () {
                                        deleteProductFromList(index);
                                      },
                                    );
                                  } else
                                    return Container();
                                },
                              ),
                            ),
                          ],
                        ),
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
                        "Descripción del producto",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      TextFormField(
                        onChanged: (String value) {
                          description = value;
                        },
                        maxLines: 5,
                        minLines: 1,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ingresar descripción del producto';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'breve descripción'),
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
                      Text(
                        "Tiempo De Entrega",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      _buildDeliveryTimeWidget(),
                      Divider(
                        color: Colors.black,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              pr.show();
                              generateBase64ImageList();
                              if (imageFileList.isNotEmpty) {
                                //Create product when image is loaded
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Procesando'),
                                  ),
                                );
                                response = await ProductProvider()
                                    .createProductWithImage(
                                  quantity: quantity,
                                  storeTagName: widget.storeTagName,
                                  finalPrice: finalPrice,
                                  itemImageUrlList: imageBase64List,
                                  description: description,
                                  itemName: itemName,
                                  deliveryTime: getDeliveryTimeInfo(),
                                  userIdToken: Provider.of<LoginState>(context)
                                      .currentUserIdToken,
                                );
                                if (response.statusCode == 200) {
                                  pr.hide();
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
                                    //aqui mensaje brujo
                                    print(responseTienditasApi.body.message);
                                    print(responseTienditasApi.statusCode);
                                    isLoading = false;
                                  }
                                }
                              } else {
                                //Create product when img is null
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Procesando')));
                                response =
                                    await ProductProvider().createProduct(
                                  quantity: quantity,
                                  storeTagName: widget.storeTagName,
                                  finalPrice: finalPrice,
                                  itemName: itemName,
                                  description: description,
                                  userIdToken: Provider.of<LoginState>(context)
                                      .currentUserIdToken,
                                );
                                if (response.statusCode == 200) {
                                  pr.hide();
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
                      ),
                    ]),
              ),
            ),
          ),
        )
      ]),
    );
  }

  pickImageFromGallery(ImageSource source) async {
    imageFile = ImagePicker.pickImage(
      source: source,
      imageQuality: 30,
    );
    loadImageFromGallery(await imageFile);

    setState(() {});
  }

  _pickImageFromGallery(ImageSource source) async {
    imageFile =
        ImagePicker.pickImage(source: source, maxHeight: 720, maxWidth: 1280);
    imageFileList.add(await imageFile);
    print(imageFileList.length);
    var _image = await imageFile;
    print('++++++++++++++++++++++++++++++++++++++');
    print(_image.lengthSync());
    setState(() {});
  }

  deleteProductFromList(int _index) {
    setState(() {
      imageFileList.removeAt(_index);
    });
  }

  generateBase64ImageList() {
    if (imageFileList.isNotEmpty) {
      imageFileList.forEach((imageFile) {
        String newImageString = encodeImage(imageFile);
        imageBase64List.add(newImageString);
      });
    }
    //setState(() {});
  }

  void loadImageFromGallery(Io.File imageFile) async {
    if (imageFile != null) {
      //loadedImg = imageFile;
      encodeImage(loadedImg);
    }
    setState(() {});
  }

  String encodeImage(Io.File image) {
    final bytes = image.readAsBytesSync();
    itemImage64 = base64Encode(bytes);
    return itemImage64;
  }

  String getDeliveryTimeInfo() {
    String deliveryTimeInfo =
        deliveryTimeNumber.toString() + ' ' + deliveryRangeValue;
    print(deliveryTimeInfo);
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
