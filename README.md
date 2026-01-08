# Task Manager - Aplicación Full Stack

Sistema completo de gestión de tareas con app móvil Flutter y backend REST API con autenticación JWT y base de datos MySQL.

## 📋 Descripción del Proyecto

Este proyecto implementa una aplicación full-stack que cumple con todos los requerimientos de un sistema de gestión de tareas moderno:

### ✅ Cumplimiento de Requerimientos

#### App Móvil (Flutter)
- ✅ Autenticación completa (Login + Registro)
- ✅ Manejo de sesión con JWT
- ✅ Persistencia de sesión (SharedPreferences + Secure Storage)
- ✅ CRUD completo de tareas
- ✅ Filtrado por estado y prioridad
- ✅ Búsqueda de tareas
- ✅ Consumo de API externa (OpenWeather)
- ✅ Arquitectura en capas (models, services, providers, UI)
- ✅ Manejo de estados (loading/success/error)
- ✅ Validación de formularios

#### Backend (Node.js + Express + MySQL)
- ✅ Autenticación con JWT
- ✅ Endpoints de registro y login
- ✅ CRUD completo de tareas protegido
- ✅ Base de datos MySQL con relaciones
- ✅ Middleware de autenticación
- ✅ Validación de datos
- ✅ Manejo de errores
- ✅ Documentación de API

## 🏗️ Estructura del Proyecto

```
segundavuelta_3erparcial/
│
├── backend/                    # API REST con Node.js + Express
│   ├── src/
│   │   ├── config/            # Configuración MySQL
│   │   ├── controllers/       # Lógica de negocio
│   │   ├── middleware/        # Autenticación JWT
│   │   └── routes/            # Definición de rutas
│   ├── database.sql           # Schema de BD
│   ├── package.json
│   └── README.md             # Documentación del backend
│
└── task_manager_app/          # App móvil Flutter
    ├── lib/
    │   ├── models/            # Modelos de datos
    │   ├── services/          # Servicios/API
    │   ├── providers/         # State management
    │   ├── ui/                # Pantallas y widgets
    │   └── utils/             # Constantes
    ├── pubspec.yaml
    └── README.md             # Documentación de Flutter
```

## 🚀 Guía de Instalación Rápida

### Prerrequisitos

- **Node.js** >= 14.x
- **MySQL** >= 5.7
- **Flutter** >= 3.0.0
- **Git**

### 1. Configurar Backend

```bash
# Navegar al directorio backend
cd backend

# Instalar dependencias
npm install

# Configurar base de datos
mysql -u root -p < database.sql

# Configurar variables de entorno
copy .env.example .env
# Editar .env con tus credenciales de MySQL

# Iniciar servidor
npm run dev
```

El backend estará disponible en `http://localhost:3000`

### 2. Configurar Flutter App

```bash
# Navegar al directorio de Flutter
cd task_manager_app

# Instalar dependencias
flutter pub get

# Configurar URL del backend en lib/utils/constants.dart
# Para Android emulator: http://10.0.2.2:3000
# Para iOS/dispositivo físico: http://TU_IP_LOCAL:3000

# (Opcional) Configurar OpenWeather API key en mismo archivo

# Ejecutar app
flutter run
```

## 🔑 Credenciales de Prueba

El database.sql incluye un usuario de prueba:

```
Email: test@test.com
Password: test123
```

## 📚 Documentación Detallada

- **Backend**: Ver [backend/README.md](backend/README.md)
- **Flutter**: Ver [task_manager_app/README.md](task_manager_app/README.md)

## 🎯 Características Principales

### Autenticación
- Registro de usuarios con validación
- Login con email y contraseña
- Tokens JWT con expiración de 7 días
- Protección de rutas con middleware
- Persistencia de sesión en móvil

### Gestión de Tareas
- Crear tareas con todos los campos:
  - Título (requerido)
  - Descripción
  - Prioridad: Alta/Media/Baja
  - Estado: Pendiente/En Progreso/Hecha
  - Fecha de creación (automática)
  - Fecha límite
