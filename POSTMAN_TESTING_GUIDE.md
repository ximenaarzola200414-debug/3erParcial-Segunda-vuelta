# Task Manager API - Postman Testing Guide

## 🎯 Objective
Test all endpoints of the Task Manager REST API to verify backend functionality and capture screenshots as evidence.

---

## 📋 Prerequisites

- Postman installed and open
- Backend server running at `http://localhost:3000`
- MySQL database running with test data
- Test credentials: `xime@icloud.com` / `123456`

---

## 🚀 Testing Instructions

### TEST 1: LOGIN (Authentication)

**Purpose:** Authenticate user and obtain JWT token

**Configuration:**
1. **Method:** POST
2. **URL:** `http://localhost:3000/auth/login`
3. **Headers:**
   - Click "Headers" tab
   - Add: `Content-Type` = `application/json`
4. **Body:**
   - Click "Body" tab
   - Select "raw"
   - Select "JSON" from dropdown
   - Paste this JSON:
   ```json
   {
     "email": "xime@icloud.com",
     "password": "123456"
   }
   ```
5. **Execute:** Click "Send" button

**Expected Response (200 OK):**
```json
{
  "success": true,
  "message": "Login exitoso",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": 1,
      "nombre": "Ximena",
      "email": "xime@icloud.com"
    }
  }
}
```

**IMPORTANT:** Copy the `token` value from the response. You'll need it for all subsequent requests.

**Screenshot:** Capture showing request configuration and successful response with token.

---

### TEST 2: GET ALL TASKS

**Purpose:** Retrieve all tasks for the authenticated user

**Configuration:**
1. **Method:** GET
2. **URL:** `http://localhost:3000/tasks`
3. **Headers:**
   - `Content-Type` = `application/json`
   - `Authorization` = `Bearer YOUR_TOKEN_HERE` (paste the token from login)
4. **Body:** None (leave empty)
5. **Execute:** Click "Send"

**Expected Response (200 OK):**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "user_id": 1,
      "titulo": "Sample Task",
      "descripcion": "Task description",
      "prioridad": "alta",
      "estado": "pendiente",
      "fecha_creacion": "2024-01-08T12:00:00.000Z",
      "fecha_limite": "2024-02-01",
      "updated_at": "2024-01-08T12:00:00.000Z"
    }
  ]
}
```

**Screenshot:** Capture showing the Authorization header with token and the array of tasks in response.

---

### TEST 3: CREATE NEW TASK

**Purpose:** Create a new task via POST request

**Configuration:**
1. **Method:** POST
2. **URL:** `http://localhost:3000/tasks`
3. **Headers:**
   - `Content-Type` = `application/json`
   - `Authorization` = `Bearer YOUR_TOKEN_HERE`
4. **Body (raw JSON):**
   ```json
   {
     "titulo": "API Test Task - Created from Postman",
     "descripcion": "This task demonstrates the POST /tasks endpoint functionality",
     "prioridad": "alta",
     "estado": "pendiente",
     "fecha_limite": "2024-03-01"
   }
   ```
5. **Execute:** Click "Send"

**Expected Response (201 Created):**
```json
{
  "success": true,
  "message": "Tarea creada exitosamente",
  "data": {
    "id": 10,
    "user_id": 1,
    "titulo": "API Test Task - Created from Postman",
    "descripcion": "This task demonstrates the POST /tasks endpoint functionality",
    "prioridad": "alta",
    "estado": "pendiente",
    "fecha_creacion": "2024-01-08T...",
    "fecha_limite": "2024-03-01",
    "updated_at": "2024-01-08T..."
  }
}
```

**Note:** Save the `id` from the response for the next tests.

**Screenshot:** Capture showing request body and successful creation response.

---

### TEST 4: GET SPECIFIC TASK

**Purpose:** Retrieve details of a single task by ID

**Configuration:**
1. **Method:** GET
2. **URL:** `http://localhost:3000/tasks/1` (replace 1 with an existing task ID)
3. **Headers:**
   - `Content-Type` = `application/json`
   - `Authorization` = `Bearer YOUR_TOKEN_HERE`
4. **Body:** None
5. **Execute:** Click "Send"

