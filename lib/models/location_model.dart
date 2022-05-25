import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String placeId;
  final String name;
  final double lat;
  final double lon;

  const Location({
    this.placeId = '',
    this.name = '',
    required this.lat,
    required this.lon,
  });

  static const initialLocation = Location(lat: 0, lon: 0);

  Location copyWith({
    String? placeId,
    String? name,
    double? lat,
    double? lon,
  }) {
    return Location(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  @override
  List<Object?> get props => [placeId, name, lat, lon];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        placeId: json['place_id'],
        name: json['name'],
        lat: json['geometry']['location']['lat'],
        lon: json['geometry']['location']['lng']);
  }

  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'name': name,
      'lat': lat,
      'lon': lon,
    };
  }
}
