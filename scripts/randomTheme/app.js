const fs = require('fs');
const path = require('path');

const extensionsDir = path.join(process.env.HOME, '.vscode', 'extensions');
const themes = [];

function findThemes(extensionPath) {
    const packageJsonPath = path.join(extensionPath, 'package.json');

    try {
        const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
        if (
            packageJson.categories &&
            packageJson.categories.includes('Themes') &&
            packageJson.contributes &&
            packageJson.contributes.themes
        ) {
            const themeLabels = packageJson.contributes.themes.map(theme => theme.label);
            themes.push(...themeLabels);
        }
    } catch (error) {
        console.error(`Error reading or parsing ${packageJsonPath}: ${error.message}`);
    }
}

function listAndProcessExtensions(dir) {
    try {
        const files = fs.readdirSync(dir);
        files.forEach(file => {
            const fullPath = path.join(dir, file);
            if (fs.statSync(fullPath).isDirectory()) {
                const packageJsonPath = path.join(fullPath, 'package.json');
                if (fs.existsSync(packageJsonPath)) {
                    findThemes(fullPath);
                }
            }
        });
    } catch (error) {
        console.error(`Error reading directory ${dir}: ${error.message}`);
    }
}

function getRandomTheme() {
    if (themes.length === 0) {
        console.log('No themes found.');
        return;
    }
    const randomIndex = Math.floor(Math.random() * themes.length);
    return themes[randomIndex];
}

listAndProcessExtensions(extensionsDir);
console.log('Temas encontrados:');
themes.forEach(theme => {
    console.log(`- ${theme}`);
});


[...Array(3).keys()].forEach(()=>{

  const randomTheme = getRandomTheme();
  if (randomTheme) {
      console.log(`\nTema aleatorio del día: ${randomTheme}`);
  } else {
      console.log('\nNo hay temas disponibles para seleccionar aleatoriamente.');
  }

})
