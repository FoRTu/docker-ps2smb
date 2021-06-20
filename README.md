
# Docker-ps2smb

With this *container* you can share over the network your PlayStation 2 games stored on your PC or NAS to be opened by [OPL (OpenPS2Loader)](https://github.com/ps2homebrew/Open-PS2-Loader) can open them.

*OpenPS2Loader* uses a very old client version of the Samba protocol and it is not recommended to be activated on the server side (NAS or our PC) for security reasons. That's why I have created this *Docker* image, this way we will isolate possible vulnerabilities into the *container*.

This image is based on Alpine 3.13.5 and Samba 4.13.8. I chose an exact version instead of use the last stable tagged ones because the features we are looking for, may be will be removed in future stable versions by the main *Samba* developers.

Here also you will find the samba configuration file: [smb.conf](smb.conf). It has not been easy to find the exact config of Samba to communicate well with OPL.

### How to run a container

Before create/run the *container* you must change the following fields:

* **'PORT:445/tcp':** change the PORT to one that does not interfere with the host's 455.
* **'/FULL/PATH/OF/THE/smb.conf':** The full path to the [smb.conf](smb.conf) configuration file.
* **'/FULL/PATH/OF/PS2/GAMES/ISO':** the full path of the folder where your have  all the games in ISO format. The games have to be sorted in a [specific folder structure](https://github.com/ps2homebrew/Open-PS2-Loader#how-to-use) to properly be detected by OPL. I recommend to use [OPL Manager](https://oplmanager.com/site/) application to create such a folder structure in an easy and intuitive way.

```Bash
docker run --name='PS2smb' \
-p 'PORT:445/tcp' \
-h 'PS2smb' \
-v '/FULL/PATH/OF/THE/smb.conf':'/etc/samba/smb.conf':'rw' \
-v '/FULL/PATH/OF/PS2/GAMES/ISO':'/mnt/games':'rw' \
'fortu/docker-ps2smb'
```
### Configure OPL (OpenPS2Loader) on the PS2

With the *container* running, connect your PlayStation 2 to the network and load OPL. Once it's loaded, go to *Network Settings*. In the **- PS2 -** section configure the network with a static IP, and the rest of network parameters, or just activate DHCP to do it automatically.

```text
- PS2 -
IP Address Type  Static/DHCP
IP Address       192.168.1.20
Mask             255.255.255.0
Gateway          192.168.1.1
DNS Server       192.168.1.1
```

Now you have to enter the *container* data in the **- SMB Server -** section.

* **Address Type:** Select the *IP* option.
* **Address:** Here you must enter the IP address of the *container*.
* **Port:** The TCP port we defined before for the *container*.
* **Share:** type *games*.
* **User:** type *Guest* to connect as a guest without a password.
* **Password:** leave it empty.

```text
- SMB Server -
Address Type     IP
Address          'Container IP'
Port             'Container TCP PORT'

Share            games
User             Guest
Password         <not set>
```

You also have the option to manually edit the OPL configuration files and copy them to your memory card using [uLaunchELF](http://ps2ulaunchelf.pbworks.com/w/page/19520134/FrontPage). You can find the configuration files here in [the OPL folder](OPL/).

Now Just press on **Reconnect** and go to the game list and you will see all your games stored on the PC or NAS.

---


# Docker-ps2smb (Castellano)

Con este *contenedor* podrás compartir por la red tus juegos de PlayStation 2 almacenados en tu PC o NAS, para que [OPL (OpenPS2Loader)](https://github.com/ps2homebrew/Open-PS2-Loader) pueda abrirlos.

*OpenPS2Loader* utiliza una versión cliente muy antigua del protocolo [Samba](https://es.wikipedia.org/wiki/Samba_(software)). No es recomendable activar esta versión en la parte servidora (NAS o nuestro PC) por seguridad. Por eso he creado esta imagen *Docker* con la que poder tener una versión de Samba con dicho protocolo activado. De esta manera aislaremos posibles vulnerabilidades.

Esta imagen está basada en Alpine 3.13.5 y Samba 4.13.8. He preferido congelar las versiones ya que puede que en futuras versiones las funcionalidades que buscamos sean eliminadas por el equipo de desarrollo de *samba.

Junto a la imagen también encontrareis el archivo de configuración de samba: [smb.conf](smb.conf). No ha sido fácil encontrar los parámetros exactos para que Samba se entienda bien con OPL.

### Como lanzar un contenedor

Antes de lanzar/crear el *contenedor* debes cambiar los siguientes campos:

* **'PORT:445/tcp':** cambia el PORT por uno que no interfiera con el 455 del propio host.
* **'/FULL/PATH/OF/THE/smb.conf':** La ruta completa de archivo de configuración [smb.conf](smb.conf).
* **'/FULL/PATH/OF/PS2/GAMES/ISO':** la ruta completa donde están los juegos en formato ISO. Hay que en cuenta que [OPL (OpenPS2Loader)](https://github.com/ps2homebrew/Open-PS2-Loader) necesita que los juegos estén ordenados en una [estructura de carpetas especifica](https://github.com/ps2homebrew/Open-PS2-Loader#how-to-use). Recomendó utilizar la aplicación [OPL Manager](https://oplmanager.com/site/) para crear dicha estructura de carpetas de un manera fácil e intuitivo.

```Bash
docker run --name='PS2smb' \
-p 'PORT:445/tcp' \
-h 'PS2smb' \
-v '/FULL/PATH/OF/THE/smb.conf':'/etc/samba/smb.conf':'rw' \
-v '/FULL/PATH/OF/PS2/GAMES/ISO':'/mnt/games':'rw' \
'fortu/docker-ps2smb'
```

### Configurar OPL (OpenPS2Loader) en la PS2

Con el *contenedor* en marcha, conecta a la red tu PlayStation 2 y carga OPL. Una vez cargado, en el apartado *Network Settings*, deveras configurar la red, ya sea en modo DHCP o IP estática.

```text
- PS2 -
IP Address Type  Static/DHCP
IP Address       192.168.1.20
Mask             255.255.255.0
Gateway          192.168.1.1
DNS Server       192.168.1.1
```

Ahora hay que meter los datos del *contenedor* en el apartado **- SMB Server -**.

* **Address Type:** selecciona la opción *IP*.
* **Address:** Aquí debes poner la dirección IP del *contenedor*.
* **Port:** El puerto TCP que definimos antes para el *contenedor*.
* **Share:** ponemos *games*.
* **User:** escribimos *Guest* para conectar como invitados sin necesidad de contraseña.
* **Password:** lo dejamos vacío.

```text
- SMB Server -
Address Type     IP
Address          'IP del contenedor'
Port             'PUERTO TCP del contenedor'

Share            games
User             Guest
Password         <not set>
```

También tenéis la opción de editar manualmente los archivos de configuración de OPL y copiarlos a vuestra memory card mediante [uLaunchELF](http://ps2ulaunchelf.pbworks.com/w/page/19520134/FrontPage). Podéis encontrar los archivos de configuración en [la carpeta  OPL](OPL/) del repositorio.

Ahora sólo tienes que pulsar en **Reconnect** y acceder a la lista de juegos para ver todos tus juegos almacenados en el PC o NAS.
---
