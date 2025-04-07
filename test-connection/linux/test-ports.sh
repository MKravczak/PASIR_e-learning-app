#!/bin/bash

echo "Testowanie połączeń na poziomie portów..."

# Instalacja netcat w kontenerach (jeśli jeszcze nie zainstalowano)
echo "Instalacja netcat w kontenerach..."
for service in user-service flashcard-service quiz-service group-service api-gateway; do
  docker compose exec $service apt-get update -qq
  docker compose exec $service apt-get install -qq -y netcat
done

# Tablica serwisów do testowania
services=("user-service:8081" "flashcard-service:8082" "quiz-service:8083" "group-service:8084" "api-gateway:8080")

# Sprawdzenie połączenia każdego serwisu z każdym innym na poziomie portów
for source in "${services[@]}"; do
  src_name=$(echo $source | cut -d: -f1)
  
  for target in "${services[@]}"; do
    tgt_name=$(echo $target | cut -d: -f1)
    tgt_port=$(echo $target | cut -d: -f2)
    
    if [ "$src_name" != "$tgt_name" ]; then
      echo "Sprawdzam połączenie z $src_name do $tgt_name:$tgt_port..."
      docker compose exec $src_name nc -zv $tgt_name $tgt_port
    fi
  done
done

echo "Testowanie połączeń do bazy danych na porcie 5432..."
for service in "${services[@]}"; do
  srv_name=$(echo $service | cut -d: -f1)
  echo "Sprawdzam połączenie z $srv_name do postgres:5432..."
  docker compose exec $srv_name nc -zv postgres 5432
done

echo "Testy zakończone." 