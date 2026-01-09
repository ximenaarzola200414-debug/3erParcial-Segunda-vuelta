# Script de Prueba: LOGIN
$headers = @{
    "Content-Type" = "application/json"
}

$body = @{
    email = "xime@icloud.com"
    password = "123456"
} | ConvertTo-Json

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "PRUEBA 1: LOGIN" -ForegroundColor Yellow
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Endpoint: POST http://localhost:3000/auth/login" -ForegroundColor Green
Write-Host ""
Write-Host "Body enviado:" -ForegroundColor Magenta
Write-Host $body
Write-Host ""
Write-Host "Respuesta:" -ForegroundColor Magenta

try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000/auth/login" -Method POST -Headers $headers -Body $body -UseBasicParsing
    $jsonResponse = $response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 5
    Write-Host $jsonResponse -ForegroundColor Green
    
    # Guardar token para próximas pruebas
    $responseObj = $response.Content | ConvertFrom-Json
    $global:authToken = $responseObj.data.token
    Write-Host ""
    Write-Host "✅ Login exitoso! Token guardado para próximas pruebas." -ForegroundColor Green
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
