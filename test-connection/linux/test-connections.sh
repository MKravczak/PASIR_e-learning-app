#!/bin/bash

echo "Testowanie połączeń między kontenerami..."

# Tablica serwisów do testowania
services=("user-service:8081" "flashcard-service:8082" "quiz-service:8083" "group-service:8084" "api-gateway:8080")

# Sprawdzenie połączenia każdego serwisu z każdym innym
for source in "${services[@]}"; do
  src_name=$(echo $source | cut -d: -f1)
  
  for target in "${services[@]}"; do
    tgt_name=$(echo $target | cut -d: -f1)
    
    if [ "$src_name" != "$tgt_name" ]; then
      echo "Sprawdzam połączenie z $src_name do $tgt_name..."
      docker compose exec $src_name ping -c 1 $tgt_name
    fi
  done
done

echo "Testowanie połączeń z bazą danych..."
for service in "${services[@]}"; do
  srv_name=$(echo $service | cut -d: -f1)
  echo "Sprawdzam połączenie z $srv_name do postgres..."
  docker compose exec $srv_name ping -c 1 postgres
done

echo "Testy zakończone." 