#!/usr/bin/env python3
"""
Скрипт для создания всех размеров иконок из исходного файла
Требует: pip install Pillow
"""

try:
    from PIL import Image
    import os
    import sys

    source_icon = "icon-source.png"
    
    if not os.path.exists(source_icon):
        print(f"Ошибка: Исходная иконка не найдена: {source_icon}")
        sys.exit(1)
    
    print(f"Создание иконок из {source_icon}...")
    
    # Открываем исходное изображение
    img = Image.open(source_icon)
    
    # Создаем PNG иконки разных размеров
    sizes = {
        "32x32.png": (32, 32),
        "128x128.png": (128, 128),
        "128x128@2x.png": (256, 256)
    }
    
    for filename, size in sizes.items():
        resized = img.resize(size, Image.Resampling.LANCZOS)
        resized.save(filename, "PNG")
        print(f"Создан: {filename}")
    
    # Для ICO создаем файл с несколькими размерами
    # Windows ICO может содержать несколько размеров
    ico_sizes = [(16, 16), (32, 32), (48, 48), (64, 64), (128, 128), (256, 256)]
    ico_images = []
    
    for size in ico_sizes:
        resized = img.resize(size, Image.Resampling.LANCZOS)
        ico_images.append(resized)
    
    # Сохраняем ICO (Pillow поддерживает ICO с несколькими размерами)
    ico_images[0].save("icon.ico", format='ICO', sizes=[(s.width, s.height) for s in ico_images])
    print("Создан: icon.ico")
    
    print("Все иконки успешно созданы!")
    
except ImportError:
    print("Ошибка: Pillow не установлен")
    print("Установите: pip install Pillow")
    sys.exit(1)
except Exception as e:
    print(f"Ошибка: {e}")
    sys.exit(1)

