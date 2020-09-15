import 'package:app_tiendita/src/modelos/province_model.dart';
import 'package:app_tiendita/src/modelos/store/store_model.dart';
import 'package:app_tiendita/src/providers/province_provider.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';

class CreateStore extends StatefulWidget {
  @override
  _CreateStoreState createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  final _formKey = GlobalKey<FormState>();
  Store store;
  bool isLoading = false;
  List<String> _provinces = [
    'Bocas del Toro',
    'Coclé',
    'Colón',
    'Chiriquí',
    'Darién',
    'Herrera',
    'Los Santos',
    'Panamá',
    'Veraguas',
    'Panamá Oeste'
  ];
  String _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          '¿Cuál es tu tienda?',
          style: appBarStyle,
        ),
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
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
                                Text(
                                  "Nombre de la tienda",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (String value) {
                                    store.originalStoreName = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Ingresar nombre de la tienda';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: 'Mi Tienda'
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Tag de su tienda",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Nunito"
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (String value) {
                                    store.storeTagName = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Ingresar tag de su tienda';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: '@miTienda'
                                  ),
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
                                      fontFamily: "Nunito"
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (String value) {
                                    print(value);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Ingresar categoría de la tienda';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: 'categoría'
                                  ),
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
                                      fontFamily: "Nunito"
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (String value) {
                                    print(value);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Ingresar descripción';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: 'una breve descripción y puede incluir emojies'
                                  ),
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
                                      fontFamily: "Nunito"
                                  ),
                                ),
                                FutureBuilder(
                                  future: ProvinceProvider().getAllProvinces(context),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      ProvinceModel resultProvince = snapshot.data;
                                      var provinces = resultProvince.body.province.provinces;
                                      return DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint:  Text("Seleccionar ubicación"),
                                          value: _selectedLocation,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedLocation = newValue;
                                            });
                                            print(newValue);
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
                                          hint:  Text("Seleccionar ubicación"),
                                          value: _selectedLocation,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedLocation = newValue;
                                            });
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
                                      fontFamily: "Nunito"
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (String value) {
                                    print(value);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Ingresar teléfono';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: '6123-4567'
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment(0.0, 0.0),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Procesando...')));
                                        // editDeliveryOption
                                        /*if(id != null) {
                                    response = await StoreProvider().editDeliveryOption(
                                        Provider.of<LoginState>(context).currentUserIdToken,
                                        storeTagName,
                                        id,
                                        name,
                                        method,
                                        fee
                                    );
                                  } else {
                                    response = await StoreProvider().newDeliveryOption(
                                        Provider.of<LoginState>(context).currentUserIdToken,
                                        storeTagName,
                                        name,
                                        method,
                                        fee
                                    );
                                  }
                                  if (response.statusCode == 200) {
                                    ResponseTienditasApi responseTienditasApi = responseFromJson(response.body);
                                    if (responseTienditasApi.statusCode == 200) {
                                      print(responseTienditasApi.body.message);
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${responseTienditasApi.body.message}'
                                          ),
                                        ),
                                      );
                                      isLoading = false;
                                      Navigator.of(context).pop();
                                    } else {
                                      print(responseTienditasApi.body.message);
                                      isLoading = false;
                                    }
                                  }*/
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
                                          fontFamily: "Nunito"
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          )
      ),
    );
  }
}
