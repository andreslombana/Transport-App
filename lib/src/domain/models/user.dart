import 'dart:convert';
import 'package:indriver_clone_flutter/src/domain/models/Role.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    // Puede venir como int o String del backend, lo manejaremos dinamicamente
    int? id; 
    String name;
    String lastname;
    String? email;
    String phone;
    String? password;
    String? image;
    String? notificationToken;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Role>? roles;

    User({
        this.id,
        required this.name,
        required this.lastname,
        this.email,
        required this.phone,
        this.image,
        this.password,
        this.notificationToken,
        this.createdAt,
        this.updatedAt,
        this.roles,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        // Manejo seguro de ID (puede ser int o string)
        id: json["id"] is String ? int.tryParse(json["id"]) : json["id"],
        
        name: json["name"] ?? '',
        lastname: json["lastname"] ?? '', // Blindaje: si es null, pone ''
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        image: json["image"], // Puede ser null sin problema
        password: json['password'],
        notificationToken: json["notification_token"],
        createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
        roles: json["roles"] != null ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x))) : [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "image": image,
        "password": password,
        "notification_token": notificationToken,
        "roles": roles != null ? List<dynamic>.from(roles!.map((x) => x.toJson())) : [],
    };
}