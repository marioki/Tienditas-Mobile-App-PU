import 'dart:collection';

import 'package:app_tiendita/src/modelos/province_model.dart';
import 'package:app_tiendita/src/modelos/response_model.dart';
import 'package:app_tiendita/src/modelos/usuario_tienditas.dart';
import 'package:app_tiendita/src/pages/location_map_page.dart';
import 'package:app_tiendita/src/providers/province_provider.dart';
import 'package:app_tiendita/src/providers/user/user_tienditas_provider.dart';
import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditUserAddress extends StatefulWidget {
  EditUserAddress(
      {@required this.appBarTitle,
      @required this.userEmail,
      this.name,
      this.province,
      this.addressLine,
      this.referencePoint,
      @required this.method,
      this.id,
      this.latitude,
      this.longitude});

  final String appBarTitle;
  final String userEmail;
  String province;
  String name;
  String addressLine;
  String referencePoint;
  final String method;
  String id;
  String latitude;
  String longitude;

  @override
  _EditUserAddressState createState() => _EditUserAddressState();
}

class _EditUserAddressState extends State<EditUserAddress> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var response;
  List<String> _provinces = [
    'Hubo problemas de conexión, \nfavor revisar su conexión a internet'
  ];

  LatLng userPickedLocation;
  LatLng cameraLocation = LatLng(8.986129, -79.524499);
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;

  void reloadMap(LatLng pickedLocation) {
    setState(() {
      widget.latitude = pickedLocation.latitude.toString();
      widget.longitude = pickedLocation.longitude.toString();
      updateMarker(pickedLocation);
      CameraUpdate cameraUpdate = CameraUpdate.newLatLng(pickedLocation);
      _mapController.moveCamera(cameraUpdate);
    });
  }

  void updateMarker(LatLng location) {
    setState(() {
      _markers.removeWhere((element) => element.markerId.value == '0');
      _markers.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(location.latitude, location.longitude)
        ),
      );
    });
  }

  void initMap(LatLng addressLocation) {
    setState(() {
      cameraLocation = addressLocation;
      widget.latitude = addressLocation.latitude.toString();
      widget.longitude = addressLocation.longitude.toString();
      updateMarker(addressLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(message: 'Guardando...');
    if (widget.latitude != null && widget.longitude != null) {
      initMap(LatLng(double.parse(widget.latitude), double.parse(widget.longitude)));
    }
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
          '${widget.appBarTitle}',
          style: appBarStyle,
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Nombre",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                        ),
                        TextFormField(
                          initialValue: widget.name,
                          onChanged: (String value) {
                            widget.name = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresar nombre de la dirección';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white, hintText: 'nombre'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Dirección",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                        ),
                        TextFormField(
                          initialValue: widget.addressLine,
                          onChanged: (String value) {
                            widget.addressLine = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresar calle de la dirección';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white, hintText: 'dirección'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Punto de Referencia",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                        ),
                        TextFormField(
                          initialValue: widget.referencePoint,
                          onChanged: (String value) {
                            widget.referencePoint = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresar punto de referencia';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: 'punto de referencia'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Provincia",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                        ),
                        FutureBuilder(
                          future: ProvinceProvider().getAllProvinces(context),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              ProvinceModel resultProvince = snapshot.data;
                              var provinces =
                                  resultProvince.body.province.provinces;
                              return DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text("Seleccionar ubicación"),
                                  value: widget.province,
                                  onChanged: (newValue) {
                                    setState(() {
                                      widget.province = newValue;
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
                          height: 20,
                        ),
                        Text(
                          "Escoger dirección en mapa",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        showPickedLocation(),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            alignment: Alignment(0.0, 0.0),
                            child: RaisedButton(
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
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (widget.province != null) {
                                    if(widget.latitude != null && widget.longitude != null) {
                                      if (widget.method == "post") {
                                        pr.show();
                                        response =
                                            await UsuarioTienditasProvider()
                                                .createAddress(
                                                    Provider.of<LoginState>(
                                                            context,
                                                            listen: false)
                                                        .currentUserIdToken,
                                                    widget.userEmail,
                                                  widget.name,
                                                  widget.addressLine,
                                                  widget.referencePoint,
                                                  "Panamá",
                                                  widget.province,
                                                  widget.latitude,
                                                  widget.longitude);
                                      }
                                      if (widget.method == "put") {
                                        pr.show();
                                        response =
                                            await UsuarioTienditasProvider()
                                                .updateAddress(
                                                    Provider.of<LoginState>(
                                                            context,
                                                            listen: false)
                                                        .currentUserIdToken,
                                                    widget.id,
                                                  widget.userEmail,
                                                  widget.name,
                                                  widget.addressLine,
                                                  widget.referencePoint,
                                                  "Panamá",
                                                  widget.province,
                                                  widget.latitude,
                                                  widget.longitude);
                                      }
                                    } else {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Debe seleccionar su ubicación en el mapa'),
                                        ),
                                      );
                                    }
                                  } else {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Debe seleccionar provincia'),
                                      ),
                                    );
                                  }
                                  if (response.statusCode == 200) {
                                    ResponseTienditasApi responseTienditasApi =
                                        responseFromJson(response.body);
                                    if (responseTienditasApi.statusCode ==
                                        200) {
                                      //Succes Response, Direccion Guardada
                                      pr.hide();
                                      print(responseTienditasApi.body.message);
                                      isLoading = false;
                                      Navigator.of(context).pop();
                                    } else {
                                      //Error en guardar o editar La  direccion
                                      pr.hide();
                                      print(responseTienditasApi.body.message);
                                      isLoading = false;
                                    }
                                  } else {
                                    //Error de conexion
                                    pr.hide();
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Hubo problemas al editar la tienda, \nfavor revisar su conexión a internet'),
                                      ),
                                    );
                                  }
                                }
                              },
                            )),
                      ]),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget showPickedLocation() {
    return Container(
      height: 200,
      width: double.infinity,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: cameraLocation,
          zoom: 15,
        ),
        onMapCreated: (controller) => setMapController(controller),
        markers: _markers,
        onTap: (argument) => goToMapSelectionPage(),
      ),
    );
  }

  goToMapSelectionPage() async {
    userPickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationMapPage(),
      ),
    );
    if (userPickedLocation != null) {
      reloadMap(userPickedLocation);
    }
  }

  setMapController(GoogleMapController _controller) {
    _mapController = _controller;
  }
}
