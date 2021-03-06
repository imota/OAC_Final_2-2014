
/**************************************************

file: demo_tx.c
purpose: simple demo that transmits characters to
the serial port and print them on the screen,
exit the program by pressing Ctrl-C

compile with the command: gcc demo_tx.c rs232.c -Wall -Wextra -std=c99 -o2 -o test_tx

**************************************************/

#include <stdlib.h>
#include <stdio.h>
         
#ifdef _WIN32
#include <Windows.h>
#else
#include <unistd.h>
#endif

#include "rs232.c"

int main(){
    mandaArquivo("obj1.bin\0");
    sleep(200);
    mandaArquivo("obj2.bin\0");
    sleep(200);
    mandaArquivo("obj3.bin\0");
    sleep(200);
    mandaArquivo("obj4.bin\0");
    sleep(200);
    mandaArquivo("obj5.bin\0");
    sleep(200);
    mandaArquivo("obj6.bin\0");
    sleep(200);
    mandaArquivo("obj7.bin\0");
    sleep(200);
    mandaArquivo("obj8.bin\0");
    sleep(200);
    mandaArquivo("obj9.bin\0");
    sleep(200);
    mandaArquivo("obj10.bin\0");
    sleep(200);
    mandaArquivo("obj11.bin\0");
    sleep(200);
    mandaArquivo("obj12.bin\0");
    sleep(200);
    mandaArquivo("obj13.bin\0");
    sleep(200);
    mandaArquivo("obj14.bin\0");
    sleep(200);
    //mandaArquivo("lamar.bin\0");
    //mandaArquivo("matrizMapa1.bin\0");
    return 0;
}



int mandaArquivo(char *fileName)
{

  int cport_nr=1,        /* /dev/ttyS0 (COM1 on windows) */
      bdrate=115200;       /* 9600 baud */

  char mode[]={'8','N','1',0};
  int i = 0;

  char *buffer;
  long int lSize;
  size_t result;
//  FILE *arq = fopen("mips_rs232_computador.acbnna", "rb");
  FILE *arq = fopen(fileName, "rb");

  if(!arq){
    printf("Não abriu o arquivo");
            system("pause");
    return 0;
  }

  if(RS232_OpenComport(cport_nr, bdrate, mode))
  {
    printf("Can not open comport\n");
        system("pause");
    return(0);
  }
  printf("Abriu portas\n");
  
  // obtain file size:
  fseek (arq , 0 , SEEK_END);
  lSize = ftell (arq);
  rewind (arq);
  printf("lSize = %ld\n", lSize);

  // allocate memory to contain the whole file:
  buffer = (char*) malloc (sizeof(char)*lSize);
  if (buffer == NULL) {fputs ("Memory error",stderr); exit (2);}

   // copy the file into the buffer:
  result = fread (buffer,1,lSize,arq);
  if (result != lSize) {fputs ("Reading error",stderr); exit (3);}
  //printf("%d\n", result);
  //printf("\nbuffer: %s\n", buffer);


  //envia o que está no buffer
  /*printf("Aperte enter para enviar");
  getchar();
	RS232_cputs(cport_nr, buffer);
  //printf("sent: %s\n", buffer);

    #ifdef _WIN32
        Sleep(1000);
    #else
        usleep(1000);  
    #endif*/

        
  while(lSize > 0)
  {
    RS232_SendByte(cport_nr, buffer[i]);

    //printf("sent: %c\n", buffer[i]);
    int j;
    for(j = 0; j < 1000; j++);
    i++;
    lSize--;
    
  }

  free (buffer);
  fclose(arq);
  RS232_CloseComport(cport_nr);  
  return 0;
}
