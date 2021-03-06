import 'dart:convert';

import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/modelos/province_model.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/store/store_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/providers/category_provider.dart';
import 'package:app_tiendita/src/providers/province_provider.dart';
import 'package:app_tiendita/src/providers/store/store_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'dart:io' as Io;

class EditStore extends StatefulWidget {
  EditStore({this.store});

  final Store store;

  @override
  _EditStoreState createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var response;
  List<String> _provinces = [
    'Hubo problemas de conexión, \nfavor revisar su conexión a internet'
  ];
  List<String> _categories = [
    'Hubo problemas de conexión, \nfavor revisar su conexión a internet'
  ];

  Future<Io.File> imageFile;
  Io.File loadedImg;
  var itemImage64;

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(message: 'Guardando...');
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
          'Edita tu Tienda',
          style: appBarStyle,
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: SingleChildScrollView(
                child:
                    Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 15),
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
                                Align(
                                  child: GestureDetector(
                                    onTap: () {
                                      return pickImageFromGallery(
                                          ImageSource.gallery);
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
                                                "${widget.store.iconUrl}")
                                            : FileImage(loadedImg),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Nombre de la tienda",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                                TextFormField(
                                  initialValue: widget.store.storeName,
                                  onChanged: (String value) {
                                    widget.store.storeName = value;
                                    print(widget.store.storeName);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Ingresar nombre de la tienda';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: 'Mi Tienda'),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Categoría",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                                FutureBuilder(
                                  future: CategoriesProvider()
                                      .getAllCategories(context),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      CategoryResponseModel resultcategories =
                                          snapshot.data;
                                      var categories =
                                          resultcategories.body.categoryList;
                                      _categories = [];
                                      for (var i = 0;
                                          i < categories.length;
                                          i++) {
                                        _categories
                                            .add(categories[i].categoryName);
                                      }
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text("Seleccionar categoría"),
                                          value: widget.store.categoryName,
                                          onChanged: (newValue) {
                                            setState(() {
                                              widget.store.categoryName =
                                                  newValue;
                                            });
                                          },
                                          items: _categories.map((value) {
                                            return new DropdownMenuItem(
                                              child: new Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    } else {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text("Seleccionar categoría"),
                                          onChanged: (newValue) {
                                            print(newValue);
                                          },
                                          items: _categories.map((value) {
                                            return new DropdownMenuItem(
                                              child: new Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Descripción",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  initialValue: widget.store.description,
                                  onChanged: (String value) {
                                    widget.store.description = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Ingresar descripción';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText:
                                          'una breve descripción y puede incluir emojies'),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Ubicación",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                                FutureBuilder(
                                  future: ProvinceProvider()
                                      .getAllProvinces(context),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      ProvinceModel resultProvince =
                                          snapshot.data;
                                      var provinces = resultProvince
                                          .body.province.provinces;
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text("Seleccionar ubicación"),
                                          value: widget.store.provinceName,
                                          onChanged: (newValue) {
                                            setState(() {
                                              widget.store.provinceName =
                                                  newValue;
                                            });
                                          },
                                          items: provinces.map((value) {
                                            return new DropdownMenuItem(
                                              child: new Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    } else {
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text("Seleccionar ubicación"),
                                          onChanged: (newValue) {
                                            print(newValue);
                                          },
                                          items: _provinces.map((value) {
                                            return new DropdownMenuItem(
                                              child: new Text(value),
                                              value: value,
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Teléfono de contacto",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  initialValue: widget.store.phoneNumber,
                                  onChanged: (String value) {
                                    widget.store.phoneNumber = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Ingresar teléfono';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: '6123-4567'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment(0.0, 0.0),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      pr.show();
                                      if (_formKey.currentState.validate()) {
                                        if (widget.store.categoryName != null &&
                                            widget.store.provinceName != null) {
                                          if (itemImage64 != null) {
                                            response = await StoreProvider()
                                                .updateStoreWithImage(
                                              Provider.of<LoginState>(context,listen: false)
                                                  .currentUserIdToken,
                                              widget.store.storeTagName,
                                              widget.store.storeName,
                                              widget.store.provinceName,
                                              widget.store.categoryName,
                                              widget.store.description,
                                              widget.store.phoneNumber,
                                              itemImage64,
                                            );
                                          } else {
                                            response = await StoreProvider()
                                                .updateStore(
                                                    Provider.of<LoginState>(
                                                        context, listen: false)
                                                        .currentUserIdToken,
                                                    widget.store.storeTagName,
                                                    widget.store.storeName,
                                                    widget.store.provinceName,
                                                    widget.store.categoryName,
                                                    widget.store.description,
                                                    widget.store.phoneNumber);
                                          }
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Debe seleccionar provincia y categoría'),
                                            ),
                                          );
                                        }
                                        if (response.statusCode == 200) {
                                          ResponseTienditasApi
                                              responseTienditasApi =
                                              responseFromJson(response.body);
                                          if (responseTienditasApi.statusCode ==
                                              200) {
                                            //Clear Image Cahe
                                            PaintingBinding.instance.imageCache
                                                .clear();
                                            print(responseTienditasApi
                                                .body.message);
                                            isLoading = false;

                                            Navigator.of(context).pop();
                                          } else {
                                            print(responseTienditasApi
                                                .body.message);
                                            isLoading = false;
                                          }
                                          pr.hide();
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Hubo problemas al editar la tienda, \nfavor revisar su conexión a internet'),
                                            ),
                                          );
                                          pr.hide();
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
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ]),
              ));
        },
      ),
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
}
