import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:indriver_clone_flutter/firebase_options.dart';
import 'package:indriver_clone_flutter/main.dart'; // Asegúrate de que aquí esté tu navigatorKey
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/DriverClientRequestsPage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// Variables globales necesarias
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// 1. MANEJADOR DE SEGUNDO PLANO (APP CERRADA)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

// 2. CONFIGURACIÓN INICIAL
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

// 3. MOSTRAR NOTIFICACIÓN VISUAL
void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background', // Asegúrate de tener este icono en android/app/src/main/res/drawable
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }
}

// 4. LISTENER DE MENSAJES (APP ABIERTA)
void onMessageListener() async {
  // Mensaje inicial si la app se abrió desde una notificación muerta
  FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
           // Lógica opcional para navegar si se abre desde cerrado
        }
      }
  );

  // ESCUCHA EN PRIMER PLANO
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('---------- NOTIFICACION ENTRANTE (FOREGROUND) ---------');
    
    // 1. MOSTRAR LA NOTIFICACIÓN VISUAL (Faltaba esto)
    showFlutterNotification(message);

    // 2. ABRIR EL MODAL (Estilo Uber/InDriver)
    // Solo si es una solicitud de viaje
    // if (message.data['type'] == 'CLIENT_REQUEST') { // Descomenta si quieres filtrar
      if (navigatorKey.currentContext != null) {
        showMaterialModalBottomSheet(
          context: navigatorKey.currentContext!,
          expand: false, // false para que respete la altura
          enableDrag: true,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.9,
            // IMPORTANTE: Asegúrate de que los BLOCS estén disponibles aquí
            // Si usas MultiBlocProvider en main.dart, debería funcionar.
            child: DriverClientRequestsPage()
          )
        );
      }
    // }
  });

  // CLIC EN LA NOTIFICACIÓN (APP EN SEGUNDO PLANO)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('---------- NOTIFICACION CLIKEADA -----------');
    if (message.data['type'] == 'CLIENT_REQUEST') {
      if (navigatorKey.currentContext != null) {
        Navigator.pushNamed(
          navigatorKey.currentContext!,
          'driver/client/request',
        );
      }
    }
  });
}

