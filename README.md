# docker-ps2smb

Con este contenedor podras compartir por la red tus juegos de PlayStation 2 almacenados en tu PC o NAS, para que [OPL (OpenPS2Loader)](https://github.com/ps2homebrew/Open-PS2-Loader) pueda abrirlos.

*OpenPS2Loader* utiliza una version cliente muy antigua del protocolo [Samba](https://es.wikipedia.org/wiki/Samba_(software)). No es recomendable activar esta version en la parte servidora (NAS o nuestro PC) por seguridad. Por eso ee creado esta imagen docker con la que poder tener una version de Samba con dicho protocolo activado. De esta manera aislaremos posibles vulnerabilidades.

Esta imagen esta basada en Alpine 3.13.5 y Samba 4.13.8. He preferido congelar las versiones ya que puede que en futuras vetrsiones las funcionalidades que buscamos sean eliminadas por el equipo de desarrolo de *samba.

Junto a la imagen tambien encontrareis el archivo de configuracion de samba: [smb.conf](smb.conf). No ha sido facil encontrar los parametros exactos para que Samba se entienda bien con OPL.

### Como lanzar un conenedor

Antes de lanzar/crear el contenedor debes cambiar los siguientes campos:

* **'PORT:445/tcp':** cambia el PORT por uno que no interfiera con el 455 del propio host.
* **'/FULL/PATH/OF/THE/smb.conf':** La ruta completa de archivo de configuracion [smb.conf](smb.conf).
* **'/FULL/PATH/OF/PS2/GAMES/ISO':** la ruta completa donde estan los juegos en formato ISO. Hay que en cuenta que [OPL (OpenPS2Loader)](https://github.com/ps2homebrew/Open-PS2-Loader) necesita que los juegos esten ordenados en una [estructura de carpetas especifica](https://github.com/ps2homebrew/Open-PS2-Loader#how-to-use). Recomindo utilizar la aplicacion [OPL Manager](https://oplmanager.com/site/) para crear dicha estructura de carpetas de un manera facil e intuitivo.

```Bash
docker run --name='PS2smb' \
-p 'PORT:445/tcp' \
-v '/FULL/PATH/OF/THE/smb.conf':'/etc/samba/smb.conf':'rw' \
-v '/FULL/PATH/OF/PS2/GAMES/ISO':'/mnt/games':'rw' \
'fortu/docker-ps2smb'
```

### Configurar OPL (OpenPS2Loader)

Con el contenedor en marcha, conecta a la red tu PlayStation 2 y carga OPL. Una vez cargado, en la apartado *Network Settings*, deberas configurar la red, ya sea en modo DHCP o IP estatica.

```text
- PS2 -
IP Address Type  Static/DHCP
IP Address       192.168.0.1
Mask             255.255.255.0
Gateway          192.168.1.254
DNS Server       192.168.1.1
```
Con esto la PS2 y apodra acceder a la red.

Ahora hay que meter los datos los datos del contenedor.

* **Address Type:** seleccionamos la opcion *IP*.
* **Address:** Aquí debemos poner la direccion IP de nuestro contenedor.
* **Port:** El puerto TCP que hemos puesto en el contenedor.
* **Share:** ponemos *games*.
* **User:** escribimos *Guest* para conectarmnos como invitados sin necesidad de contraseña.
* **Password:** lo dejamos vacio.

```text
- SMB Server -
Address Type     IP
Address          'Conainer IP'
Port             'Container TCP PORT'

Share            games
User             Guest
Password         <not set>
```

Tambien teneis la opcion de copiar el archivo de configuracion de OPL a vuestra memory card y que directamente cargue la configuracion de red. Podeis encontrar los archivos de configuracion en [la carpeta  OPL](OPL/) del repositorio.
