# Script de Prueba: OBTENER TODAS LAS TAREAS
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "PRUEBA 2: OBTENER TODAS LAS TAREAS" -ForegroundColor Yellow
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Primero ejecutar login para obtener token
$headers = @{"Content-Type" = "application/json" }
$body = @{email = "xime@icloud.com"; password = "123456" } | ConvertTo-Json
$loginResponse = Invoke-WebRequest -Uri "http://localhost:3000/auth/login" -Method POST -Headers $headers -Body $body -UseBasicParsing
$token = ($loginResponse.Content | ConvertFrom-Json).data.token

Write-Host "Token obtenido: $($token.Substring(0,20))..." -ForegroundColor Gray
Write-Host ""
Write-Host "Endpoint: GET http://localhost:3000/tasks" -ForegroundColor Green
Write-Host ""
Write-Host "Respuesta:" -ForegroundColor Magenta

try {
    $headers = @{
        "Authorization" = "Bearer $token"
        "Content-Type"  = "application/json"
    }
    $response = Invoke-WebRequest -Uri "http://localhost:3000/tasks" -Method GET -Headers $headers -UseBasicParsing
    $jsonResponse = $response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
    Write-Host $jsonResponse -ForegroundColor Green
    Write-Host ""
    Write-Host "✅ Tareas obtenidas exitosamente!" -ForegroundColor Green
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
