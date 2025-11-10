# PowerShell скрипт для создания placeholder иконок
# Требует установленного ImageMagick или можно использовать онлайн инструменты

Write-Host "Создание placeholder иконок для NaviBot..." -ForegroundColor Green

# Проверяем наличие ImageMagick
$magick = Get-Command magick -ErrorAction SilentlyContinue

if (-not $magick) {
    Write-Host "ImageMagick не найден. Используйте онлайн инструменты для создания иконок." -ForegroundColor Yellow
    Write-Host "Рекомендуемые инструменты:" -ForegroundColor Yellow
    Write-Host "  - https://www.icongenerator.app/" -ForegroundColor Cyan
    Write-Host "  - https://favicon.io/" -ForegroundColor Cyan
    Write-Host "  - https://realfavicongenerator.net/" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Создайте иконку с эмодзи робота 🤖 на темно-синем фоне и экспортируйте в нужных размерах." -ForegroundColor Yellow
    exit
}

# Создаем временное изображение с эмодзи робота
$tempImage = "temp_robot.png"

# Создаем изображение 512x512 с градиентом и текстом
magick -size 512x512 gradient:'#1e3c72-#2a5298' -pointsize 200 -fill white -gravity center -annotate +0+0 "🤖" $tempImage

# Генерируем все необходимые размеры
Write-Host "Генерация иконок..." -ForegroundColor Green

magick $tempImage -resize 32x32 32x32.png
magick $tempImage -resize 128x128 128x128.png
magick $tempImage -resize 256x256 128x128@2x.png

# Для Windows ICO нужен специальный формат
magick $tempImage -define icon:auto-resize=256,128,64,48,32,16 icon.ico

# Для macOS ICNS нужен специальный формат (требует iconutil на macOS)
Write-Host "Для macOS ICNS используйте iconutil на Mac или онлайн конвертеры." -ForegroundColor Yellow

# Удаляем временный файл
Remove-Item $tempImage -ErrorAction SilentlyContinue

Write-Host "Иконки созданы!" -ForegroundColor Green
Write-Host "Примечание: Для лучшего качества используйте профессиональные инструменты дизайна." -ForegroundColor Yellow

