Instituto Tecnológico de Costa Rica

Escuela de Ingeniería Electrónica

Laboratorio de Estructura de Microprocesadores(EL-4313)	

I Semestre 2017

Proyecto #2:
Diseño e implementación de sistemas empotrados para solución de problemas prácticos.
Problema: Priorización de transito compartido (car-pooling)
Profesor: Ernesto Rivera Alvarado

Integrantes: 

Allan Fauricio Chacón Cordero 2013071786
Mario Alberto Valenciano Rojas 2013099217
Ruth Iveth Campos Artavia 2013026084

---------------------------------------------------------------------------------------	
Manual de uso del sistema para la resolución del problema de priorización de transito compartido (car-pooling) en x86_64 para sistema operativo de la familia linux. Fue desarrollado para Ubuntu 16.04

Pasos de uso:

1.Se debe abrir la terminal desde el sistema operativo Linux 64 bits.
2.Se debe ingresar a la carpeta que contiene las librerías y el código del programa(carpool.sh) desde la consola.
3.Ejecutar el siguiente comando en consola: ./carpool.sh
3.1 En caso de falta de habilitación de permisos para correr script se debe correr el siguiente comando en consola chmod u+x carpool.sh
4.Seguidamente el programa ejecutara la búsqueda de la camara, si no la encuentra finalizará la ejecución.
5.Si se dio la ejecución del programa se debe presionar la tecla "ENTER" para finalizar o esperar 5 segundos para que se vuelva a ejecutar nuevamente.
6.Abrir el documento resultado.txt creado por el programa,en la carpeta del programa para verificar la placa leída para obtener la información pertinente de la ejecución, así como cant_personas.txt para verificar la cantidad de personas leída.
7.Adicionalmente se puede realizar una verificación de la cantidad de personas reconocidas mediante la revisión de la image2.jpg


----------------------------------------------------------------------------------------
Consideraciones iniciales:

1. Se debe realizar la instalación de OpenCV haciendo uso de tutoriales en internet
recomendado: http://docs.opencv.org/3.0-beta/doc/tutorials/introduction/linux_install/linux_install.html
2. Se debe realizar la instalación de OpenALPR mediante el comando: sudo apt-get update && sudo apt-get install -y openalpr openalpr-daemon openalpr-utils libopenalpr-dev
3. Realizar la configuración de email para acceder al correo(y tener acceso a internet mientras se corre el programa): 
	sudo apt-get install ssmtp mailutils
	sudo nano /etc/ssmtp/ssmtp.conf
	mailhub -----> =smtp.gmail.com:587
	AuthUser=correo@gmail.com
	AuthPass=contraseña
	UseSTARTTLS=YES
	UseTLS=YES
	Guardar y salir
4.Se debe realizar la configuración pertinente de la cámara, para evitar un error de lectura(puede verificar el número a utilizar con el comando lsusb), en caso de que no sea una cámara externa debe usar 0 para default, -1 para cualquiera en el programa fdetection.cpp Ln 53
5.Si se desea hacer lectura de más placas en la base de datos, debe editarse placas.txt siempre tomando en cuenta no dejar espacios en los nombres de los tipos de autos como la edición del programa email.sh para tomar en cuenta los distintos valores nuevos.
