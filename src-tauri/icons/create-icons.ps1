# Скрипт для создания всех необходимых размеров иконок из исходного файла
$sourceIcon = "icon-source.png"

if (-not (Test-Path $sourceIcon)) {
    Write-Host "Исходная иконка не найдена: $sourceIcon" -ForegroundColor Red
    exit 1
}

Write-Host "Создание иконок из $sourceIcon..." -ForegroundColor Green

# Проверяем наличие ImageMagick
$magick = Get-Command magick -ErrorAction SilentlyContinue

if ($magick) {
    Write-Host "Используется ImageMagick для создания иконок..." -ForegroundColor Green
    
    # Создаем PNG иконки разных размеров
    magick $sourceIcon -resize 32x32 32x32.png
    magick $sourceIcon -resize 128x128 128x128.png
    magick $sourceIcon -resize 256x256 128x128@2x.png
    
    # Создаем ICO для Windows (с несколькими размерами)
    magick $sourceIcon -define icon:auto-resize=256,128,64,48,32,16 icon.ico
    
    Write-Host "Иконки успешно созданы!" -ForegroundColor Green
} else {
    Write-Host "ImageMagick не найден. Используем альтернативный метод..." -ForegroundColor Yellow
    
    # Просто копируем исходный файл как базовый
    Copy-Item $sourceIcon -Destination "32x32.png" -Force
    Copy-Item $sourceIcon -Destination "128x128.png" -Force
    Copy-Item $sourceIcon -Destination "128x128@2x.png" -Force
    
    Write-Host "Созданы базовые иконки (требуется ручная обработка для ICO)" -ForegroundColor Yellow
    Write-Host "Для создания ICO используйте онлайн конвертер или установите ImageMagick" -ForegroundColor Yellow
}

Write-Host "Готово!" -ForegroundColor Green

