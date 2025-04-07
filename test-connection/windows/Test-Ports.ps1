# Test połączeń na poziomie portów między kontenerami w środowisku Docker

Write-Host "Testowanie połączeń na poziomie portów..." -ForegroundColor Cyan

# Instalacja netcat w kontenerach
Write-Host "Instalacja netcat w kontenerach..." -ForegroundColor Yellow
$services = @("user-service", "flashcard-service", "quiz-service", "group-service", "api-gateway")
foreach ($service in $services) {
    Write-Host "Instalacja w $service..." -ForegroundColor Gray
    docker compose exec $service apt-get update -qq
    docker compose exec $service apt-get install -qq -y netcat
}

# Tablica serwisów i portów do testowania
$services = @(
    "user-service:8081",
    "flashcard-service:8082",
    "quiz-service:8083",
    "group-service:8084",
    "api-gateway:8080"
)

# Sprawdzenie połączenia każdego serwisu z każdym innym na poziomie portów
foreach ($source in $services) {
    $src_name = $source.Split(':')[0]
    
    foreach ($target in $services) {
        $tgt_name = $target.Split(':')[0]
        $tgt_port = $target.Split(':')[1]
        
        if ($src_name -ne $tgt_name) {
            Write-Host "Sprawdzam połączenie z $src_name do $tgt_name na porcie $tgt_port..." -ForegroundColor Yellow
            docker compose exec $src_name nc -zv $tgt_name $tgt_port
        }
    }
}

Write-Host "Testowanie połączeń do bazy danych na porcie 5432..." -ForegroundColor Cyan
foreach ($service in $services) {
    $srv_name = $service.Split(':')[0]
    Write-Host "Sprawdzam połączenie z $srv_name do postgres:5432..." -ForegroundColor Yellow
    docker compose exec $srv_name nc -zv postgres 5432
}

Write-Host "Testy zakończone." -ForegroundColor Green 