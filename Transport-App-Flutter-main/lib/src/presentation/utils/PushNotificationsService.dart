import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:indriver_clone_flutter/firebase_options.dart';
import 'package:indriver_clone_flutter/main.dart'; // Importante para acceder a navigatorKey
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/DriverClientRequestsPage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// Variables globales para el canal de notificaciones
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// 1. MANEJADOR DE SEGUNDO PLANO (APP CERRADA O MINIMIZADA)
// Esta función debe estar fuera de cualquier clase y marcada con @pragma
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

// 2. CONFIGURACIÓN INICIAL DEL CANAL DE NOTIFICACIONES
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  
  // Definir el canal de alta importancia para Android
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id único
    'High Importance Notifications', // título visible en ajustes
    description: 'This channel is used for important notifications.', // descripción
    importance: Importance.high,
    playSound: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Crear el canal en el sistema Android
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Configurar opciones de presentación en primer plano para iOS/Android
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

// 3. MOSTRAR NOTIFICACIÓN VISUAL (BANNER)
void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  
  // Si la notificación es válida y no estamos en web, mostramos el banner local
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
          // Asegúrate de que este icono exista en android/app/src/main/res/drawable
          // Si no tienes uno personalizado, usa '@mipmap/ic_launcher'
          icon: 'launch_background', 
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }
}

// 4. LISTENER DE MENSAJES (CUANDO LA APP ESTÁ ABIERTA)
void onMessageListener() async {
  // Caso A: La app se abrió desde una notificación terminada (estado cerrado)
  FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
           print('Nueva notificación al iniciar app: ${message.data}');
        }
      }
  );

  // Caso B: La app está en primer plano (abierta y en uso)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('---------- NOTIFICACION ENTRANTE (FOREGROUND) ---------');
    
    // 1. Mostrar la notificación visual (Banner superior)
    showFlutterNotification(message);

    // 2. Abrir el Modal Bottom Sheet automáticamente
    if (navigatorKey.currentContext != null) {
      showMaterialModalBottomSheet(
        context: navigatorKey.currentContext!,
        expand: false, 
        enableDrag: true,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.9, // 90% de la pantalla
          child: DriverClientRequestsPage() // Tu página de solicitudes
        )
      );
    }
  });

  // Caso C: La app está en segundo plano y el usuario hace clic en la notificación
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('---------- NOTIFICACION CLICKEADA (BACKGROUND) -----------');
    
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