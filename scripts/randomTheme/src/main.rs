use dirs;
use rand::seq::SliceRandom;
use serde::{Deserialize, Serialize};
use std::env;
use std::fs;
use std::path::Path;
// use reqwest::blocking::{Client, Request};

const EXTENSIONS_DIR: &str = ".vscode/extensions";

#[derive(Debug, Deserialize)]
struct PackageJson {
    categories: Option<Vec<String>>,
    contributes: Option<Contributes>,
}

#[derive(Debug, Deserialize)]
struct Contributes {
    themes: Option<Vec<Theme>>,
}

#[derive(Debug, Deserialize)]
struct Theme {
    label: String,
}

fn find_themes(extension_path: &Path, themes: &mut Vec<String>) {
    let package_json_path = extension_path.join("package.json");

    if let Ok(file) = fs::read_to_string(&package_json_path) {
        if let Ok(package_json) = serde_json::from_str::<PackageJson>(&file) {
            if let Some(categories) = package_json.categories {
                if categories.contains(&"Themes".to_string()) {
                    if let Some(contributes) = package_json.contributes {
                        if let Some(themes_data) = contributes.themes {
                            themes.extend(themes_data.iter().map(|theme| theme.label.clone()));
                        }
                    }
                }
            }
        }
    }
}

fn list_and_process_extensions(dir: &Path, themes: &mut Vec<String>) {
    if let Ok(entries) = fs::read_dir(dir) {
        for entry in entries.flatten() {
            if let Ok(file_type) = entry.file_type() {
                if file_type.is_dir() {
                    let package_json_path = entry.path().join("package.json");
                    if package_json_path.exists() {
                        find_themes(&entry.path(), themes);
                    }
                }
            }
        }
    }
}

fn get_random_theme(themes: &[String]) -> Option<&String> {
    if themes.is_empty() {
        println!("No themes found.");
        None
    } else {
        themes.choose(&mut rand::thread_rng())
    }
}

// fn send_post_request(theme: &str) {
//     // Aquí colocas la lógica para enviar el POST a tu endpoint.
//     // Por ejemplo, utilizando reqwest:
//     let client = Client::new();
//     let endpoint_url = "https://example.com/endpoint"; // Cambia esto por tu URL real
//     let request = client.post(endpoint_url).json(&json!({"theme": theme}));
//     if let Err(err) = request.send() {
//         eprintln!("Failed to send POST request: {}", err);
//     } else {
//         println!("POST request successful.");
//     }
// }

fn main() {
    let args: Vec<String> = env::args().collect();
    let mut num_attempts = 3;

    if args.len() > 1 {
        if let Ok(attempts) = args[1].parse::<u32>() {
            num_attempts = attempts;
        }
    }

    let extensions_dir = match dirs::home_dir() {
        Some(home) => home.join(EXTENSIONS_DIR),
        None => {
            eprintln!("Failed to get home directory.");
            return;
        }
    };

    let mut themes = Vec::new();
    list_and_process_extensions(&extensions_dir, &mut themes);

    println!("Temas encontrados:");
    for theme in &themes {
        println!("- {}", theme);
    }

    for _ in 0..num_attempts {
        if let Some(random_theme) = get_random_theme(&themes) {
            println!("\nTema aleatorio del día: {}", random_theme);
            // send_post_request(random_theme);
        } else {
            println!("\nNo hay temas disponibles para seleccionar aleatoriamente.");
        }
    }
}
