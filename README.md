# docker-ps2smb

Contenedor docker con el que poder servir las ISOs de tus juegos de PlayStation 2 desde la red Ethernet.

---

Con este contenedor podras cargar tus juegos de PlayStation 2 con OPL (OpenPS2Loader) almacenados en tu PC o NAS, haciendo uso de Samba.

Viendo que OPL utiliza una version muy antigua del protocolo Samba y que no es recomendable activar este en uestras PCs o NAS por seguridad. He pensado en crear un contenedor docker en el que poder aislar dicho protocolo y servir unicamente la carpeta con tus juegos.

Los desarrolladores de Samba han comunicado que en futuras versiones estos protocolos inseguros seran eliminados. Por lo que en vez de crear una imagen con la ultimas versiones estables, he pensado en utilizar una version que se que funciona.

Resumiendo, este contenedor se basa en una imagen Alpine 3.13.5 y Samba 4.13.8, he incormpora el archivo de configuracion smb.conf ya preconfigurado.

### How to run a container