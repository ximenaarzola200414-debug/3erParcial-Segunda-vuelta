# Script de Prueba: ACTUALIZAR TAREA
Write-Host "==================================" -ForegroundColor Cyan
Write- Host "PRUEBA 4: ACTUALIZAR TAREA" -ForegroundColor Yellow
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Login
$headers = @{"Content-Type" = "application/json" }
$body = @{email = "xime@icloud.com"; password = "123456" } | ConvertTo-Json
$loginResponse = Invoke-WebRequest -Uri "http://localhost:3000/auth/login" -Method POST -Headers $headers -Body $body -UseBasicParsing
$token = ($loginResponse.Content | ConvertFrom-Json).data.token

Write-Host "Token obtenido: $($token.Substring(0,20))..." -ForegroundColor Gray
Write-Host ""

# IMPORTANTE: Cambiar este ID por el ID de una tarea existente
$taskId = 1

Write-Host "Endpoint: PUT http://localhost:3000/tasks/$taskId" -ForegroundColor Green
Write-Host ""

$updateData = @{
    estado = "hecha"
    titulo = "Tarea actualizada desde API - EVIDENCIA"
} | ConvertTo-Json

Write-Host "Body enviado:" -ForegroundColor Magenta
Write-Host $updateData
Write-Host ""
Write-Host "Respuesta:" -ForegroundColor Magenta

try {
    $headers = @{
        "Authorization" = "Bearer $token"
        "Content-Type"  = "application/json"
    }
    $response = Invoke-WebRequest -Uri "http://localhost:3000/tasks/$taskId" -Method PUT -Headers $headers -Body $updateData -UseBasicParsing
    $jsonResponse = $response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
    Write-Host $jsonResponse -ForegroundColor Green
    Write-Host ""
    Write-Host "✅ Tarea actualizada exitosamente!" -ForegroundColor Green
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
