import 'dart:convert';
import 'package:indriver_clone_flutter/src/domain/models/DriverCarInfo.dart';

ClientRequestResponse clientRequestResponseFromJson(String str) =>
    ClientRequestResponse.fromJson(json.decode(str));

String clientRequestResponseToJson(ClientRequestResponse data) =>
    json.encode(data.toJson());

class ClientRequestResponse {
  int id;
  int idClient;
  String fareOffered;
  String pickupDescription;
  String destinationDescription;
  DateTime updatedAt;
  DateTime? createdAt;
  Position pickupPosition;
  Position destinationPosition;
  double? distance;
  String? timeDifference;
  Client client;
  Client? driver;
  GoogleDistanceMatrix? googleDistanceMatrix;
  int? idDriverAssigned;
  double? fareAssigned;
  DriverCarInfo? car;

  ClientRequestResponse({
    required this.id,
    required this.idClient,
    required this.fareOffered,
    required this.pickupDescription,
    required this.destinationDescription,
    required this.updatedAt,
    this.createdAt,
    required this.pickupPosition,
    required this.destinationPosition,
    this.distance,
    this.timeDifference,
    required this.client,
    this.googleDistanceMatrix,
    this.fareAssigned,
    this.idDriverAssigned,
    this.driver,
    this.car,
  });

  static List<ClientRequestResponse> fromJsonList(List<dynamic> jsonList) {
    List<ClientRequestResponse> toList = [];
    jsonList.forEach((json) {
      try {
        ClientRequestResponse item = ClientRequestResponse.fromJson(json);
        toList.add(item);
      } catch (e) {
        print("Error parseando item de la lista: $e");
      }
    });
    return toList;
  }

  factory ClientRequestResponse.fromJson(Map<String, dynamic> json) {
    
    // 1. PARSEO DE CLIENTE
    dynamic clientData = json["client"];
    if (clientData is String) {
       try { clientData = jsonDecode(clientData); } catch(e) { clientData = {}; }
    }

    // 2. PARSEO DE CONDUCTOR (DRIVER) - ¡AQUÍ ESTABA EL ERROR!
    dynamic driverData = json["driver"];
    if (driverData is String) {
       try { driverData = jsonDecode(driverData); } catch(e) { driverData = null; }
    }

    // 3. PARSEO DE CARRO (CAR) - ¡TAMBIÉN ESTABA EL ERROR!
    dynamic carData = json["car"];
    if (carData is String) {
       try { carData = jsonDecode(carData); } catch(e) { carData = null; }
    }

    // 4. PARSEO DE GOOGLE MATRIX
    dynamic matrixData = json["google_distance_matrix"];
    if (matrixData is String) {
       try { matrixData = jsonDecode(matrixData); } catch(e) { matrixData = null; }
    }

    return ClientRequestResponse(
        id: json["id"] is String ? int.parse(json["id"]) : json["id"],
        idClient: json["id_client"] is String ? int.parse(json["id_client"]) : json["id_client"],
        fareOffered: json["fare_offered"].toString(),
        pickupDescription: json["pickup_description"],
        destinationDescription: json["destination_description"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,

        // Coordenadas
        pickupPosition: Position(
          x: (json["pickup_position"] != null && json["pickup_position"]["x"] != null) 
              ? (json["pickup_position"]["x"] as num).toDouble() 
              : (json["pickup_lng"] ?? 0.0).toDouble(),
          y: (json["pickup_position"] != null && json["pickup_position"]["y"] != null)
              ? (json["pickup_position"]["y"] as num).toDouble()
              : (json["pickup_lat"] ?? 0.0).toDouble(),
        ),
        destinationPosition: Position(
          x: (json["destination_position"] != null && json["destination_position"]["x"] != null)
              ? (json["destination_position"]["x"] as num).toDouble()
              : (json["destination_lng"] ?? 0.0).toDouble(),
          y: (json["destination_position"] != null && json["destination_position"]["y"] != null)
              ? (json["destination_position"]["y"] as num).toDouble()
              : (json["destination_lat"] ?? 0.0).toDouble(),
        ),

        distance: json["distance"]?.toDouble(),
        timeDifference: json["time_difference"]?.toString(),
        
        // Usamos las variables procesadas
        client: Client.fromJson(clientData),
        driver: driverData != null ? Client.fromJson(driverData) : null,
        car: carData != null ? DriverCarInfo.fromJson(carData) : null,
        googleDistanceMatrix: matrixData != null ? GoogleDistanceMatrix.fromJson(matrixData) : null,
        
        idDriverAssigned: json["id_driver_assigned"],
        fareAssigned: json["fare_assigned"]?.toDouble(),
      );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "fare_offered": fareOffered,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "pickup_lat": pickupPosition.y,
        "pickup_lng": pickupPosition.x,
        "destination_lat": destinationPosition.y,
        "destination_lng": destinationPosition.x,
        "distance": distance,
        "time_difference": timeDifference,
        "client": client.toJson(),
        "driver": driver?.toJson(),
        "google_distance_matrix": googleDistanceMatrix?.toJson(),
        "id_driver_assigned": idDriverAssigned,
        "fare_assigned": fareAssigned,
        "car": car?.toJson(),
      };
}

class Client {
  String name;
  dynamic image;
  String phone;
  String lastname;

  Client({
    required this.name,
    required this.image,
    required this.phone,
    required this.lastname,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        name: json["name"] ?? '',
        image: json["image"],
        phone: json["phone"] ?? '',
        lastname: json["lastname"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "phone": phone,
        "lastname": lastname,
      };
}

class Position {
  double x;
  double y;

  Position({ required this.x, required this.y });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        x: json["x"]?.toDouble() ?? 0.0,
        y: json["y"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => { "x": x, "y": y };
}

class GoogleDistanceMatrix {
  Distance distance;
  Distance duration;
  String status;

  GoogleDistanceMatrix({
    required this.distance,
    required this.duration,
    required this.status,
  });

  factory GoogleDistanceMatrix.fromJson(Map<String, dynamic> json) =>
      GoogleDistanceMatrix(
        distance: Distance.fromJson(json["distance"]),
        duration: Distance.fromJson(json["duration"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance.toJson(),
        "duration": duration.toJson(),
        "status": status,
      };
}

class Distance {
  String text;
  int value;

  Distance({ required this.text, required this.value });

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => { "text": text, "value": value };
}
