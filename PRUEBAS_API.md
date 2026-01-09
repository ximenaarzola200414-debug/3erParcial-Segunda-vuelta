# Pruebas del Backend API - Task Manager

## 🔐 Credenciales de Prueba
```
Email: xime@icloud.com
Password: 123456
```

---

## 📝 INSTRUCCIONES PARA CAPTURAS

Para cada prueba:
1. Copia el comando de PowerShell
2. Pégalo en una terminal nueva
3. Toma captura de pantalla mostrando el comando Y la respuesta JSON
4. La respuesta debe mostrar `"success": true` y los datos

---

## 1️⃣ PRUEBA: LOGIN (Autenticación)

**Endpoint:** `POST /auth/login`

**Comando PowerShell:**
```powershell
$response = Invoke-WebRequest -Uri "http://localhost:3000/auth/login" -Method POST -Headers @{"Content-Type"="application/json"} -Body '{"email":"xime@icloud.com","password":"123456"}' -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
```

**Respuesta Esperada:**
```json
{
  "success": true,
  "message": "Login exitoso",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": X,
      "nombre": "Ximena",
      "email": "xime@icloud.com"
    }
  }
}
```

---

## 2️⃣ PRUEBA: OBTENER TODAS LAS TAREAS

**Endpoint:** `GET /tasks`

**IMPORTANTE:** Primero ejecuta el login (comando anterior) para obtener el token, luego copia el token y reemplaza `TU_TOKEN_AQUI` en el siguiente comando.

**Comando PowerShell:**
```powershell
$token = "TU_TOKEN_AQUI"
$response = Invoke-WebRequest -Uri "http://localhost:3000/tasks" -Method GET -Headers @{"Authorization"="Bearer $token";"Content-Type"="application/json"} -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
```

**Respuesta Esperada:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "user_id": X,
      "titulo": "Nombre de la tarea",
      "descripcion": "...",
      "prioridad": "alta|media|baja",
      "estado": "pendiente|en progreso|hecha",
      "fecha_creacion": "2024-XX-XX...",
      "fecha_limite": "2024-XX-XX",
      "updated_at": "2024-XX-XX..."
    }
  ]
}
```

---

## 3️⃣ PRUEBA: CREAR NUEVA TAREA

**Endpoint:** `POST /tasks`

**Comando PowerShell:**
```powershell
$token = "TU_TOKEN_AQUI"
$body = @{
    titulo = "Tarea de prueba API"
    descripcion = "Esta tarea fue creada para probar el endpoint POST /tasks"
    prioridad = "alta"
    estado = "pendiente"
    fecha_limite = "2024-02-15"
} | ConvertTo-Json

$response = Invoke-WebRequest -Uri "http://localhost:3000/tasks" -Method POST -Headers @{"Authorization"="Bearer $token";"Content-Type"="application/json"} -Body $body -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
```

**Respuesta Esperada:**
```json
{
  "success": true,
  "message": "Tarea creada exitosamente",
  "data": {
    "id": XX,
    "user_id": X,
    "titulo": "Tarea de prueba API",
    "descripcion": "Esta tarea fue creada para probar el endpoint POST /tasks",
    "prioridad": "alta",
    "estado": "pendiente",
    "fecha_creacion": "2024-XX-XX...",
    "fecha_limite": "2024-02-15",
    "updated_at": "2024-XX-XX..."
  }
}
```

---

## 4️⃣ PRUEBA: OBTENER TAREA ESPECÍFICA

**Endpoint:** `GET /tasks/:id`

**Comando PowerShell:**
```powershell
$token = "TU_TOKEN_AQUI"
$taskId = 1  # Reemplazar con ID de tarea existente
$response = Invoke-WebRequest -Uri "http://localhost:3000/tasks/$taskId" -Method GET -Headers @{"Authorization"="Bearer $token";"Content-Type"="application/json"} -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
```

---

## 5️⃣ PRUEBA: ACTUALIZAR TAREA

**Endpoint:** `PUT /tasks/:id`

**Comando PowerShell:**
```powershell
$token = "TU_TOKEN_AQUI"
$taskId = 1  # Reemplazar con ID de tarea existente
$body = @{
    estado = "hecha"
    titulo = "Tarea actualizada desde API"
} | ConvertTo-Json

$response = Invoke-WebRequest -Uri "http://localhost:3000/tasks/$taskId" -Method PUT -Headers @{"Authorization"="Bearer $token";"Content-Type"="application/json"} -Body $body -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
```

**Respuesta Esperada:**
```json
{
  "success": true,
  "message": "Tarea actualizada exitosamente",
  "data": {
    "id": 1,
    "estado": "hecha",
    "titulo": "Tarea actualizada desde API",
    ...
  }
}
```

---

## 6️⃣ PRUEBA: ELIMINAR TAREA

**Endpoint:** `DELETE /tasks/:id`

**Comando PowerShell:**
```powershell
$token = "TU_TOKEN_AQUI"
$taskId = 5  # Reemplazar con ID de tarea a eliminar
$response = Invoke-WebRequest -Uri "http://localhost:3000/tasks/$taskId" -Method DELETE -Headers @{"Authorization"="Bearer $token";"Content-Type"="application/json"} -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
```

**Respuesta Esperada:**
```json
{
  "success": true,
  "message": "Tarea eliminada exitosamente"
}
```

---

## 7️⃣ PRUEBA: FILTROS DE TAREAS

**Por estado:**
```powershell
$token = "TU_TOKEN_AQUI"
$response = Invoke-WebRequest -Uri "http://localhost:3000/tasks?estado=pendiente" -Method GET -Headers @{"Authorization"="Bearer $token";"Content-Type"="application/json"} -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
```

**Por prioridad:**
```powershell
$token = "TU_TOKEN_AQUI"
$response = Invoke-WebRequest -Uri "http://localhost:3000/tasks?prioridad=alta" -Method GET -Headers @{"Authorization"="Bearer $token";"Content-Type"="application/json"} -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
```

**Búsqueda por texto:**
```powershell
$token = "TU_TOKEN_AQUI"
$response = Invoke-WebRequest -Uri "http://localhost:3000/tasks?search=prueba" -Method GET -Headers @{"Authorization"="Bearer $token";"Content-Type"="application/json"} -UseBasicParsing
$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
```

---

## ✅ LISTA DE CAPTURAS NECESARIAS

1. ✅ Login exitoso (muestra token)
2. ✅ GET todas las tareas
3. ✅ POST crear nueva tarea
4. ✅ GET tarea específica por ID
5. ✅ PUT actualizar tarea
6. ✅ DELETE eliminar tarea
7. ✅ Filtros funcionando (al menos 1 ejemplo)

---

## 📌 NOTAS

- El backend debe estar corriendo en `http://localhost:3000`
- Todas las peticiones a `/tasks/*` requieren el token JWT
- El token se obtiene del login y debe ir en el header `Authorization: Bearer TOKEN`
- Las respuestas con `"success": true` indican operación exitosa
- Guarda el token después del login para usarlo en las demás pruebas
