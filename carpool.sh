#!/bin/bash  
 
#		Instituto Tecnológico de Costa Rica
#		Sede: San Carlos
#		Carrera: Ingeniería Electrónica
#		Estudiantes:
#		#Ruth Iveth Campos Artavia
#		#Allan Fauricio Chacón Cordero
#		#Mario Alberto Valenciano Rojas
#		Curso: Laboratorio de Estructura de Microprocesadores EL-4313
#		Programa: Main de pruebas car-pooling


echo "prueba #1: deteccion de caras" #impresion linea prueba 1
g++ -std=c++14 fdetection.cpp -o fdetection -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_objdetect #integrar código objeto para ejecutar
./fdetection # ejecutar programa para detección de caras (face_detection)

echo "prueba #2: deteccion de placas" #impresion linea prueba 2
alpr -c us image2.jpg | sed -n 2p|cut -d ' ' -f 6-| rev | cut -c 20- | rev #impresión resultado de placa
alpr -c us image2.jpg | sed -n 2p|cut -d ' ' -f 6-| rev | cut -c 20- | rev >> resultado.txt #guardar resultado


echo "prueba #3: email"  #impresion linea prueba 3
./email.sh #corrida del programa para verificar cantidad de personas y placa para enviar mensaje al email personalizado

echo "Presione <ENTER> para salir..."
if read -t 5 -p $'\n'; then #pausa hasta que ENTER sea presionado entre 5s sino vuelve a correr programa
	echo "Se ha alcanzado el límite de tiempo."
	exit
else
    ./carpool.sh #llamado para volver a correr el programa
fi

