import 'dart:convert';

import 'package:indriver_clone_flutter/src/domain/models/DriverCarInfo.dart';
import 'package:indriver_clone_flutter/src/domain/models/user.dart';

DriverTripRequest driverTripRequestFromJson(String str) => DriverTripRequest.fromJson(json.decode(str));

String driverTripRequestToJson(DriverTripRequest data) => json.encode(data.toJson());

class DriverTripRequest {
    int? id;
    int idDriver;
    int idClientRequest;
    double fareOffered;
    double time;
    double distance;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? driver;
    DriverCarInfo? car;
    
    DriverTripRequest({
        this.id,
        required this.idDriver,
        required this.idClientRequest,
        required this.fareOffered,
        required this.time,
        required this.distance,
        this.createdAt,
        this.updatedAt,
        this.driver,
        this.car
    });

    factory DriverTripRequest.fromJson(Map<String, dynamic> json) {
      
      // --- 1. PARSEO DE CONDUCTOR (Driver) ---
      dynamic driverData = json["driver"];
      if (driverData is String) {
         try {
           driverData = jsonDecode(driverData);
         } catch (e) {
           print("Error decoding driver info: $e");
           driverData = null;
         }
      }

      // --- 2. PARSEO DE CARRO (Car) ---
      dynamic carData = json["car"];
      if (carData is String) {
         try {
           carData = jsonDecode(carData);
         } catch (e) {
           print("Error decoding car info: $e");
           carData = null;
         }
      }

      return DriverTripRequest(
        id: json["id"] is String ? int.tryParse(json["id"]) : json["id"],
        idDriver: json["id_driver"] is String ? int.parse(json["id_driver"]) : json["id_driver"],
        idClientRequest: json["id_client_request"] is String ? int.parse(json["id_client_request"]) : json["id_client_request"],
        
        fareOffered: json["fare_offered"] is String 
            ? double.parse(json["fare_offered"]) 
            : (json["fare_offered"] as num).toDouble(),
            
        time: json["time"] is String 
            ? double.parse(json["time"]) 
            : (json["time"] as num).toDouble(),
            
        distance: json["distance"] is String 
            ? double.parse(json['distance']) 
            : (json["distance"] as num).toDouble(),
            
        createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
        
        // Aquí es donde la magia ocurre: Si es null, pasa null y no explota
        driver: driverData != null ? User.fromJson(driverData) : null,
        car: carData != null ? DriverCarInfo.fromJson(carData) : null,
      );
    }

    static List<DriverTripRequest> fromJsonList(List<dynamic> jsonList) {
      List<DriverTripRequest> toList = [];
      jsonList.forEach((json) { 
        try {
          DriverTripRequest driverTripRequest = DriverTripRequest.fromJson(json);
          toList.add(driverTripRequest);
        } catch (e) {
          print("Error parseando una oferta individual: $e");
          // Si una oferta falla, la ignoramos y seguimos con las demás
        }
      });
      return toList;
    }

    Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "id_client_request": idClientRequest,
        "fare_offered": fareOffered,
        "time": time,
        "distance": distance,
    };
}

