#!/bin/bash  
#		Instituto Tecnológico de Costa Rica
#		Sede: San Carlos
#		Carrera: Ingeniería Electrónica
#		Estudiantes:
#		#Ruth Iveth Campos Artavia
#		#Allan Fauricio Chacón Cordero
#		#Mario Alberto Valenciano Rojas
#		Curso: Laboratorio de Estructura de Microprocesadores EL-4313
#		Programa: Envio de emails segun tipo de auto

file="cant_personas.txt"							 #the file where you keep your string name
cant=$(cat "$file")        							#la salida de 'cat $file' es asignada al nombre de $name variable

{	read p1									#Placa anterior
	read plate								#Placa nueva
	read other								#otras cosas
} < resultado.txt

{	read a d a0								#0placa Tipo
	read b e a1								#1carga pesada
	read c f a2								#2Carga Liviana
	read g j a3								#3Vehículo particular
	read h k a4								#4Transporte público
	read i l a5								#5Policia
	read m n a6								#6Discapacitados
	read o q a7								#7taxi
} < placas.txt	
echo "placa anterior:"
echo $p1									#Imprime la placa anterior
echo "placa actual:"
echo $plate									#Imprime la placa recien obtenida


if [ “$plate” == “$p1” ]; then							#Si es igual al anterior solo se debe guardar el num de la placa
	echo "es igual al anterior"						#Imprime que es igual
	alpr -c us image2.jpg | sed -n 2p|cut -d ' ' -f 6-| rev | cut -c 20- | rev > resultado.txt #Guarda inicialmente la placa nueva

elif [ “$plate” != “$p1” ]; then							#Si no es igual, se guarda y se revisa la cantidad de personas
	alpr -c us image2.jpg | sed -n 2p|cut -d ' ' -f 6-| rev | cut -c 20- | rev > resultado.txt
		
	
	if [ “$cant” == “0” ]; then 						#se asume que la cantidad de personas no puede ser cero
		echo "error de lectura" 					#para dar un mensaje de error
	elif [ “$cant” == “1” ]; then						#no se debe enviar correo porque no se es carpooler
		echo "Solo una persona" 
	else									#Si hay mas de una persona se envia un correo
	echo "send email for a person" 
		if [ "$plate" == "$b" ];then					#Se compara el numero de placa con placa de carga pesada
		echo "La cantidad de personas es:  $cant" $'\n'"La placa del auto es:  $plate"| mail -s "Autorizacion de Carpooling: carga pesada" $a1

		elif [ "$plate" == "$c" ];then 					#Se compara el numero de placa con placa de carga Liviana
		echo "La cantidad de personas es:  $cant" $'\n'"La placa del auto es:  $plate"| mail -s "Autorizacion de Carpooling: carga Liviana" $a2

		elif [ "$plate" == "$g" ];then					#Se compara el numero de placa con placa de Vehículo particular
		echo "La cantidad de personas es:  $cant" $'\n'"La placa del auto es:  $plate"| mail -s "Autorizacion de Carpooling: Vehículo particular" $a3
	
		elif [ "$plate" == "$h" ];then					#Se compara el numero de placa con placa de Transporte público
		echo "La cantidad de personas es:  $cant" $'\n'"La placa del auto es:  $plate"| mail -s "Autorizacion de Carpooling: Transporte público" $a4

		elif [ "$plate" == "$i" ];then					#Se compara el numero de placa con placa de Policia
		echo "La cantidad de personas es:  $cant" $'\n'"La placa del auto es:  $plate"| mail -s "Autorizacion de Carpooling: Policia" $a5
	
		elif [ "$plate" == "$m" ];then					#Se compara el numero de placa con placa de Discapacitados
		echo "La cantidad de personas es:  $cant" $'\n'"La placa del auto es:  $plate"| mail -s "Autorizacion de Carpooling: taxi" $a6

		elif [ "$plate" == "$o" ];then					#Se compara el numero de placa con placa de taxi
		echo "La cantidad de personas es:  $cant" $'\n'"La placa del auto es:  $plate"| mail -s "Autorizacion de Carpooling: Policía_de_tránsito(Uso_Oficial)" $a7

		else 
			echo "no es igual a ninguna placa, no tiene permiso de carpooling" 			#Si no es igual a ninguna placa se informa(error)
		fi

	fi
else 
	echo "placa no válida"	
	
fi

