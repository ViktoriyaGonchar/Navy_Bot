# Скрипт для установки расширений VSCode для NaviBot
Write-Host "Установка расширений VSCode для NaviBot..." -ForegroundColor Green

$extensions = @(
    "rust-lang.rust-analyzer",
    "tauri-apps.tauri-vscode",
    "vadimcn.vscode-lldb",
    "usernamehw.errorlens",
    "tamasfe.even-better-toml",
    "serayuzgur.crates"
)

$codePath = "C:\Program Files\Microsoft VS Code\bin\code.cmd"
if (-not (Test-Path $codePath)) {
    $codePath = "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd"
}

if (Test-Path $codePath) {
    foreach ($ext in $extensions) {
        Write-Host "Установка $ext..." -ForegroundColor Yellow
        & $codePath --install-extension $ext --force
    }
    Write-Host "Все расширения установлены!" -ForegroundColor Green
} else {
    Write-Host "VSCode не найден. Установите расширения вручную:" -ForegroundColor Red
    foreach ($ext in $extensions) {
        Write-Host "  - $ext" -ForegroundColor Cyan
    }
    Write-Host ""
    Write-Host "Или откройте VSCode и выполните:" -ForegroundColor Yellow
    Write-Host "  Ctrl+Shift+X -> поиск расширения -> Install" -ForegroundColor Yellow
}

