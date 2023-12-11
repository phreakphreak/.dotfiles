const { exec } = require('child_process');

console.log('Buscando actualizaciones de paquetes...');

exec('sudo apt list --upgradable', (error, stdout) => {
    if (error) {
        console.error(`Error al buscar actualizaciones: ${error.message}`);
        return;
    }



    const actualizables = stdout
        .split('\n')
        .filter(line => line.includes('/') && !line.includes('Listing...'))
        .map(line => {
            const [package, version,arch,type,from,old] = line.split(' ');
            const [name] = package.split(',');
            let oldVersion = old.replace("[","")
            oldVersion = oldVersion.replace("]","")
            return { name, oldVersion, newVersion:version };
        });

    if (actualizables.length > 0) {
        console.log('\nPaquetes que se van a actualizar:\n');
       actualizables.forEach(pkg => {
            const oldColor = pkg.oldVersion === pkg.newVersion ? '\x1b[33m' : '\x1b[31m'; // Amarillo si igual, rojo si diferente
            const resetColor = '\x1b[0m'; // Resetear el color
            console.log(`${pkg.name} ${oldColor}${pkg.oldVersion}${resetColor} -> \x1b[32m${pkg.newVersion}${resetColor}`);
        });
    } else {
        console.log('\nNo hay paquetes para actualizar.');
    }
});
