import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  String _location = '';
  LatLng? _pickedLocation;

  String get location => _location;
  LatLng? get pickedLocation => _pickedLocation;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      notifyListeners();
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  void pickLocation(LatLng location) {
    _pickedLocation = location;
    _location = 'Latitude: ${location.latitude}, Longitude: ${location.longitude}';
    notifyListeners();
  }
}
