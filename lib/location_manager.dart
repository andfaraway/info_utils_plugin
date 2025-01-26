import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'location_model.dart';

class LocationManager {
  LocationManager._privateConstructor();

  static final LocationManager _instance = LocationManager._privateConstructor();

  static LocationManager get instance => _instance;

  LocationModel? _locationData;
  LocationModel? _lastLocData;

  Future<LocationModel?> getLocation() async {
    if (_locationData != null) {
      return _locationData;
    }
    bool locationPermission = await requestPermission();
    if (locationPermission) {
      try {
        final position = await Geolocator.getCurrentPosition().timeout(const Duration(seconds: 8));

        _locationData = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
        );

        List<Placemark> marks = await placemarkFromCoordinates(position.latitude, position.longitude);

        _locationData = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          province: marks.firstOrNull?.administrativeArea,
          city: marks.firstOrNull?.subAdministrativeArea,
          address: marks.firstOrNull?.street,
          isCurrent: true,
        );
      } catch (e) {
        debugPrint('### get location error: ${e.toString()}');
      }
    }
    return _locationData;
  }

  /// 获取定位权限
  Future<bool> requestPermission() async {
    try {
      bool tempSerEnabled = await Geolocator.isLocationServiceEnabled();
      if (!tempSerEnabled) {
        return false;
      }
      print(await Permission.location.request());
      return await Permission.location.request().isGranted;
    } catch (e) {
      return false;
    }
  }

  /// 获取上一次已知的位置
  Future<LocationModel?> getLastKnowPosition() async {
    if (_lastLocData != null) {
      return _lastLocData;
    }
    bool locationPermission = await requestPermission();
    if (locationPermission) {
      try {
        final position = await Geolocator.getLastKnownPosition().timeout(const Duration(seconds: 8));
        if (position == null) {
          return null;
        }
        _lastLocData = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        _lastLocData = LocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
          province: placemarks.firstOrNull?.administrativeArea,
          city: placemarks.firstOrNull?.subAdministrativeArea,
          address: placemarks.firstOrNull?.street,
          isCurrent: false,
        );
      } catch (e) {
        debugPrint('### get getLastKnowPosition error: ${e.toString()}');
      }
    }
    return _lastLocData;
  }
}
