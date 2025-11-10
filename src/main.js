// Tauri API доступен через window.__TAURI__
let invoke;
if (window.__TAURI__) {
    // В Tauri v1 API может быть в разных местах
    invoke = window.__TAURI__.invoke || 
             (window.__TAURI__.tauri && window.__TAURI__.tauri.invoke) ||
             (window.__TAURI__.core && window.__TAURI__.core.invoke);
}

let startUrl = 'https://www.google.com';

// Загружаем стартовый URL из конфига
async function loadStartUrl() {
    if (!invoke) {
        console.warn('Tauri invoke не доступен, используем URL по умолчанию');
        return;
    }
    try {
        startUrl = await invoke('get_start_url');
        console.log('Loaded start URL:', startUrl);
    } catch (error) {
        console.error('Failed to load start URL:', error);
    }
}

// Инициализация при загрузке страницы
document.addEventListener('DOMContentLoaded', async () => {
    // Проверяем доступность Tauri API
    if (!window.__TAURI__) {
        console.error('Tauri API не доступен');
        return;
    }

    await loadStartUrl();
    
    const welcomeScreen = document.getElementById('welcome-screen');
    const mainScreen = document.getElementById('main-screen');
    const startButton = document.getElementById('start-button');
    const exitButton = document.getElementById('exit-button');
    const webview = document.getElementById('webview');

    // Обработчик кнопки "Начать"
    startButton.addEventListener('click', async () => {
        // Скрываем стартовый экран
        welcomeScreen.classList.add('hidden');
        
        // Показываем основной экран
        mainScreen.classList.remove('hidden');
        
        // Загружаем стартовый URL в iframe
        webview.src = startUrl;
        
        // Разворачиваем окно на весь экран (maximized)
        try {
            if (invoke) {
                await invoke('maximize_window');
            }
        } catch (error) {
            console.error('Failed to maximize window:', error);
        }
    });

    // Обработчик кнопки "Выход"
    exitButton.addEventListener('click', async () => {
        try {
            if (invoke) {
                await invoke('exit_app');
            }
        } catch (error) {
            console.error('Failed to exit app:', error);
        }
    });

    // Обработка навигации в iframe (опционально, для отладки)
    webview.addEventListener('load', () => {
        console.log('Webview loaded:', webview.src);
    });
});

