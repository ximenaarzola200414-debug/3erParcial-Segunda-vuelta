# Task Manager App - Flutter

Aplicación móvil de gestión de tareas con autenticación JWT y consumo de API externa (OpenWeather).

## 📋 Características

- ✅ Autenticación (Login/Registro)
- ✅ Gestión de tareas (CRUD completo)
- ✅ Filtrado por estado y prioridad
- ✅ Búsqueda de tareas
- ✅ Persistencia de sesión
- ✅ Integración con API del clima (OpenWeather)
- ✅ Interfaz moderna con Material Design 3

## 🚀 Requisitos

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Backend API corriendo (ver carpeta `backend/`)
- API Key de OpenWeather (opcional para funcionalidad del clima)

## 📦 Instalación

1. **Asegurarse de que Flutter esté instalado:**
   ```bash
   flutter --version
   ```

2. **Navegar al directorio del proyecto:**
   ```bash
   cd task_manager_app
   ```

3. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

4. **Configurar API URLs:**
   
   Editar `lib/utils/constants.dart` y actualizar las URLs:
   
   ```dart
   // Para emulador Android
   static const String baseUrl = 'http://10.0.2.2:3000';
   
   // Para dispositivo físico o iOS
   static const String baseUrl = 'http://TU_IP_LOCAL:3000';
   
   // Para web/desktop
   static const String baseUrl = 'http://localhost:3000';
   ```

5. **Configurar OpenWeather API (opcional):**
   
   - Obtener una API key gratis en: https://openweathermap.org/api
   - Actualizar en `lib/utils/constants.dart`:
   
   ```dart
   static const String weatherApiKey = 'TU_API_KEY_AQUI';
   ```

## ▶️ Ejecutar la aplicación

### Emulador Android/iOS:
```bash
flutter run
```

### Dispositivo físico:
```bash
flutter run -d DEVICE_ID
```

### Listar dispositivos disponibles:
```bash
flutter devices
```

### Web (opcional):
```bash
flutter run -d chrome
```

## 🏗️ Estructura del Proyecto

```
lib/
├── models/              # Modelos de datos
│   ├── user.dart       # Modelo de usuario
│   ├── task.dart       # Modelo de tarea
│   └── weather.dart    # Modelo de clima
├── services/           # Servicios/API
│   ├── api_service.dart      # Cliente HTTP base
│   ├── auth_service.dart     # Servicio de autenticación
│   ├── task_service.dart     # Servicio de tareas
│   └── weather_service.dart  # Servicio de clima
├── providers/          # State Management (Provider)
│   ├── auth_provider.dart    # Estado de autenticación
│   └── task_provider.dart    # Estado de tareas
├── ui/
│   ├── screens/        # Pantallas principales
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── home_screen.dart
│   │   ├── task_list_screen.dart
│   │   ├── task_form_screen.dart
│   │   └── task_detail_screen.dart
│   └── widgets/        # Widgets reutilizables
│       └── task_card.dart
├── utils/
│   └── constants.dart  # Constantes de configuración
└── main.dart          # Punto de entrada
```

## 🎯 Arquitectura

La aplicación sigue una arquitectura en capas:

1. **Capa de Presentación (UI)**: Widgets y pantallas
2. **Capa de Lógica (Providers)**: Manejo de estado con Provider
3. **Capa de Servicios**: Comunicación con APIs
4. **Capa de Modelos**: Definición de estructuras de datos

## 📱 Funcionalidades Principales

### Autenticación
- Registro de nuevos usuarios
- Inicio de sesión con email/contraseña
- Persistencia de sesión con tokens JWT
- Cierre de sesión

### Gestión de Tareas
- **Crear**: Nueva tarea con título, descripción, prioridad, estado y fecha límite
- **Leer**: Ver lista completa y detalles individuales
- **Actualizar**: Editar cualquier campo de la tarea
- **Eliminar**: Eliminar tareas con confirmación

### Filtros y Búsqueda
- Filtrar por estado (Pendiente/En Progreso/Hecha)
- Filtrar por prioridad (Alta/Media/Baja)
- Búsqueda por texto en título y descripción
- Combinar múltiples filtros

### Dashboard
- Estadísticas de tareas
- Clima actual
- Acceso rápido a funciones principales

## 🔑 Credenciales de Prueba

Si el backend tiene datos iniciales:

```
Email: test@test.com
Password: test123
```

## 🎨 Personalización

### Cambiar tema de colores:

Editar en `lib/main.dart`:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple, // Cambiar color aquí
  ),
  useMaterial3: true,
),
```

## 📝 Dependencias Principales

- **provider**: State management
- **http**: Cliente HTTP
- **shared_preferences**: Almacenamiento local
- **flutter_secure_storage**: Almacenamiento seguro para tokens
- **intl**: Formateo de fechas

## 🐛 Troubleshooting

### Error de conexión al backend

1. Verificar que el backend esté corriendo en `http://localhost:3000`
2. Para Android emulator, usar `http://10.0.2.2:3000`
3. Para dispositivo físico, usar la IP local de tu computadora

### Error al obtener el clima

1. Verificar que tengas una API key válida de OpenWeather
2. Revisar la configuración en `lib/utils/constants.dart`
3. La funcionalidad del clima es opcional; el resto de la app funciona sin ella

### Error de certificados SSL en Android

Si tienes problemas con HTTPS, asegúrate de configurar los certificados correctamente o usa HTTP para desarrollo.

## 🔧 Comandos Útiles

```bash
# Limpiar proyecto
flutter clean

# Obtener dependencias
flutter pub get

# Analizar código
flutter analyze

# Formatear código
dart format lib/

# Ejecutar en modo release
flutter run --release

# Generar APK (Android)
flutter build apk

# Generar iOS build
flutter build ios
```

## 📄 Licencia

MIT License

## 👨‍💻 Desarrollo

Este proyecto fue desarrollado como parte de un sistema completo de gestión de tareas que incluye:
- Backend API REST con Node.js + Express
- Base de datos MySQL
- Autenticación JWT
- Integración con APIs externas
