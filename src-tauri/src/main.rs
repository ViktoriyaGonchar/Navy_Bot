// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use serde::{Deserialize, Serialize};
use std::fs;
use std::path::PathBuf;

#[derive(Debug, Serialize, Deserialize)]
struct Config {
    start_url: String,
}

impl Default for Config {
    fn default() -> Self {
        Config {
            start_url: "https://www.google.com".to_string(),
        }
    }
}

fn get_config_path() -> PathBuf {
    // Используем стандартные пути для данных приложения
    let mut config_path = if cfg!(target_os = "windows") {
        std::env::var("APPDATA")
            .map(PathBuf::from)
            .unwrap_or_else(|_| PathBuf::from("."))
    } else if cfg!(target_os = "macos") {
        let mut path = PathBuf::from(std::env::var("HOME").unwrap_or_else(|_| ".".to_string()));
        path.push("Library");
        path.push("Application Support");
        path
    } else {
        let mut path = PathBuf::from(std::env::var("HOME").unwrap_or_else(|_| ".".to_string()));
        path.push(".config");
        path
    };
    config_path.push("navibot");
    config_path.push("config.json");
    config_path
}

fn load_config() -> Config {
    let config_path = get_config_path();
    if config_path.exists() {
        if let Ok(content) = fs::read_to_string(&config_path) {
            if let Ok(config) = serde_json::from_str::<Config>(&content) {
                return config;
            }
        }
    }
    Config::default()
}

fn save_config(config: &Config) -> Result<(), String> {
    let config_path = get_config_path();
    if let Some(parent) = config_path.parent() {
        fs::create_dir_all(parent).map_err(|e| e.to_string())?;
    }
    let content = serde_json::to_string_pretty(config).map_err(|e| e.to_string())?;
    fs::write(&config_path, content).map_err(|e| e.to_string())?;
    Ok(())
}

#[tauri::command]
fn get_start_url() -> String {
    load_config().start_url
}

#[tauri::command]
fn set_start_url(url: String) -> Result<(), String> {
    let mut config = load_config();
    config.start_url = url;
    save_config(&config)
}

#[tauri::command]
fn maximize_window(window: tauri::Window) {
    window.maximize().unwrap_or_default();
}

#[tauri::command]
fn exit_app() {
    std::process::exit(0);
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![
            get_start_url,
            set_start_url,
            maximize_window,
            exit_app
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}

