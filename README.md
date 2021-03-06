# Billetera Web Datacenter 

El proyecto de billetera web para ser desplegado localmente para desarrollo o matenimiento usa los siguientes componentes que ya estan incluidos en el docker-compose (**No es necesario instalarlos**):
* [JDK8-Oracle](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) - Java development kit 8
* [Apache-Maven](https://maven.apache.org/download.cgi) - Maven’s primary goal is to allow a developer to comprehend the complete state of a development effort in the shortest period of time
* [Jboss 6](https://jbossas.jboss.org/downloads) - Servidor de aplicaciones (*pendiente por confirmar si es la versión AS o EAP).

## Requerimientos

* [Docker-compose](https://docs.docker.com/compose/install/) para instanciar los contenedores
* [Ubuntu](https://ubuntu.com/tutorials/tutorial-ubuntu-on-windows#1-overview) Si se ejecuta desde un SO Windows debe contar con una terminal bash como git Bash o un sub-sistema linux como WSL.

## Contenido
Este repositorio contiene el archivo docker-compose y la estructura de carpetas necesarias que serán usadas como unidades de montaje para los volumenes en los despligues de contenedores.
  - **maven.m2** (Ruta donde se almacena la configuración de Maven y el repositorio de dependencias)
  - **mysourcecode** (Acá se descarga el código fuente de git)
  - **target** (Esta carpeta almacena todos los archivos de despligue del servidor JBOSS)
  - **docker-compose.yml** (Al ser ejecutado crea los contenedores para desarrollo)
  - **init.sh** (Es un script que prepara el workdirectory para el docker-compose.yml, es decir, que al ejecutarlo crea las carpetas para el montaje de los volumenes, hace otras configuraciones y finaliza con docker-compose-up)


## Arquitectura 

![Arquitectura](arq.png)

### Codigo fuente

El código fuente con los perfiles de developer se encuentran en la siguiente URL [Git Billetera virtual](http://172.21.13.9/gitlab/asesoftware/billetera_virtual_web.git)

1. Clonar el repositorio en la carpeta mysources
2. Cambiar a la rama  **RQ_LOTERIA_DOCKER**

### Ejecución

Para instanciar los contenedores ejecutar el siguiente comando.
```sh
$ ./init.sh
```
Esto instanciara un contenedor con todas las herramientas que se requieren para desarrollo y otro con el servidor JBOSS configurado especificamente para este proyecto.

Para compilar y desplegar los componentes del proyecto se pueden ejecutar los siguientes comandos de acuerdo al componente requerido o sobre el cual se este trabajando.

##### BilleteraVirtual
Despliega el ear con el EJB
```sh
$ cd billetera_virtual_web/BilleteraVirtual
$ mvn -T8 clean install -P developer -DJBOSS_BV_HOME=/usr/target -e
```
##### BilleteraVirtualAdminWEB
Despliega el war BilleteraVirtualAdminWEB
```sh
$ cd billetera_virtual_web/BilleteraVirtualAdminWEB
$ mvn -T8 clean install -P developer -DJBOSS_BV_HOME=/usr/target -e
```

##### BilleteraVirtualWEB
Despliega el war BilleteraVirtualWEB
```sh
$ cd billetera_virtual_web/BilleteraVirtualWEB
$ mvn -T8 clean install -P developer -DJBOSS_BV_HOME=/usr/target -e
```

##### BilleteraVirtualWS
Despliega el war BilleteraVirtualWS
```sh
$ cd billetera_virtual_web/BilleteraVirtualWS
$ mvn -T8 clean install -P developer -DJBOSS_BV_HOME=/usr/target -e
```

##### BilleteraVirtualEP
Despliega el war BilleteraVirtualEP
```sh
$ cd billetera_virtual_web/BilleteraVirtualEP
$ mvn -T8 clean install -P developer -DJBOSS_BV_HOME=/usr/target -e
```

### Puertos disponibles
Los contendores exoponen los siguientes puertos:

| Contenedor | Puertos | 
| ------ | ------ |
| dev_server-dev_1 | 8089, 8787 |
| dev_dev_1 | Ninguno |

1. Para acceder a la consola de administración de JBOSS usar http://localhost:8089/admin-console
2. el puerto para hacer debug con Jboss usar 8787 

### Volumenes

Es necesario ingresar a la configuración de docker en la sección de Resources -> FILE SHARING activar el disco local que contendrá las carpetas usadas en los montajes de volumenes.

Se realizó el siguiente mapeo.

Es obligatorio modificar las rutas definidas en el docker-compose.yml en la sección de **volumes** para la propiedad **device**, donde la rutas deben ser a las carpetas de este proyecto. 

| Contenedor | Volumen  | Path host | Path container |
| ------ | ------ | ------ | ------ |
| dev_server-dev_1 | server-target | /target/ |/opt/jboss/server/default/deploy/|
| dev_dev_1 | source-files | /mysources/ |/usr/mysources/|
| dev_dev_1 | mavenm2 | /maven.m2/ |/root/.m2/|
| dev_dev_1 | server-target | /target/ |/usr/target/|

### Development
#### Building for source
### Todos
  - Descargar el código fuente directamente desde init.sh
 - Se debe hacer autenticación con azure AAD Outh0 para el login con el registry
 - Add Night Mode

License
----
MIT

**Free Software, Hell Yeah!**
