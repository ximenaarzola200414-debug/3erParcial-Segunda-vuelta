# Task Manager Backend API

API REST para gestión de tareas con autenticación JWT y MySQL.

## 📋 Requisitos

- Node.js >= 14.x
- MySQL >= 5.7 o MariaDB
- npm o yarn

## 🚀 Instalación

1. **Clonar el repositorio e ingresar al directorio backend:**
   ```bash
   cd backend
   ```

2. **Instalar dependencias:**
   ```bash
   npm install
   ```

3. **Configurar base de datos:**
   
   Crear base de datos en MySQL:
   ```bash
   mysql -u root -p < database.sql
   ```
   
   O ejecutar manualmente:
   ```sql
   CREATE DATABASE task_manager_db;
   USE task_manager_db;
   -- (copiar el resto del contenido de database.sql)
   ```

4. **Configurar variables de entorno:**
   
   Copiar el archivo de ejemplo y editarlo:
   ```bash
   copy .env.example .env
   ```
   
   Editar `.env` con tus credenciales:
   ```
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=tu_password
   DB_NAME=task_manager_db
   DB_PORT=3306
   JWT_SECRET=tu_clave_secreta_super_segura
   PORT=3000
   ```

5. **Iniciar el servidor:**
   
   Modo desarrollo (con auto-reload):
   ```bash
   npm run dev
   ```
   
   Modo producción:
   ```bash
   npm start
   ```

El servidor estará disponible en `http://localhost:3000`

## 📚 Endpoints de la API

### Base URL
```
http://localhost:3000
```

### Autenticación

#### Registrar usuario
```http
POST /auth/register
Content-Type: application/json

{
  "nombre": "Juan Pérez",
  "email": "juan@example.com",
  "password": "123456"
}
```

**Respuesta exitosa (201):**
```json
{
  "success": true,
  "message": "Usuario registrado exitosamente",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "nombre": "Juan Pérez",
      "email": "juan@example.com"
    }
  }
}
```

#### Iniciar sesión
```http
POST /auth/login
Content-Type: application/json

{
  "email": "juan@example.com",
  "password": "123456"
}
```

**Respuesta exitosa (200):**
```json
{
  "success": true,
  "message": "Login exitoso",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "nombre": "Juan Pérez",
      "email": "juan@example.com"
    }
  }
}
```

---

### Tareas (Requieren autenticación)

**Headers requeridos:**
```
Authorization: Bearer <token>
```

#### Obtener todas las tareas
```http
GET /tasks
```

**Filtros opcionales (query params):**
- `estado`: pendiente | en progreso | hecha
- `prioridad`: alta | media | baja
- `search`: búsqueda en título y descripción

**Ejemplos:**
```
GET /tasks?estado=pendiente
GET /tasks?prioridad=alta
GET /tasks?search=proyecto
GET /tasks?estado=en%20progreso&prioridad=alta
```

**Respuesta exitosa (200):**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "user_id": 1,
      "titulo": "Completar proyecto",
      "descripcion": "Finalizar la documentación",
      "prioridad": "alta",
      "estado": "en progreso",
      "fecha_creacion": "2024-01-08T06:00:00.000Z",
      "fecha_limite": "2024-01-15",
      "updated_at": "2024-01-08T06:00:00.000Z"
    }
  ]
}
```

#### Crear nueva tarea
```http
POST /tasks
Content-Type: application/json

{
  "titulo": "Nueva tarea",
  "descripcion": "Descripción de la tarea",
  "prioridad": "alta",
  "estado": "pendiente",
  "fecha_limite": "2024-02-01"
}
```

**Respuesta exitosa (201):**
```json
{
  "success": true,
  "message": "Tarea creada exitosamente",
  "data": {
    "id": 5,
    "user_id": 1,
    "titulo": "Nueva tarea",
    "descripcion": "Descripción de la tarea",
    "prioridad": "alta",
    "estado": "pendiente",
    "fecha_creacion": "2024-01-08T06:13:00.000Z",
    "fecha_limite": "2024-02-01",
    "updated_at": "2024-01-08T06:13:00.000Z"
  }
}
```

#### Obtener tarea específica
```http
GET /tasks/:id
```

**Respuesta exitosa (200):**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "user_id": 1,
    "titulo": "Completar proyecto",
    "descripcion": "Finalizar la documentación",
    "prioridad": "alta",
    "estado": "en progreso",
    "fecha_creacion": "2024-01-08T06:00:00.000Z",
    "fecha_limite": "2024-01-15",
    "updated_at": "2024-01-08T06:00:00.000Z"
  }
}
```

