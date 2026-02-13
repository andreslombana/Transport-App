import 'dart:convert';

DriverCarInfo driverCarInfoFromJson(String str) => DriverCarInfo.fromJson(json.decode(str));

String driverCarInfoToJson(DriverCarInfo data) => json.encode(data.toJson());

class DriverCarInfo {
    int? idDriver;
    String brand;
    String plate;
    String? color; // Puede ser nulo

    DriverCarInfo({
        this.idDriver,
        required this.brand,
        required this.plate,
        this.color,
    });

    factory DriverCarInfo.fromJson(Map<String, dynamic> json) => DriverCarInfo(
        idDriver: json["id_driver"] is String ? int.tryParse(json["id_driver"]) : json["id_driver"],
        
        // Blindaje contra nulos
        brand: json["brand"] ?? 'Marca desconocida',
        plate: json["plate"] ?? 'Sin Placa',
        color: json["color"] ?? 'Color no especificado', 
    );

    Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "brand": brand,
        "plate": plate,
        "color": color,
    };
}