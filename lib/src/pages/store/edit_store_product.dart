import 'dart:convert';
import 'dart:io' as Io;

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

  //Update Product Images with images array
  List<String> selectedImagesUrls = List();

  //List<ProductImgEdt> imageWidgetList = List();

  //Upload Multiple Images
  final int maxImageAmount = 3;
  List<Io.File> imageFileList = List();
  List<String> imageBase64List = List();

  int sumImage = 0;

  @override
  void initState() {
    super.initState();
    List<String> spliteDeliveryTime = widget.productElement.deliveryTime.split(" ");
    deliveryTimeNumber = int.parse(spliteDeliveryTime.first);
    deliveryRangeValue = spliteDeliveryTime.last;
  }
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
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              getAddImageButton(),

                              Flexible(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget
                                      .productElement.imagesUrlList.length,
                                  itemBuilder: (context, index) {
                                    var currentImg = widget
                                        .productElement.imagesUrlList[index];
                                    return ProductImgEdt(
                                      productImage: NetworkImage(currentImg),
                                      index: (index),
                                      onDelete: () =>
                                          deleteNetworkImage(currentImg, index),
                                    );
                                  },
                                ),
                                // child: ListView(
                                //   shrinkWrap: true,
                                //   scrollDirection: Axis.horizontal,
                                //   children: imageWidgetList,
                                // ),
                              ),
                              ListView.builder(
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
                                      onDelete: () =>
                                          deleteProductFromList(index),
                                    );
                                  } else
                                    return Container();
                                },
                              ),
                              // child: ListView.builder(
                              //   physics: BouncingScrollPhysics(),
                              //   scrollDirection: Axis.horizontal,
                              //   itemCount: widget
                              //       .productElement.imagesUrlList.length,
                              //   shrinkWrap: true,
                              //   itemBuilder:
                              //       (BuildContext context, int index) {
                              //     if (widget.productElement.imagesUrlList
                              //             .isNotEmpty &&
                              //         widget.productElement
                              //                 .imagesUrlList[index] !=
                              //             null) {
                              //       return ProductImgEdt(
                              //           productImage: NetworkImage(widget
                              //               .productElement
                              //               .imagesUrlList[index]),
                              //           index: index,
                              //           onDelete: () {
                              //             deleteNetworkImage(
                              //                 widget.productElement
                              //                     .imagesUrlList[index],
                              //                 index);
                              //           });
                              //     } else
                              //       return Container();
                              //   },
                              // ),
                            ],
                          )),
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
                        "Descripción del producto",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      TextFormField(
                        initialValue: widget.productElement.description,
                        onChanged: (String value) {
                          widget.productElement.description = value;
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
                        initialValue: widget.productElement.finalPrice,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                        "Precio con descuento",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito"),
                      ),
                      TextFormField(
                        initialValue: widget.productElement.discountPrice,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        onChanged: (String value) {
                          widget.productElement.discountPrice = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ingresar precio con descuento';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'precio con descuento'),
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
                      _buildDeliveryTimeWidget(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              pr.show();
                              if (selectedImagesUrls.isNotEmpty) {
                                generateBase64ImageList();
                                if (widget.productElement.imagesUrlList
                                        .isNotEmpty ||
                                    imageFileList.isNotEmpty) {
                                  //Update product when image is loaded
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Procesando')));
                                  response = await ProductProvider()
                                      .updateProductDeleteAndAdd(
                                    userIdToken:
                                        Provider.of<LoginState>(context)
                                            .currentUserIdToken,
                                    productElement: widget.productElement,
                                    itemImageBase64List: imageBase64List,
                                    deliveryTime: getDeliveryTimeInfo(),
                                    imagesUrl: selectedImagesUrls,
                                  );
                                  if (response.statusCode == 200) {
                                    pr.hide();
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
                                }
                              } else {
                                generateBase64ImageList();
                                if (widget.productElement.imagesUrlList
                                        .isNotEmpty ||
                                    imageFileList.isNotEmpty) {
                                  //Update product when image is loaded
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Procesando')));
                                  response =
                                      await ProductProvider().updateProductAdd(
                                    userIdToken:
                                        Provider.of<LoginState>(context)
                                            .currentUserIdToken,
                                    productElement: widget.productElement,
                                    itemImageBase64List: imageBase64List,
                                    deliveryTime: getDeliveryTimeInfo(),
                                    imagesUrl: selectedImagesUrls,
                                  );
                                  if (response.statusCode == 200) {
                                    pr.hide();
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

  _pickImageFromGallery(ImageSource source) async {
    imageFile = ImagePicker.pickImage(source: source, maxWidth: 1280, maxHeight: 720);
    if (imageFile != null) {
      imageFileList.add(await imageFile);
      print(imageFileList.length);
      setState(() {});
    }
  }

  void generateBase64ImageList() async {
    if (imageFileList.isNotEmpty) {
      imageFileList.forEach((imageFile) {
        imageBase64List.add(_encodeImage(imageFile));
      });
    }
    //setState(() {});
  }

  String _encodeImage(Io.File image) {
    final bytes = image.readAsBytesSync();
    itemImage64 = base64Encode(bytes);
    return itemImage64;
  }

  deleteNetworkImage(String imageUrl, int _index) {
    if (widget.productElement.imagesUrlList.isNotEmpty) {
      print('++++++++Image to be Deleted++++++++++');
      print(_index);
      selectedImagesUrls.add(widget.productElement.imagesUrlList[_index]);
      print(selectedImagesUrls);
      setState(() {
        widget.productElement.imagesUrlList
            .removeWhere((element) => element == imageUrl);
        print('SETSTATE IS CALLED');
      });
    }
  }

  deleteProductFromList(int _index) {
    setState(() {
      imageFileList.removeAt(_index);
    });
  }

  Widget getAddImageButton() {
    if (widget.productElement.imagesUrlList.length + imageFileList.length <
        maxImageAmount) {
      int imageCount =
          widget.productElement.imagesUrlList.length + imageFileList.length;
      print(imageCount);
      return GestureDetector(
        child: Icon(
          Icons.add_a_photo_outlined,
          size: 50,
        ),
        onTap: () {
          setState(() {
            _pickImageFromGallery(ImageSource.gallery);
          });
        },
      );
    } else {
      int imageCount =
          widget.productElement.imagesUrlList.length + imageFileList.length;
      print(imageCount.toString() + '===============');
      return Container();
    }
  }
}
