
//**************************************************************//
//  Name    : Silent Radio Driver                               //
//  Author  : Bob Davis                                         //
//  Date    : 25 April, 2011                                    //
//  Version : 1.0                                               //
//  Based on work of Hari Wiguna - http://g33k.blogspot.com/    //
//****************************************************************
// Pins for the row drivers
int row1Pin = 1;
int row2Pin = 2;
int row3Pin = 3;
int row4Pin = 4;
int row5Pin = 5;
int row6Pin = 6;
int row7Pin = 7;

// Pins for column shift registers
int clockPin = 8;
int dataPin = 9;

// Set the pins to output to the circuit
void setup() {
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);
  pinMode(row1Pin, OUTPUT);
  pinMode(row2Pin, OUTPUT);
  pinMode(row3Pin, OUTPUT);
  pinMode(row4Pin, OUTPUT);
  pinMode(row5Pin, OUTPUT);
  pinMode(row6Pin, OUTPUT);
  pinMode(row7Pin, OUTPUT);
}

//=== B I T M A P ===
//Bits in this array represents one LED of the matrix
// 8 is # of rows, 7 is # of LED matrix we have
byte bitmap[8][12]; // Change the 7 to however many matrices you want to use.
int numZones = sizeof(bitmap) / 8; 
// I will refer to each group of 8 columns (represented by one matrix) as a Zone.
int maxZoneIndex = numZones-1;
int numCols = numZones * 8;

//=== F O N T ===
// Font courtesy of aspro648
// http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1203747843/22
// First char is @, next is A, B, etc.  Only lower case, no symbols.  
// The @ will display as space character.
byte alphabets[][5] = {
  {0,0,0,0,0},
  {31, 36, 68, 36, 31},
  {127, 73, 73, 73, 54},
  {62, 65, 65, 65, 34},
  {127, 65, 65, 34, 28},
  {127, 73, 73, 65, 65},
  {127, 72, 72, 72, 64},
  {62, 65, 65, 69, 38},
  {127, 8, 8, 8, 127},
  {0, 65, 127, 65, 0},
  {2, 1, 1, 1, 126},
  {127, 8, 20, 34, 65},
  {127, 1, 1, 1, 1},
  {127, 32, 16, 32, 127},
  {127, 32, 16, 8, 127},
  {62, 65, 65, 65, 62},
  {127, 72, 72, 72, 48},
  {62, 65, 69, 66, 61},
  {127, 72, 76, 74, 49},
  {50, 73, 73, 73, 38},
  {64, 64, 127, 64, 64},
  {126, 1, 1, 1, 126},
  {124, 2, 1, 2, 124},
  {126, 1, 6, 1, 126},
  {99, 20, 8, 20, 99},
  {96, 16, 15, 16, 96},
  {67, 69, 73, 81, 97},
};

//=== F U N C T I O N S ===
// This routine takes whatever we've setup in the bitmap array and display it on the matrix
void RefreshDisplay()
{
  for (int row = 0; row < 8; row++) {
    //-- turn off the display --
    digitalWrite(row1Pin, LOW);  
    digitalWrite(row2Pin, LOW);  
    digitalWrite(row3Pin, LOW);  
    digitalWrite(row4Pin, LOW);  
    digitalWrite(row5Pin, LOW);  
    digitalWrite(row6Pin, LOW);  
    digitalWrite(row7Pin, LOW); 
    //-- Shift out to each matrix (zone is 8 columns represented by one matrix)
    for (int zone = maxZoneIndex; zone >= 0; zone--) {
//    for (int zone = 0; zone <= maxZoneIndex; zone++) {
      shiftOut(dataPin, clockPin, MSBFIRST, bitmap[row][zone]);
    }

    //-- turn the current row on --
    if (row == 1) digitalWrite (row1Pin, HIGH);  
    if (row == 2) digitalWrite (row2Pin, HIGH);  
    if (row == 3) digitalWrite (row3Pin, HIGH);  
    if (row == 4) digitalWrite (row4Pin, HIGH);  
    if (row == 5) digitalWrite (row5Pin, HIGH);  
    if (row == 6) digitalWrite (row6Pin, HIGH);  
    if (row == 7) digitalWrite (row7Pin, HIGH);  

    //-- Wait a little bit to get more brightness --
    delayMicroseconds(1000);
  }
}

// Converts row and colum to actual bitmap bit and turn it off/on
void Plot(int col, int row, bool isOn)
{
  int zone = col / 8;
  int colBitIndex = col % 8;
  byte colBit = 1 << colBitIndex;
  if (isOn)
    bitmap[row][zone] =  bitmap[row][zone] | colBit;
  else
    bitmap[row][zone] =  bitmap[row][zone] & (~colBit);
}

// Plot each character of the message one column at a time, updated the display, shift bitmap left.
void AlphabetSoup()
{
  char msg[] = "ARDUINO LED SIGN";
  //OLD-for (int charIndex=0; charIndex < (sizeof(msg)-1); charIndex++)
  for (int charIndex=(sizeof(msg)-1); charIndex >= 0 ; charIndex--)
  {
    int alphabetIndex = msg[charIndex] - '@';
    if (alphabetIndex < 0) alphabetIndex=0;
    //-- Draw one character of the message --
    // Each character is only 5 columns wide
    //OLD-for (int col = 0; col < 7; col++)
    for (int col = 5; col >= 0; col--)
    {
      for (int row = 0; row < 8; row++)
      {
        // Set the pixel to the alphabet for columns 0 thru 4
        bool isOn = 0;
        if (col<5) isOn = bitRead( alphabets[alphabetIndex][col], 7-row ) == 1;
        Plot( numCols-1, row, isOn); 
      }
      //-- The more times you repeat this loop, the slower we would scroll --
      for (int refreshCount=0; refreshCount < 20; refreshCount++)
        RefreshDisplay();

      //-- Shift the bitmap one column to left --
      for (int row=0; row<8; row++)
      {
//        for (int zone=numZones; zone > 0; zone--)
        for (int zone=0; zone < numZones; zone++)
        {
          // This right shift would show a left scroll on display.
          bitmap[row][zone] = bitmap[row][zone] >> 1;
//          bitmap[row][zone] = bitmap[row][zone] << 1;
          
          // Roll over lowest bit from the next zone as highest bit of this zone.
          if (zone < maxZoneIndex) bitWrite(bitmap[row][zone], 7, bitRead(bitmap[row][zone+1],0));
        }
      }
    }
  }
} 
//=== L O O P ===
void loop() {
  AlphabetSoup();
} 

