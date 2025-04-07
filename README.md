# Platforma E-learningowa

Aplikacja umożliwiająca tworzenie, udostępnianie i rozwiązywanie quizów edukacyjnych oraz zarządzanie zestawami fiszek.

## Struktura projektu

Projekt składa się z następujących mikrousług:

- **User Service** - Zarządzanie użytkownikami, autoryzacja i uwierzytelnianie
- **Flashcard Service** - Tworzenie i zarządzanie fiszkami do nauki
- **Quiz Service** - Tworzenie, zarządzanie i rozwiązywanie quizów
- **Group Service** - Zarządzanie grupami i udostępnianie materiałów edukacyjnych
- **API Gateway** - Punkt wejścia do aplikacji, przekierowuje żądania do odpowiednich usług
- **Frontend** - Interfejs użytkownika podzielony na dwie części:
  - React - Panel użytkownika i zarządzanie kontem
  - Vue - Interaktywne części aplikacji (rozwiązywanie quizów)

## Wymagania

- Docker
- Docker Compose

## Uruchomienie projektu

1. Sklonuj repozytorium projektu:

```bash
git clone [adres_repozytorium]
cd [nazwa_katalogu]
```

2. Uruchom projekt za pomocą Docker Compose:

```bash
docker-compose up -d
```

3. Dostęp do aplikacji:
   - Panel użytkownika: http://localhost:3000/app
   - Rozwiązywanie quizów: http://localhost:3000/quiz
   - API: http://localhost:8080/api

## Baza danych

Aplikacja korzysta z bazy danych PostgreSQL podzielonej na schematy dla każdej z usług:
- **users** - dane użytkowników, role i sesje
- **flashcards** - zestawy fiszek i pojedyncze fiszki
- **quizzes** - quizy, pytania i wyniki
- **groups** - grupy i powiązane materiały edukacyjne

## Rozwój projektu

Każda mikrousługa znajduje się w osobnym katalogu i może być rozwijana niezależnie. Aby rozpocząć pracę nad konkretną usługą:

1. Przejdź do katalogu usługi
2. Zmodyfikuj kod źródłowy
3. Zbuduj i uruchom usługę za pomocą Docker Compose

```bash
docker-compose up -d --build [nazwa_usługi]
``` 