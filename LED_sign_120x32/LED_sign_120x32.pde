//**********************************
//  Name    : 120x32 Cadaces Driver                          
//  Author  : Bob Davis                               	
//  Date    : 23 February, 2013                       	
//  Version : 1.0                                     	
//**********************************
// Pins for the row drivers
int row1Pin = 2;	//R1
int row2Pin = 7;	//R2
int row3Pin = 1;	//R3
int rowEnable = 8;	//REN
int rclockPin = 6;	//RCK
int clockPin = 3; 	//SCK
int dataPin = 5; 	//RSD
int gdataPin = 4;  	//GSD
int dataPin1 = 9; 	//RSD
int gdataPin1 = 10;  	//GSD
int dataPin2 = 12; 	//RSD
int gdataPin2 = 11;  	//GSD
int dataPin3 = 13; 	//RSD
int gdataPin3 = 1;  	//GSD

// Set the pins to output to the sign
void setup() {
  pinMode(row1Pin, OUTPUT);
  pinMode(row2Pin, OUTPUT);
  pinMode(row3Pin, OUTPUT);
  pinMode(rowEnable, OUTPUT);
  pinMode(rclockPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);
  pinMode(gdataPin, OUTPUT);
  pinMode(dataPin1, OUTPUT);
  pinMode(gdataPin1, OUTPUT);
  pinMode(dataPin2, OUTPUT);
  pinMode(gdataPin2, OUTPUT);
  pinMode(dataPin3, OUTPUT);
  pinMode(gdataPin3, OUTPUT);
}
//=== Character Array ===
// Characters are A, B, C, etc.  Only upper case, no symbols.  
byte alphabets[][8] = {
  {0, 04, 10, 17, 17, 31, 17, 17}, //A
  {0, 30, 17, 17, 30, 17, 17, 30}, //B
  {0, 14, 17, 16, 16, 16, 17, 14}, //C
  {0, 28, 18, 17, 17, 17, 18, 28}, //D
  {0, 31, 16, 16, 31, 16, 16, 31}, //E
  {0, 31, 16, 16, 31, 16, 16, 16}, //F
  {0, 14, 17, 16, 16, 19, 17, 14}, //G
  {0, 17, 17, 17, 31, 17, 17, 17}, //H
  {0, 14, 04, 04, 04, 04, 04, 14}, //I
  {0, 07, 02, 02, 02, 02, 10, 14}, //J
  {0, 17, 18, 20, 24, 20, 18, 17}, //K
  {0, 16, 16, 16, 16, 16, 16, 31}, //L
  {0, 10, 21, 21, 21, 17, 17, 17}, //M
  {0, 17, 25, 25, 21, 19, 19, 17}, //N
  {0, 14, 17, 17, 17, 17, 17, 14}, //O
  {0, 30, 17, 17, 30, 16, 16, 16}, //P
  {0, 14, 17, 17, 17, 17, 19, 15}, //Q
  {0, 30, 17, 17, 30, 20, 18, 17}, //R
  {0, 14, 17, 16, 14, 01, 17, 14}, //S
  {0, 31, 04, 04, 04, 04, 04, 04}, //T
  {0, 17, 17, 17, 17, 17, 17, 14}, //U
  {0, 17, 17, 17, 10, 10, 10, 04}, //V
  {0, 17, 17, 17, 21, 21, 21, 10}, //W
  {0, 17, 17, 10, 04, 10, 17, 17}, //X
  {0, 17, 10, 10, 04, 04, 04, 04}, //Y
  {0, 31, 8, 04, 02, 04, 8, 31}, //Z
  {0, 0, 21, 14, 31, 14, 21, 0}, //*
};
byte numbers[][8] = {
  {0, 04, 12, 04, 04, 04, 04, 14}, //1
  {0, 14, 17, 01, 02, 04, 8, 31}, //2 
  {0, 14, 01, 01, 06, 01, 01, 14}, //3
  {0, 17, 17, 17, 31, 01, 01, 01}, //4
  {0, 31, 16, 16, 14, 01, 17, 14}, //5
  {0, 14, 16, 16, 30, 17, 17, 14}, //6
  {0, 31, 01, 01, 02, 04, 8, 16}, //7
  {0, 14, 17, 17, 14, 17, 17, 14}, //8
  {0, 14, 17, 17, 15, 01, 01, 01}, //9
  {0, 14, 17, 17, 17, 17, 17, 14}, //0
};
byte bitmap[][8] = {  //red characters
  {0, 0,0,0,0,0,0,0},
  {0, 04, 12, 04, 04, 04, 04, 14}, //1
  {0, 14, 17, 01, 02, 04, 8, 31}, //2 
  {0, 14, 17, 17, 17, 17, 17, 14}, //0
  {0, 17, 17, 10, 04, 10, 17, 17}, //X
  {0, 14, 01, 01, 06, 01, 01, 14}, //3
  {0, 14, 17, 01, 02, 04, 8, 31}, //2 
  {0, 0,0,0,0,0,0,0},
  {0,  4, 10, 17, 17, 31, 17, 17}, //A
  {0, 0,0,0,0,0,0,0},
  {0, 28, 18, 17, 17, 17, 18, 28}, //D
  {0, 0,0,0,0,0,0,0},
  {0, 14, 04, 04, 04, 04, 04, 14}, //I
  {0, 17, 25, 25, 21, 19, 19, 17}, //N
  {0, 14, 17, 17, 17, 17, 17, 14}, //O
  {0, 0,0,0,0,0,0,0},
  {0, 14, 17, 16, 14, 01, 17, 14}, //S
  {0, 14, 04, 04, 04, 04, 04, 14}, //I
  {0, 14, 17, 16, 16, 19, 17, 14}, //G
  {0, 17, 25, 25, 21, 19, 19, 17}, //N
  {0, 0,0,0,0,0,0,0},
};
byte gbitmap[][8] = {  //green characters
  {0, 0,0,0,0,0,0,0},
  {0, 04, 12, 04, 04, 04, 04, 14}, //1
  {0, 14, 17, 01, 02, 04, 8, 31}, //2 
  {0, 14, 17, 17, 17, 17, 17, 14}, //0
  {0, 17, 17, 10, 04, 10, 17, 17}, //X
  {0, 14, 01, 01, 06, 01, 01, 14}, //3
  {0, 14, 17, 01, 02, 04, 8, 31}, //2 
  {0, 0,0,0,0,0,0,0},
  {0,  4, 10, 17, 17, 31, 17, 17}, //A
  {0, 30, 17, 17, 30, 20, 18, 17}, //R
  {0, 0,0,0,0,0,0,0},
  {0, 17, 17, 17, 17, 17, 17, 14}, //U
  {0, 14, 04, 04, 04, 04, 04, 14}, //I
  {0, 0,0,0,0,0,0,0},
  {0, 14, 17, 17, 17, 17, 17, 14}, //O
  {0, 0,0,0,0,0,0,0},
  {0, 14, 17, 16, 14, 01, 17, 14}, //S
  {0, 14, 04, 04, 04, 04, 04, 14}, //I
  {0, 14, 17, 16, 16, 19, 17, 14}, //G
  {0, 17, 25, 25, 21, 19, 19, 17}, //N
  {0, 0,0,0,0,0,0,0},
};
void RunSign(){
  for (int row = 7; row > 0; row--) {
    // turn off display
    digitalWrite(rowEnable, HIGH); 
    digitalWrite(rclockPin, LOW); 
    // send serial data to display 18 = number of characters
    for (int character = 0; character < 21; character++){
     for (int shiftbit = 5; shiftbit > -1; shiftbit--){
      digitalWrite(gdataPin, LOW);
      digitalWrite(dataPin, LOW);
      digitalWrite(gdataPin1, LOW);
      digitalWrite(dataPin1, LOW);
      digitalWrite(gdataPin2, LOW);
      digitalWrite(dataPin2, LOW);
      digitalWrite(gdataPin3, LOW);
      digitalWrite(dataPin3, LOW);
      if bitRead(gbitmap[character][row],shiftbit) digitalWrite(gdataPin, HIGH); 
      if bitRead(bitmap[character][row],shiftbit) digitalWrite(dataPin, HIGH); 
      if bitRead(gbitmap[character][row],shiftbit) digitalWrite(gdataPin1, HIGH); 
      if bitRead(bitmap[character][row],shiftbit) digitalWrite(dataPin1, HIGH); 
      if bitRead(gbitmap[character][row],shiftbit) digitalWrite(gdataPin2, HIGH); 
      if bitRead(bitmap[character][row],shiftbit) digitalWrite(dataPin2, HIGH); 
      if bitRead(gbitmap[character][row],shiftbit) digitalWrite(gdataPin3, HIGH); 
      if bitRead(bitmap[character][row],shiftbit) digitalWrite(dataPin3, HIGH); 
      digitalWrite(clockPin, HIGH); digitalWrite(clockPin, LOW);
    } }
    //latch the data
    digitalWrite(rclockPin, HIGH);
    // set up 74138 row sesection and turn display back on
    digitalWrite(row1Pin, LOW);
    digitalWrite(row2Pin, LOW);
    digitalWrite(row3Pin, LOW);
    if bitRead(row,0) digitalWrite (row1Pin, HIGH); 
    if bitRead(row,1) digitalWrite (row2Pin, HIGH); 
    if bitRead(row,2) digitalWrite (row3Pin, HIGH); 
    digitalWrite(rowEnable, LOW);
    // Wait to see what we sent to the display ;
    delayMicroseconds(500); 
  }
}  

//=== L O O P ===
void loop() {
  RunSign();
}

