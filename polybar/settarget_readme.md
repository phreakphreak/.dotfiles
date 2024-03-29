Para crear la función 'settarget', primeramente necesitas crear en la '.bashrc' o en la '.zshrc' (dependiendo del tipo de Shell que uses) la siguiente función:

function settarget(){
	ip_address=$1
	machine_name=$2
	echo "$ip_address $machine_name" > /home/tuUsuario/.config/bin/target
}

En caso de que los directorios listados anteriormente no existan, los creas, ¿estamos?, ni más... ni menos.

El archivo de texto residente en '/home/tuUsuario/.config/bin/target' no es más que el contenido a representar. Si te fijas en el uso de la función, lee 2 parámetros, el primero de ellos correspondiente a la dirección IP y el segundo de ellos al nombre de la máquina. 

Su ejecución sería tal que así:

> settarget 10.10.10.21 nombreMaquina

Es necesario proporcionarle 2 argumentos siguiendo la lógica de la función para que esta funcione. 

Esto por un lado, pero no es suficiente, dado que para que te salga arriba a la derecha en la Polybar (o donde lo quieras representar), es necesario que crees un nuevo módulo. Para ello, te vas a ir a la ruta '/home/tuUsuario/.config/polybar' y vas a abrir el archivo 'current.ini'.

Una vez abierto, verás que existen varias líneas empezando con la cadena '[bar/...]'. En este punto, crearemos un nuevo bar siguiendo la misma estructura, correspondiente al componente que nos permitirá cargar un nuevo módulo. Lo haremos tal que así:

[bar/micomponente]
inherit = bar/main
width = 16%
height = 40
offset-x = 80.5%
offset-y = 15
background = ${color.bg}
foreground = ${color.white}
bottom = false
padding = 1
module-margin-left = 0
module-margin-right = 0
modules-center = target_to_hack
wm-restack = bspwm

Como se puede apreciar, en 'modules-center' figura el nombre 'target_to_hack'. Este nombre, corresponderá al módulo que seguidamente deberemos definir. Para definirlo, haremos lo siguiente:

[module/target_to_hack]
type = custom/script
interval = 2
exec = ~/.config/bin/target_to_hack.sh

De esta forma, con una tasa de refresco de 2 segundos conseguiremos que el script situado en '~/.config/bin/target_to_hack.sh' se ejecute. ¿El qué cómo dices?, ¿que no existe?, eso no me lo dices a la cara. Pues lo que hacemos es crearlo.

Bajo la ruta citada, crearemos el archivo 'target_to_hack.sh' (o como lo quieras llamar, pero debe coincidir con lo indicado en el archivo 'current.ini'). Este archivo, deberá poseer permisos de ejecución, y debe disponer del siguiente contenido:

#!/bin/bash

ip_address=$(cat /home/s4vitar/.config/bin/target | awk '{print $1}')
machine_name=$(cat /home/s4vitar/.config/bin/target | awk '{print $2}')

if [ $ip_address ] && [ $machine_name ]; then
	echo "%{F#e51d0b}aquiponeseliconoquequieras ${F#ffffff}$ip_address%{u-} - $machine_name"
else
	echo "${F#e51d0b}aquiponeseliconoquequieras %{u-}%{F#ffffff} No target"
fi

Para que finalmente aparezca, sólo queda retocar el archivo 'launch.sh' existente bajo la ruta '/home/tuUsuario/.config/polybar' y añadir la siguiente línea:

polybar micomponente -c ~/.config/polybar/current.ini &

Donde 'micomponente' debe coincidir con el nombre definido en el bar creado en el archivo 'current.ini' (es decir, en la línea donde pdefinimos '[bar/micomponente]').

¡Y listo!, de esta forma, tendrás tu nuevo módulo configurado. Cabe decir que igual a nivel de proporciones tengas que aplicar algunos ajustes, porque tal vez las proporciones que yo tenga no son las mismas que las tuyas. En ese caso, es simplemente ir ajustando hasta tener el módulo de la Polybar en la posición deseada.