#### Actualizar tarea
```http
PUT /tasks/:id
Content-Type: application/json

{
  "titulo": "Tarea actualizada",
  "estado": "hecha"
}
```

**Nota:** Solo enviar los campos que se desean actualizar.

**Respuesta exitosa (200):**
```json
{
  "success": true,
  "message": "Tarea actualizada exitosamente",
  "data": {
    "id": 1,
    "user_id": 1,
    "titulo": "Tarea actualizada",
    "descripcion": "Finalizar la documentación",
    "prioridad": "alta",
    "estado": "hecha",
    "fecha_creacion": "2024-01-08T06:00:00.000Z",
    "fecha_limite": "2024-01-15",
    "updated_at": "2024-01-08T06:15:00.000Z"
  }
}
```

#### Eliminar tarea
```http
DELETE /tasks/:id
```

**Respuesta exitosa (200):**
```json
{
  "success": true,
  "message": "Tarea eliminada exitosamente"
}
```

---

## 🔧 Códigos de error

- **400 Bad Request**: Datos inválidos o faltantes
- **401 Unauthorized**: Token inválido, expirado o no proporcionado
- **404 Not Found**: Recurso no encontrado
- **500 Internal Server Error**: Error del servidor

**Formato de error:**
```json
{
  "success": false,
  "message": "Descripción del error"
}
```

---

## 👤 Credenciales de prueba

El script `database.sql` incluye un usuario de prueba:

```
Email: test@test.com
Password: test123
```

---

## 📁 Estructura del proyecto

```
backend/
├── src/
│   ├── config/
│   │   └── db.js              # Configuración MySQL
│   ├── controllers/
│   │   ├── authController.js  # Lógica de autenticación
│   │   └── taskController.js  # Lógica de tareas
│   ├── middleware/
│   │   └── auth.js            # Middleware JWT
│   ├── routes/
│   │   ├── auth.js            # Rutas de autenticación
│   │   └── tasks.js           # Rutas de tareas
│   └── index.js               # Servidor Express
├── .env                       # Variables de entorno (NO commitear)
├── .env.example               # Ejemplo de variables
├── database.sql               # Schema de base de datos
├── package.json
└── README.md
```

---

## 🔒 Seguridad

- Las contraseñas se hashean con bcrypt (10 rounds)
- JWT con expiración de 7 días
- Validación de inputs en todos los endpoints
- Las tareas solo son accesibles por su propietario
- CORS habilitado para desarrollo

---

## 🧪 Pruebas con Postman/Thunder Client

1. Importar colección (opcional) o probar manualmente
2. Registrar un usuario nuevo o usar credenciales de prueba
3. Copiar el token de la respuesta
4. Usar el token en el header `Authorization: Bearer <token>` para endpoints protegidos

---

## 📝 Notas técnicas

- **Base de datos**: MySQL con pool de conexiones
- **Autenticación**: JWT almacenado en el cliente
- **Encriptación**: bcryptjs para passwords
- **Validación**: Manual en controladores
- **Logs**: Console.log básico (mejorar en producción)

---

## 🐛 Troubleshooting

**Error: "Cannot connect to MySQL"**
- Verificar que MySQL esté corriendo
- Verificar credenciales en `.env`
- Verificar que la base de datos exista

**Error: "JWT_SECRET is not defined"**
- Asegurarse de que el archivo `.env` existe
- Verificar que JWT_SECRET tenga un valor

**Error 401 en endpoints protegidos**
- Verificar que el token sea válido
- Verificar formato del header: `Authorization: Bearer <token>`
- El token expira en 7 días, generar uno nuevo si es necesario
