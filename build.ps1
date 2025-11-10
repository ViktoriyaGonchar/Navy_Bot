# Скрипт для сборки NaviBot
Write-Host "=== Сборка NaviBot ===" -ForegroundColor Green

# Проверяем наличие Rust
$rustc = Get-Command rustc -ErrorAction SilentlyContinue
if (-not $rustc) {
    Write-Host "ОШИБКА: Rust не установлен!" -ForegroundColor Red
    Write-Host "Установите Rust с https://rustup.rs/" -ForegroundColor Yellow
    Write-Host "После установки перезапустите терминал и запустите этот скрипт снова." -ForegroundColor Yellow
    exit 1
}

Write-Host "Rust найден: $($rustc.Version)" -ForegroundColor Green

# Проверяем наличие Tauri CLI
$tauri = Get-Command cargo -ErrorAction SilentlyContinue
if (-not $tauri) {
    Write-Host "ОШИБКА: Cargo не найден!" -ForegroundColor Red
    exit 1
}

Write-Host "Начинаем сборку..." -ForegroundColor Green
Write-Host "Это может занять несколько минут при первом запуске..." -ForegroundColor Yellow

# Переходим в папку src-tauri
Set-Location src-tauri

# Собираем проект
Write-Host "Запуск: cargo tauri build" -ForegroundColor Cyan
cargo tauri build

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "=== Сборка завершена успешно! ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "Инсталлятор находится в:" -ForegroundColor Yellow
    $installerPath = Resolve-Path "target\release\bundle\msi\*.msi" -ErrorAction SilentlyContinue
    if ($installerPath) {
        Write-Host "  $installerPath" -ForegroundColor Cyan
    } else {
        Write-Host "  src-tauri\target\release\bundle\msi\" -ForegroundColor Cyan
    }
    Write-Host ""
    Write-Host "Исполняемый файл:" -ForegroundColor Yellow
    Write-Host "  src-tauri\target\release\navibot.exe" -ForegroundColor Cyan
} else {
    Write-Host "ОШИБКА при сборке!" -ForegroundColor Red
    exit 1
}

# Возвращаемся в корень
Set-Location ..

