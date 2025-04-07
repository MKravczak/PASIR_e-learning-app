# Skrypty do testowania połączeń między kontenerami Docker

W tym katalogu znajdują się skrypty służące do testowania połączeń między mikroserwisami umieszczonymi w kontenerach Docker. Skrypty są dostępne zarówno dla systemu Linux, jak i dla systemu Windows.

## Struktura katalogów

```
test-connection/
├── linux/              # Skrypty dla systemu Linux
│   ├── test-connections.sh   # Test połączeń między kontenerami (ping)
│   └── test-ports.sh         # Test połączeń między portami (netcat)
└── windows/            # Skrypty dla systemu Windows
    ├── Test-Connections.ps1  # PowerShell - test połączeń (ping)
    ├── Test-Ports.ps1        # PowerShell - test portów (netcat)
    ├── test-connections.bat  # Batch - test połączeń (ping)
    └── test-ports.bat        # Batch - test portów (netcat)
```

## Użycie skryptów w systemie Linux

1. Nadaj uprawnienia do wykonania skryptów:
   ```bash
   chmod +x linux/test-connections.sh linux/test-ports.sh
   ```

2. Uruchom test podstawowych połączeń:
   ```bash
   ./linux/test-connections.sh
   ```

3. Uruchom test połączeń na poziomie portów:
   ```bash
   ./linux/test-ports.sh
   ```

## Użycie skryptów w systemie Windows

### PowerShell

1. Uruchom PowerShell jako administrator
2. Upewnij się, że masz ustawioną odpowiednią politykę wykonywania skryptów:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

3. Uruchom test podstawowych połączeń:
   ```powershell
   .\windows\Test-Connections.ps1
   ```

4. Uruchom test połączeń na poziomie portów:
   ```powershell
   .\windows\Test-Ports.ps1
   ```

### Command Prompt (CMD)

1. Uruchom wiersz poleceń jako administrator
2. Przejdź do katalogu projektu
3. Uruchom test podstawowych połączeń:
   ```cmd
   windows\test-connections.bat
   ```

4. Uruchom test połączeń na poziomie portów:
   ```cmd
   windows\test-ports.bat
   ```

## Uwagi

- Skrypty wymagają, aby kontenery Docker były już uruchomione za pomocą `docker compose up -d`
- Skrypty automatycznie instalują potrzebne narzędzia (ping, netcat) w kontenerach
- W przypadku systemu Windows możesz napotkać problemy z uruchamianiem skryptów PowerShell. W takim przypadku musisz zmienić politykę wykonywania skryptów lub użyć skryptów batch (.bat) 