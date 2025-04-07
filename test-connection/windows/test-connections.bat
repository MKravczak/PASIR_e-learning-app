@echo off
setlocal EnableDelayedExpansion

echo Testowanie połączeń między kontenerami...

:: Definicja serwisów i portów
set services[0]=user-service:8081
set services[1]=flashcard-service:8082
set services[2]=quiz-service:8083
set services[3]=group-service:8084
set services[4]=api-gateway:8080
set count=5

:: Testowanie połączeń między każdą parą serwisów
for /L %%i in (0,1,%count%-1) do (
    for /f "tokens=1,2 delims=:" %%a in ("!services[%%i]!") do (
        set source_name=%%a
        
        for /L %%j in (0,1,%count%-1) do (
            for /f "tokens=1,2 delims=:" %%c in ("!services[%%j]!") do (
                set target_name=%%c
                
                if not "!source_name!"=="!target_name!" (
                    echo Sprawdzam połączenie z !source_name! do !target_name!...
                    docker compose exec !source_name! ping -c 1 !target_name!
                )
            )
        )
    )
)

:: Testowanie połączeń do bazy danych
echo Testowanie połączeń z bazą danych...
for /L %%i in (0,1,%count%-1) do (
    for /f "tokens=1,2 delims=:" %%a in ("!services[%%i]!") do (
        set service_name=%%a
        echo Sprawdzam połączenie z !service_name! do postgres...
        docker compose exec !service_name! ping -c 1 postgres
    )
)

echo Testy zakończone.
endlocal 