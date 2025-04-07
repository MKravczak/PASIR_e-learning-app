# Test połączeń między kontenerami w środowisku Docker

Write-Host "Testowanie połączeń między kontenerami..." -ForegroundColor Cyan

# Tablica serwisów do testowania
$services = @(
    "user-service:8081",
    "flashcard-service:8082",
    "quiz-service:8083",
    "group-service:8084",
    "api-gateway:8080"
)

# Sprawdzenie połączenia każdego serwisu z każdym innym
foreach ($source in $services) {
    $src_name = $source.Split(':')[0]
    
    foreach ($target in $services) {
        $tgt_name = $target.Split(':')[0]
        
        if ($src_name -ne $tgt_name) {
            Write-Host "Sprawdzam połączenie z $src_name do $tgt_name..." -ForegroundColor Yellow
            docker compose exec $src_name ping -c 1 $tgt_name
        }
    }
}

Write-Host "Testowanie połączeń z bazą danych..." -ForegroundColor Cyan
foreach ($service in $services) {
    $srv_name = $service.Split(':')[0]
    Write-Host "Sprawdzam połączenie z $srv_name do postgres..." -ForegroundColor Yellow
    docker compose exec $srv_name ping -c 1 postgres
}

Write-Host "Testy zakończone." -ForegroundColor Green 