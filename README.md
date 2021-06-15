# docker-ps2smb

Contenedor docker con el que poder servir las ISOs de tus juegos de PlayStation 2 desde la red Ethernet.

---

Con este contenedor podras cargar tus juegos de PlayStation 2 con OPL (OpenPS2Loader) almacenados en tu PC o NAS haciendo uso de Samba.

Viendo que OPL utiliza una version muy antigua del protocolo Samba y que no es recomendable activar este en uestras PCs o NAS por seguridad. He creado esta imagen docker con la que poder aislar dicho protocolo y servir unicamente la carpeta de tus juegos.

Los desarrolladores de Samba han comunicado que en futuras versiones estos protocolos inseguros seran eliminados. Por lo que en vez de crear una imagen con la ultimas versiones estables, he pensado en utilizar una version que por ahora las soporta. Esdecir, este contenedor se basa en una imagen Alpine 3.13.5 y Samba 4.13.8 que se que todavia soportan dichos protocolos.

Lo mas dificil ha sido conseguir que la comunicacione entre OPL y Samba funcione. Despues de leer mucho por internet he conseguido dar con la configuracion para que dicha comunicacion funcione. La podeis encontrar en el archivo smb.config del este repositorio.



### How to run a container
