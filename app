#include <SoftwareSerial.h>
#include "LedControl.h"
LedControl lc=LedControl(12,11,10,1);// Pins: DIN,CLK,CS, # conectores da matriz 

SoftwareSerial mySerial(8, 9);// software serial RX = digital pin 8, TX = digital pin 9
unsigned long delaytime0=1000;
unsigned long delaytime1=100;
unsigned long delaytime2=10;
void setup() {
  // começa a comunicaçao serial 
  Serial.begin(9600);

  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  mySerial.begin(9600);
  lc.shutdown(0,false);  //DEFINE A MATRIZ 
  lc.setIntensity(0,9); // CONTROLA O BRILHO DA MATRIZ 
  lc.clearDisplay(0); //LIMPA A MATRIZ 
 
}
  void loop() {  // INICIO DO CODIGO          
  byte valor[63]; //VARIAVEL QUE RECEBE OS DADOS RECEBIDOS DO APLICATIVO
  byte linha[8];  //VARIAVEL QUE SALVA OQUE SERRA EXIBIDO NA MATRIZ 
  byte matriz[63];//VARIAVEL QUE CONTROLARA OS DADOS RECEBIDOS DO APLICATIVO
  if (mySerial.available())//CHECA SE RECEBEU ALGO DO APLICATIVO 
  {  
   for(int i=0;i<=63;i++){
    while(mySerial.available()==0);
    valor[i]= mySerial.read();
  }// TRANSFERE OS VALORES RECEBIDOS PARA A VARIAVEL "VALOR" 

    int t=0; 
  for(int j=0;j<=7;j++){ 
    linha[j]=0;// RESETA A VARIAVEL "LINHA"
    for(int i=0;i<=7;i++){
     if(valor[i+(j*8)]==49){//AJUSTA OS VALORES RECEBIDOS NA VARIAVEL "VALOR", ATRAVES DE UMA FORMULA MATEMATICA  
       if(i==0)
        {
          t=1;
        }
        if(i==1){
          t=2;
        }
        if(i==2){
          t=4;
        }
        if(i==3){
          t=8;
        }
        if(i==4){
          t=16;
        }
        if(i==5){
          t=32;
        }
        if(i==6){
          t=64;
        }
        if(i==7){
          t=128;
        }     
        }
    Else 
    {
    t=0;
    }
    linha[j]=linha[j]+t;// AJUSTA OS VALORES E TRANFERE PARA A VARIAVEL "LINHA"

    }
    
}

  lc.setColumn(0,0,linha[0]); // OQUE SERA EXIBIDO NA LINHA 1 DA MATRIZ 
  lc.setColumn(0,1,linha[1]); // OQUE SERA EXIBIDO NA LINHA 2 DA MATRIZ
  lc.setColumn(0,2,linha[2]); // OQUE SERA EXIBIDO NA LINHA 3 DA MATRIZ
  lc.setColumn(0,3,linha[3]); // OQUE SERA EXIBIDO NA LINHA 4 DA MATRIZ
  lc.setColumn(0,4,linha[4]); // OQUE SERA EXIBIDO NA LINHA 5 DA MATRIZ
  lc.setColumn(0,5,linha[5]); // OQUE SERA EXIBIDO NA LINHA 6 DA MATRIZ
  lc.setColumn(0,6,linha[6]); // OQUE SERA EXIBIDO NA LINHA 7 DA MATRIZ
  lc.setColumn(0,7,linha[7]); // OQUE SERA EXIBIDO NA LINHA 8 DA MATRIZ

 }
 }
