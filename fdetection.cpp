/* 
		Instituto Tecnológico de Costa Rica
		Sede: San Carlos
		Carrera: Ingeniería Electrónica
		Estudiantes:
		#Ruth Iveth Campos Artavia
		#Allan Fauricio Chacón Cordero
		#Mario Alberto Valenciano Rojas
		Curso: Laboratorio de Estructura de Microprocesadores EL-4313
		Programa: Deteccion de caras

*/

// Includes para librerías

#include "opencv2/objdetect/objdetect.hpp"					// Libreria opencv
#include "opencv2/highgui/highgui.hpp"						// Libreria opencv
#include "opencv2/imgproc/imgproc.hpp"						// Libreria opencv
#include <opencv2/opencv.hpp>							// Libreria opencv
#include <iostream>								// Libreria c
#include <fstream>								// Libreria c
#include <string>								// Libreria c
#include <vector>								// Libreria C
using namespace cv;								// Definicion uso open cv
using namespace std;								// Definicion uso std lib
 

 void detectAndDisplay( Mat frame );						//Funcion mostrado de la matriz de pixeles
 // Variables Global
 String face_cascade_name = "haarcascade_frontalface_alt.xml";			//Nombre libreria deteccion de caras frontales
 String eyes_cascade_name = "haarcascade_eye_tree_eyeglasses.xml";		//Nombre libreria deteccion de anteojos
 CascadeClassifier face_cascade;
 CascadeClassifier eyes_cascade;
 string window_name = "Capture - Face detection";				//Nombre de ventana del display
 RNG rng(12345);								//Generar colores random					

 /* Funcion main o global
Realiza la deteccion de caras mediante la habilitacion de la camara
Realiza un conteo de la cantidad de caras detectadas 
Guarda en un archivo de texto el valor de conteo anterior
No recibe argumentos debido a que todo esta con variables predeterminadas
*/
int main( )						
 {
   CvCapture* capture;								//Realiza una captura
   Mat frame;									//Crea matriz de pixeles
  std::vector<Rect> faces;							// crea un vector de cantidad de caras
   //-- 1. Load the cascades // Realiza el conteo de caras y ojos
   if( !face_cascade.load( face_cascade_name ) ){ printf("--(!)Error loading\n"); return -1; }; // si no encuentra las librerías da error
   if( !eyes_cascade.load( eyes_cascade_name ) ){ printf("--(!)Error loading\n"); return -1; };

   //-- 2. Read the video stream // Habilita la camara a utilizar
   capture = cvCaptureFromCAM(1);						//0 default 1 principal 2 otras -1 cualquiera
   if( capture )								// si se realiza una captura
   {
     while( true )
     {
   frame = cvQueryFrame( capture );
   //-- 3. Apply the classifier to the frame
       if( !frame.empty() )							//revisa si esta vacia de caras
       { detectAndDisplay( frame ); 						//llamada de funcion para proyectar pixeles
        imwrite("image2.jpg", frame);						//escribe o crea una imagen con la captura tomada con el nombre 										de th.jpg
}
       else
       { 								// Envia error de camara
	printf(" --(!) No captured frame -- Break!"); break; }			// Si no se puede realizar captura(error de camara) imprime un 											texto
	cv::waitKey(1000);							//Espera un segundo y sale del programa
	break;

      }
   }
	
   return 0;									//realiza un retorno exitoso
 }

/** @function detectAndDisplay */
void detectAndDisplay( Mat frame )
{
  std::vector<Rect> faces;							//Crea un vector para guardar/imprime las circulos en las caras
  Mat frame_gray;								//Crea una matriz gris para la imagen

  cvtColor( frame, frame_gray, CV_BGR2GRAY );					//Utiliza colores de pizeles
  equalizeHist( frame_gray, frame_gray );					//Ecualiza la imagen para mejorar la deteccion

  //-- Detect faces
  face_cascade.detectMultiScale( frame_gray, faces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, Size(30, 30) ); //Realiza circulos con una escala y color
cout<<"Cantidad de personas en la captura: ";					//Imprime texto sobre cantidad de personas en la captura
cout<<faces.size()<<endl;							//Imprime la cantidad
std::ofstream outfile;								//Se guarda o crea un archivo de texto para guardar datos
outfile.open("cant_personas.txt", std::ios_base::trunc);			//Guarda valor de cantidad de personas con el nombre predeterminado
outfile << faces.size();							//Valor de cantidad personas
  for( size_t i = 0; i < faces.size(); i++ )					//Se realiza una asignacion de circulos con distintos colores a 								las caras, con distintos grosores y se van recorriendo cada una de las caras detectadas
  {
    Point center( faces[i].x + faces[i].width*0.5, faces[i].y + faces[i].height*0.5 );
    ellipse( frame, center, Size( faces[i].width*0.5, faces[i].height*0.5), 0, 0, 360, Scalar( 0, 0, 255 ), 20, 8, 0 );


    Mat faceROI = frame_gray( faces[i] );
    std::vector<Rect> eyes;

    //-- In each face, detect eyes
    eyes_cascade.detectMultiScale( faceROI, eyes, 1.1, 2, 0 |CV_HAAR_SCALE_IMAGE, Size(30, 30) ); //Detecta los ojos en las caras de las personas

    for( size_t j = 0; j < eyes.size(); j++ )
     {
       Point center( faces[i].x + eyes[j].x + eyes[j].width*0.5, faces[i].y + eyes[j].y + eyes[j].height*0.5 );	//Busca el punto central para ubicar el circulo
       int radius = cvRound( (eyes[j].width + eyes[j].height)*0.25 ); 		// define el radio de los ojos
      // circle( frame, center, radius, Scalar( 255, 0, 0 ), 4, 8, 0 );
     }
  }
  //-- Show what you got

  imshow( window_name, frame );							//Muestra la imagen
 }



