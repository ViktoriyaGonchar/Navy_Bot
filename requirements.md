# Требования к расширениям VSCode для разработки NaviBot

Для комфортной разработки приложения на Tauri с Rust в VSCode необходимо установить следующие расширения:

## Обязательные расширения

1. **rust-analyzer** (rust-lang.rust-analyzer)
   - Основной инструмент для работы с Rust
   - Автодополнение, проверка типов, навигация по коду
   - ID: `rust-lang.rust-analyzer`

2. **Tauri** (tauri-apps.tauri-vscode)
   - Официальное расширение для работы с Tauri
   - Поддержка команд, шаблонов и конфигурации
   - ID: `tauri-apps.tauri-vscode`

3. **CodeLLDB** (vadimcn.vscode-lldb)
   - Отладчик для Rust
   - Поддержка breakpoints и debugging
   - ID: `vadimcn.vscode-lldb`

## Рекомендуемые расширения

4. **Error Lens** (usernamehw.errorlens)
   - Показывает ошибки и предупреждения прямо в коде
   - ID: `usernamehw.errorlens`

5. **Better TOML** (tamasfe.even-better-toml)
   - Поддержка синтаксиса TOML (для Cargo.toml и конфигов)
   - ID: `tamasfe.even-better-toml`

6. **Cargo** (serayuzgur.crates)
   - Управление зависимостями Cargo
   - ID: `serayuzgur.crates`

## Установка расширений

### Автоматическая установка (если доступна команда code)

Запустите скрипт:
```powershell
.\install-extensions.ps1
```

Или вручную через терминал:
```bash
code --install-extension rust-lang.rust-analyzer
code --install-extension tauri-apps.tauri-vscode
code --install-extension vadimcn.vscode-lldb
code --install-extension usernamehw.errorlens
code --install-extension tamasfe.even-better-toml
code --install-extension serayuzgur.crates
```

### Ручная установка (рекомендуется)

**Подробная инструкция:** см. файл `УСТАНОВКА_РАСШИРЕНИЙ.md`

Кратко:
1. Откройте VSCode
2. Нажмите `Ctrl+Shift+X`
3. Найдите каждое расширение по ID и установите

## Дополнительные требования

- **Rust toolchain**: Установите Rust через [rustup.rs](https://rustup.rs/)
- **Node.js**: Требуется для работы с Tauri (версия 16+)
- **System dependencies**: 
  - Windows: Microsoft Visual C++ Build Tools
  - Для других платформ см. [Tauri prerequisites](https://tauri.app/v1/guides/getting-started/prerequisites)

