import 'dart:convert';

class LocationModel {
  final double? latitude;
  final double? longitude;
  final String? province;
  final String? city;
  final String? address;
  bool isCurrent;

  LocationModel(
      {this.latitude,
      this.longitude,
      this.province,
      this.city,
      this.address,
      this.isCurrent = true});

  Map<String, dynamic> toJson() {
    return {
      "longitude": longitude,
      "latitude": latitude,
      "province": province,
      "city": city,
      "address": address,
      "is_current": isCurrent,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
