#Transport Platform 🚚💨

Esta plataforma es una solución **Full-Stack** diseñada para la gestión logística y el transporte de última milla. El sistema permite la interacción en tiempo real entre conductores y despachadores, optimizando la eficiencia operativa mediante el seguimiento GPS y una arquitectura escalable.

## 📱 Capacidades Técnicas

* **Frontend Mobile:** Aplicación desarrollada en **Flutter** con arquitectura **Clean Architecture**, garantizando un código mantenible y reactivo.
* **Backend:** API RESTful robusta construida con **Node.js** y **Express.js**.
* **Tiempo Real:** Implementación de **Socket.io** para el seguimiento de rutas por GPS y notificaciones instantáneas.
* **Base de Datos:** Gestión de datos relacionales y persistencia de rutas mediante **PostgreSQL** (o MongoDB) con el uso de ORMs.
* **Seguridad:** Flujos de autenticación y autorización protegidos con **JSON Web Tokens (JWT)** y cifrado de datos sensibles.

## 🛠️ Stack Tecnológico

| Capa | Tecnologías y Herramientas |
| :--- | :--- |
| **Frontend Mobile** | Flutter SDK (Dart), Gestión de estados (Provider/Bloc/GetX), Google Maps API. |
| **Backend** | Node.js, Express.js, Arquitectura RESTful, JWT (Autenticación). |
| **Tiempo Real** | Socket.io para tracking y notificaciones. |
| **Base de Datos** | PostgreSQL / MongoDB con Sequelize / Mongoose. |
| **Infraestructura** | Docker, Git/GitHub, despliegue en VPS (AWS / DigitalOcean). |

## 🏗️ Arquitectura y Patrones

El proyecto ha sido desarrollado bajo estándares de ingeniería de software para asegurar su escalabilidad:
* **Clean Architecture:** Separación clara de capas en el frontend de Flutter.
* **Responsive Design:** Interfaces adaptables siguiendo los lineamientos de **Material Design** y **Cupertino**.
* **Geolocalización Avanzada:** Algoritmos para el trazado de rutas óptimas e integración de mapas interactivos.

## ⚙️ Instalación y Configuración

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/andreslombana/Last-Mile-Transport-App.git](https://github.com/andreslombana/Last-Mile-Transport-App.git)
    ```
2.  **Configurar el Backend:**
    * Navegar a `/backend`, instalar dependencias con `npm install`.
    * Configurar variables de entorno en un archivo `.env` (DB_URL, JWT_SECRET).
3.  **Configurar el Mobile (Flutter):**
    * Navegar a `/frontend`, ejecutar `flutter pub get`.
    * Asegurarse de tener configurada la API Key de Google Maps.

## 💼 Perfil del Desarrollador
Desarrollado por **Andrés Lombana**, Ingeniería de Sistemas, especializado en desarrollo Full-Stack Mobile y soluciones de transporte inteligente.
