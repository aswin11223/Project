import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  String _location = '';
  LatLng? _pickedLocation;

  String get location => _location;
  LatLng? get pickedLocation => _pickedLocation;

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _location = '${position.latitude}, ${position.longitude}';
    _pickedLocation = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }

  void pickLocation(LatLng location) {
    _pickedLocation = location;
    _location = '${location.latitude}, ${location.longitude}';
    notifyListeners();
  }
}
