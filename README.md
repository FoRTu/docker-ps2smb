# docker-ps2smb

Contenedor docker con el que poder servir las ISOs de tus juegos de PlayStation 2 desde la red Ethernet.

---

Con este contenedor podras cargar tus juegos de PlayStation 2 con [OPL (OpenPS2Loader)](https://github.com/ps2homebrew/Open-PS2-Loader) almacenados en tu PC o NAS haciendo uso de Samba.

Viendo que OPL utiliza una version muy antigua del protocolo Samba y que no es recomendable activar este en uestras PCs o NAS por seguridad. He creado esta imagen docker con la que poder aislar dicho protocolo y servir unicamente la carpeta de tus juegos.

Los desarrolladores de Samba han comunicado que en futuras versiones estos protocolos inseguros seran eliminados. Por lo que en vez de crear una imagen con la ultimas versiones estables, he pensado en utilizar una version que por ahora las soporta. Esdecir, este contenedor se basa en una imagen Alpine 3.13.5 y Samba 4.13.8 que se que todavia soportan dichos protocolos.

Lo mas dificil ha sido conseguir que la comunicacione entre OPL y Samba funcione. Despues de leer mucho por internet he conseguido dar con la configuracion para que dicha comunicacion funcione. La podeis encontrar en el archivo [smb.conf](smb.conf) del este repositorio.

### Como lanzar un conenedor

Antes de lanzar lanzar/crear el contenedor debes cambiando los siguientes campos:

* **'PORT:445/tcp':** cambia el PORT por uno que no interfiera con el 455 del propio host donde ejecutes el contenedor
* **'/FULL/PATH/OF/THE/smb.conf':** La ruta completa de archivo de configuracion [smb.conf](smb.conf).
* **'/FULL/PATH/OF/PS2/GAMES/ISO':** la ruta completa donde estan los juegos en formato ISO.

```Bash
docker run --name='PS2smb' \
-p 'PORT:445/tcp' \
-v '/FULL/PATH/OF/THE/smb.conf':'/etc/samba/smb.conf':'rw' \
-v '/FULL/PATH/OF/PS2/GAMES/ISO':'/mnt/games':'rw' \
'fortu/docker-ps2smb'
```

Hay que en cuenta que [OPL (OpenPS2Loader)](https://github.com/ps2homebrew/Open-PS2-Loader) necesita que los juegos esten ordenados en una [estructura de carpetas especifica](https://github.com/ps2homebrew/Open-PS2-Loader#how-to-use). Recomindo utilizar la aplicacion [OPL Manager](https://oplmanager.com/site/) para crear dicha estructura de carpetas de un manera facil e intuitivo.

### Configurar OPL (OpenPS2Loader)

Con el contenedor en marcha conecta a la red tu PlayStatuon 2 y carga OPL. Una vez cargado, en la seccion *Network Settings*, deberas configurar la red en modo DHCP o IP estatica dependiendo de tu necesidades.

```text
- PS2 -
IP Address Type  Static/DHCP
IP Address       192.168.0.1
Mask             255.255.255.0
Gateway          192.168.1.254
DNS Server       192.168.1.1
```
Mete los parametros de nuestro Contenedor.

Tene en cuenta que la IP es la del host donde se essta ejecutando el contenedor y el puerto

```text
- SMB Server -
Address Type     IP
Address          'Conainer IP'
Port             'Container TCP PORT'

Share            games
User             Guest
Password         <not set>
```

Tambien teneis la opcion de copiar el archivo de configuracion de OPL a vuestra memory card y que directamente cargue la configuracion de red. Podeis encontrar los archivos de configuracion de OPL en la siguiente carpeta del repositorio.