**Expected Response (200 OK):**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "user_id": 1,
    "titulo": "Task title",
    "descripcion": "Task description",
    "prioridad": "alta",
    "estado": "pendiente",
    "fecha_creacion": "2024-01-08T...",
    "fecha_limite": "2024-02-01",
    "updated_at": "2024-01-08T..."
  }
}
```

**Screenshot:** Capture showing the specific task data.

---

### TEST 5: UPDATE TASK

**Purpose:** Update an existing task's properties

**Configuration:**
1. **Method:** PUT
2. **URL:** `http://localhost:3000/tasks/1` (use existing task ID)
3. **Headers:**
   - `Content-Type` = `application/json`
   - `Authorization` = `Bearer YOUR_TOKEN_HERE`
4. **Body (raw JSON):**
   ```json
   {
     "estado": "hecha",
     "titulo": "Updated Task - Modified via Postman API"
   }
   ```
5. **Execute:** Click "Send"

**Expected Response (200 OK):**
```json
{
  "success": true,
  "message": "Tarea actualizada exitosamente",
  "data": {
    "id": 1,
    "user_id": 1,
    "titulo": "Updated Task - Modified via Postman API",
    "descripcion": "...",
    "prioridad": "alta",
    "estado": "hecha",
    "fecha_creacion": "2024-01-08T...",
    "fecha_limite": "2024-02-01",
    "updated_at": "2024-01-08T..." // This timestamp should be updated
  }
}
```

**Screenshot:** Capture showing the update request and modified task in response.

---

### TEST 6: DELETE TASK

**Purpose:** Delete a task permanently

**Configuration:**
1. **Method:** DELETE
2. **URL:** `http://localhost:3000/tasks/5` (use an existing task ID you want to delete)
3. **Headers:**
   - `Content-Type` = `application/json`
   - `Authorization` = `Bearer YOUR_TOKEN_HERE`
4. **Body:** None
5. **Execute:** Click "Send"

**Expected Response (200 OK):**
```json
{
  "success": true,
  "message": "Tarea eliminada exitosamente"
}
```

**Screenshot:** Capture showing successful deletion.

---

### TEST 7: FILTER TASKS BY STATUS

**Purpose:** Test query parameter filtering

**Configuration:**
1. **Method:** GET
2. **URL:** `http://localhost:3000/tasks?estado=pendiente`
3. **Headers:**
   - `Content-Type` = `application/json`
   - `Authorization` = `Bearer YOUR_TOKEN_HERE`
4. **Body:** None
5. **Execute:** Click "Send"

**Other filter examples:**
- By priority: `http://localhost:3000/tasks?prioridad=alta`
- By search: `http://localhost:3000/tasks?search=proyecto`
- Combined: `http://localhost:3000/tasks?estado=pendiente&prioridad=alta`

**Expected Response (200 OK):**
```json
{
  "success": true,
  "data": [
    // Only tasks with estado="pendiente"
  ]
}
```

**Screenshot:** Capture showing filtered results.

---

## 📸 Screenshot Checklist

Capture at least these 6 screenshots:

- [ ] **Test 1:** LOGIN - Shows successful authentication with JWT token
- [ ] **Test 2:** GET ALL TASKS - Shows array of tasks
- [ ] **Test 3:** CREATE TASK - Shows new task created
- [ ] **Test 5:** UPDATE TASK - Shows task modification
- [ ] **Test 6:** DELETE TASK - Shows successful deletion
- [ ] **Test 7:** FILTER - Shows filtered results

---

## 🎯 Tips for Good Screenshots

1. **Full Postman Window:** Capture the entire Postman interface
2. **Show Request Details:** Make sure URL, Method, Headers, and Body are visible
3. **Show Response:** Ensure the response panel shows the JSON and status code (200, 201, etc.)
4. **Highlight Token:** In Test 1, make sure the token is visible
5. **Highlight Authorization:** In other tests, show the Authorization header

---

## ⚠️ Common Issues

**401 Unauthorized Error:**
- Your token expired or is invalid
- Solution: Run Test 1 again to get a fresh token
- Copy the new token to the Authorization header

**404 Not Found:**
- The task ID doesn't exist
- Solution: First run GET /tasks to see available IDs

**500 Internal Server Error:**
- Backend or database problem
- Solution: Check that backend is running and MySQL is connected

---

## 🔑 Quick Copy-Paste Values

**Authorization Header:**
```
Authorization: Bearer YOUR_TOKEN_FROM_LOGIN
```

**Content-Type Header:**
```
Content-Type: application/json
```

**Test Credentials:**
```json
{
  "email": "xime@icloud.com",
  "password": "123456"
}
```

---

## ✅ Success Criteria

All requests should return:
- HTTP Status: 200 OK or 201 Created
- Response body contains: `"success": true`
- No error messages in response

---

**Good luck testing! 🚀**
