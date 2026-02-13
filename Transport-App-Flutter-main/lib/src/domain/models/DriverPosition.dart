import 'dart:convert';

DriverPosition driverPositionFromJson(String str) => DriverPosition.fromJson(json.decode(str));

String driverPositionToJson(DriverPosition data) => json.encode(data.toJson());

class DriverPosition {
    int idDriver;
    double lat;
    double lng;

    DriverPosition({
        required this.idDriver,
        required this.lat,
        required this.lng,
    });

    factory DriverPosition.fromJson(Map<String, dynamic> json) => DriverPosition(
        // 1. Protección: Convierte a int incluso si viene como String
        idDriver: json["id_driver"] is String ? int.parse(json["id_driver"]) : json["id_driver"],
        
        // 2. Protección: Lee 'lat' O 'y', y asegura que sea double
        lat: (json["lat"] ?? json["y"] ?? 0.0).toDouble(),
        
        // 3. Protección: Lee 'lng' O 'x', y asegura que sea double
        lng: (json["lng"] ?? json["x"] ?? 0.0).toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "lat": lat,
        "lng": lng,
    };
}
