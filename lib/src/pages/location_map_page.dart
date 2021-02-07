import 'dart:async';
import 'dart:collection';

import 'package:app_tiendita/src/state_providers/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationMapPage extends StatefulWidget {
  @override
  _LocationMapPageState createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  static final CameraPosition _panamaCiudad = CameraPosition(
    target: LatLng(9.001035, -79.522508),
    zoom: 14.4746,
  );

  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  GoogleMapController _mapController;

  Location location = new Location();
  LatLng tappedLocation;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  @override
  Future<void> initState() {
    super.initState();
    //getUserCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getUserCurrentLocation(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  GoogleMap(
                    onTap: (_tappedLocation) =>
                        markTappedLocation(_tappedLocation),
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          _locationData.latitude, _locationData.longitude),
                      zoom: 14.4746,
                    ),
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                  ),
                  Container(
                    child: Align(
                      child: RaisedButton(
                        onPressed: () => savePickedLocation(),
                        child: Text(
                          'CONFIRMAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<LocationData> getUserCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData.toString());

    return _locationData;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(_locationData.latitude, _locationData.longitude),
          infoWindow: InfoWindow(),
        ),
      );
    });
    markTappedLocation(
      LatLng(_locationData.latitude, _locationData.longitude),
    );
  }

  markTappedLocation(LatLng _tappedLocation) {
    tappedLocation = _tappedLocation;
    setState(() {
      _markers.removeWhere((element) => element.markerId.value == '0');
      _markers.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(tappedLocation.latitude, tappedLocation.longitude),
          infoWindow: InfoWindow(
            title: 'Ciudad De Panamá',
            snippet: 'Juega Vivo Pelao',
          ),
        ),
      );
    });

    print(tappedLocation.latitude);
    print(tappedLocation.longitude);
  }

  savePickedLocation() {
    Provider.of<LoginState>(context, listen: false).currentUserPickedLocation =
        tappedLocation;
    Navigator.pop(context, tappedLocation);
  }
}
