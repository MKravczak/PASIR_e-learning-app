@echo off
setlocal EnableDelayedExpansion

echo Testowanie połączeń na poziomie portów...

:: Instalacja netcat w kontenerach
echo Instalacja netcat w kontenerach...
for %%s in (user-service flashcard-service quiz-service group-service api-gateway) do (
    echo Instalacja w %%s...
    docker compose exec %%s apt-get update -qq
    docker compose exec %%s apt-get install -qq -y netcat
)

:: Definicja serwisów i portów
set services[0]=user-service:8081
set services[1]=flashcard-service:8082
set services[2]=quiz-service:8083
set services[3]=group-service:8084
set services[4]=api-gateway:8080
set count=5

:: Testowanie połączeń między każdą parą serwisów na poziomie portów
for /L %%i in (0,1,%count%-1) do (
    for /f "tokens=1,2 delims=:" %%a in ("!services[%%i]!") do (
        set source_name=%%a
        
        for /L %%j in (0,1,%count%-1) do (
            for /f "tokens=1,2 delims=:" %%c in ("!services[%%j]!") do (
                set target_name=%%c
                set target_port=%%d
                
                if not "!source_name!"=="!target_name!" (
                    echo Sprawdzam połączenie z !source_name! do !target_name! na porcie !target_port!...
                    docker compose exec !source_name! nc -zv !target_name! !target_port!
                )
            )
        )
    )
)

:: Testowanie połączeń do bazy danych na porcie 5432
echo Testowanie połączeń do bazy danych na porcie 5432...
for /L %%i in (0,1,%count%-1) do (
    for /f "tokens=1,2 delims=:" %%a in ("!services[%%i]!") do (
        set service_name=%%a
        echo Sprawdzam połączenie z !service_name! do postgres:5432...
        docker compose exec !service_name! nc -zv postgres 5432
    )
)

echo Testy zakończone.
endlocal 