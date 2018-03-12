//****************************************************//
//  Name    : LED Driver                          //
//  Author  : Bob Davis                               //
//  Date    : 5 March, 2013                       //
//  Version : 1.0                                     //
//****************************************************//
// Pins for the LED's
int LED1Pin = 1;
int LED2Pin = 2;
int LED3Pin = 3;
int LED4Pin = 4;
int LED5Pin = 5;
int LED6Pin = 6;
// Set the pins to output to the LED's
void setup() {
  pinMode(LED1Pin, OUTPUT);
  pinMode(LED2Pin, OUTPUT);
  pinMode(LED3Pin, OUTPUT);
  pinMode(LED4Pin, OUTPUT);
  pinMode(LED5Pin, OUTPUT);
  pinMode(LED6Pin, OUTPUT);
}
void loop() {
  digitalWrite (LED1Pin, LOW); 
  digitalWrite (LED2Pin, LOW); 
  digitalWrite (LED3Pin, LOW); 
  digitalWrite (LED4Pin, LOW); 
  digitalWrite (LED5Pin, LOW); 
  digitalWrite (LED6Pin, LOW); 
  if (analogRead(0) < 500) digitalWrite (LED1Pin, HIGH);
  if (analogRead(1) < 500) digitalWrite (LED2Pin, HIGH);
  if (analogRead(2) < 500) digitalWrite (LED3Pin, HIGH);
  if (analogRead(3) < 500) digitalWrite (LED4Pin, HIGH);
  if (analogRead(4) < 500) digitalWrite (LED5Pin, HIGH);
  if (analogRead(5) < 500) digitalWrite (LED6Pin, HIGH);
}