- Listar todas las tareas del usuario
- Ver detalles completos de cada tarea
- Editar cualquier campo
- Eliminar con confirmación

### Filtrado y Búsqueda
- Filtrar por estado
- Filtrar por prioridad
- Búsqueda en título y descripción
- Combinar múltiples filtros

### API Externa
- Integración con OpenWeather API
- Muestra clima actual en el dashboard
- Manejo de errores de red
- Estados de carga

## 🛠️ Tecnologías Utilizadas

### Backend
- **Node.js** - Runtime de JavaScript
- **Express** - Framework web
- **MySQL** - Base de datos relacional
- **JWT** - Autenticación basada en tokens
- **bcryptjs** - Encriptación de contraseñas
- **CORS** - Cross-Origin Resource Sharing

### Flutter
- **Provider** - State management
- **HTTP** - Cliente REST
- **SharedPreferences** - Almacenamiento local
- **FlutterSecureStorage** - Almacenamiento seguro
- **Intl** - Formateo de fechas

### APIs Externas
- **OpenWeather API** - Datos meteorológicos

## 📊 Base de Datos

### Modelo de Datos

**Tabla: users**
- id (PK, auto_increment)
- nombre
- email (unique)
- password (hashed)
- created_at

**Tabla: tasks**
- id (PK, auto_increment)
- user_id (FK -> users.id)
- titulo
- descripcion
- prioridad (enum: alta, media, baja)
- estado (enum: pendiente, en progreso, hecha)
- fecha_creacion
- fecha_limite
- updated_at

## 🔐 Seguridad

- ✅ Contraseñas hasheadas con bcrypt (10 rounds)
- ✅ JWT con secret key configurable
- ✅ Tokens almacenados de forma segura en el cliente
- ✅ Validación de inputs en backend y frontend
- ✅ Protección contra SQL injection (queries parametrizadas)
- ✅ CORS configurado
- ✅ Middleware de autenticación en rutas protegidas

## 📱 Pantallas de la App

1. **Splash Screen** - Verificación de sesión
2. **Login** - Inicio de sesión
3. **Registro** - Crear cuenta nueva
4. **Dashboard** - Resumen y estadísticas
5. **Lista de Tareas** - Ver todas las tareas con filtros
6. **Detalle de Tarea** - Ver información completa
7. **Formulario de Tarea** - Crear/Editar tarea

## 🧪 Pruebas

### Testear Backend
```bash
# Usar Postman, Insomnia o curl
# Ver ejemplos en backend/README.md
curl http://localhost:3000
```

### Testear Flutter
```bash
flutter test
flutter run    # Ejecutar en emulador/dispositivo
```

## 🐛 Troubleshooting Común

### Backend no conecta a MySQL
- Verifica que MySQL esté corriendo
- Revisa credenciales en `.env`
- Asegúrate que la base de datos existe

### Flutter no conecta al backend
- Verifica que el backend esté corriendo
- Usa `http://10.0.2.2:3000` para Android emulator
- Usa IP local para dispositivo físico

### Error de clima no carga
- Verifica tu API key de OpenWeather
- La app funciona sin esta característica

## 📈 Mejoras Futuras

- [ ] Tests unitarios y de integración
- [ ] Notificaciones push
- [ ] Modo offline con sincronización
- [ ] Adjuntar archivos a tareas
- [ ] Compartir tareas entre usuarios
- [ ] Temas claro/oscuro
- [ ] Múltiples idiomas

## 👨‍💻 Desarrollo

Desarrollado como proyecto completo full-stack incluyendo:
- Diseño de base de datos
- API REST con mejores prácticas
- Aplicación móvil nativa
- Documentación completa

## 📄 Licencia

MIT License - Libre para uso educativo y comercial

---

**Nota**: Este es un proyecto completo funcional listo para desarrollo/demostración. Asegúrate de cambiar las claves secretas y configuraciones antes de usar en producción.
