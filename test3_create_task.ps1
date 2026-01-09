# Script de Prueba: CREAR NUEVA TAREA
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "PRUEBA 3: CREAR NUEVA TAREA" -ForegroundColor Yellow
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Primero login
$headers = @{"Content-Type" = "application/json" }
$body = @{email = "xime@icloud.com"; password = "123456" } | ConvertTo-Json
$loginResponse = Invoke-WebRequest -Uri "http://localhost:3000/auth/login" -Method POST -Headers $headers -Body $body -UseBasicParsing
$token = ($loginResponse.Content | ConvertFrom-Json).data.token

Write-Host "Token obtenido: $($token.Substring(0,20))..." -ForegroundColor Gray
Write-Host ""
Write-Host "Endpoint: POST http://localhost:3000/tasks" -ForegroundColor Green
Write-Host ""

$newTask = @{
    titulo       = "Tarea de prueba creada desde API"
    descripcion  = "Esta tarea demuestra el funcionamiento del endpoint POST /tasks"
    prioridad    = "alta"
    estado       = "pendiente"
    fecha_limite = "2024-03-01"
} | ConvertTo-Json

Write-Host "Body enviado:" -ForegroundColor Magenta
Write-Host $newTask
Write-Host ""
Write-Host "Respuesta:" -ForegroundColor Magenta

try {
    $headers = @{
        "Authorization" = "Bearer $token"
        "Content-Type"  = "application/json"
    }
    $response = Invoke-WebRequest -Uri "http://localhost:3000/tasks" -Method POST -Headers $headers -Body $newTask -UseBasicParsing
    $jsonResponse = $response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
    Write-Host $jsonResponse -ForegroundColor Green
    Write-Host ""
    Write-Host "✅ Tarea creada exitosamente!" -ForegroundColor Green
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
