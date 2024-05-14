// DecaDuinoSender
// Ce croquis est un exemple d'utilisation de la librairie DecaDuino
// Il permet d'envoyer des messages avec l'interface UWB
// by Adrien van den Bossche <vandenbo@univ-tlse2.fr>
// Ce croquis fait partir du projet DecaDuino (cf. fichier DecaDuino LICENCE)

#include <SPI.h>
#include <DecaDuino.h>

#define MAX_FRAME_LEN 120

DecaDuino decaduino;  //Interface radio UWB
uint8_t txData[MAX_FRAME_LEN]; // buffer des données émises (tableau d'octets) 
uint16_t txLen; //nombre d'octets émis <= MAC_FRAME_LEN
uint16_t txFrames; // nb de trames émises module 255
uint16_t txReg; // nb de reg émises module 255


void setup()
{
  //Sélection de la LED interne connectée au pin 13 de la carte
  pinMode(13, OUTPUT); 
  Serial.begin(115200); // Init Serial port speed
  SPI.setSCK(14); // Set SPI clock pin (pin 14 on DecaWiNo board)
  // Initialisation de DecaDuino
  if ( !decaduino.init() ) {
    // LED 13 clignotte si init échoue
    Serial.println("decaduino init failed");
    while(1) { digitalWrite(13, HIGH); delay(50); digitalWrite(13, LOW); delay(50); }
  }

  txFrames = 1;

  //On attend 10s avant d'emettre
  delay(5000);
}


void loop()
{
  decaduino.setChannel(7);
  decaduino.setTxPcode(7);
  // On allume la LED interne sur le port 13
  digitalWrite(13, HIGH);


  int code = 7;
  String message = "REZOLOCO";

  txData[0] = code;
  txData[1] = txFrames + 1;
  txData[2] = txReg;
  //Taille des données
  txLen = 3 + message.length();
  for (int i=0; i<txLen; i++) {
    txData[i+3] = message[i];
  }

  Serial.print(txData[0]);
  Serial.print(" - ");
  Serial.print(txData[1]);
  Serial.print(" - ");
  Serial.print(txData[2]);
  Serial.print(" - ");
  for (int i=0; i<txLen; i++) {
    Serial.print(txData[i+3]);
    Serial.print(",");
  }
  
  
  // Envoi de la trame
  decaduino.pdDataRequest(txData, txLen);
  // On attend que la trame soit émise
  while ( !decaduino.hasTxSucceeded() );
  // Log du nb de trames émises
  digitalWrite(13, LOW);
  // Incremente le nb de trames emises
  if ((txFrames % 256) == 255) {
    ++txReg;
  }
  ++txFrames;
  
  //affichage
  Serial.println(' ');
  // Attente de 3 secondes
  delayMicroseconds(1);
}


