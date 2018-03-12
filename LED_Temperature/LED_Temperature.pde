//********************************************//
//  Name    : LED Meter Driver            //
//  Author  : Bob Davis                       //
//  Date    : 12 March, 2013                  //
//  Version : 1.0                             //
//********************************************//
// Pins for the Seven Segments
int SegA = 1;
int SegB = 2;
int SegC = 3;
int SegD = 4;
int SegE = 5;
int SegF = 6;
int SegG = 7;
int DispA = 8;
int DispB = 9;
byte temp = 0;
byte dig1; // left digit
byte dig2; // right digit
int pass = 0;
int digit;
// Set the pins to output to the LED's
void setup() {
  pinMode(SegA, OUTPUT);
  pinMode(SegB, OUTPUT);
  pinMode(SegC, OUTPUT);
  pinMode(SegD, OUTPUT);
  pinMode(SegE, OUTPUT);
  pinMode(SegF, OUTPUT);
  pinMode(SegG, OUTPUT);
  pinMode(DispA, OUTPUT);
  pinMode(DispB, OUTPUT);
}
void loop() {
  // 5V=1024 so if you divide by 2 5V=512
  // 70 degrees is .7 volts is 71.62
  temp = analogRead(0)/2;
  dig1 = temp / 10;  // gives firs digit
  dig2 = (temp % 10); // gives remainder
  if (pass == 0){  
    digitalWrite (DispA, LOW);
    digitalWrite (DispB, HIGH);
    digit = dig1;
    pass = 1;
  }
  else {
    digitalWrite (DispA, HIGH);
    digitalWrite (DispB, LOW);
    digit = dig2;
    pass = 0;
  }
    digitalWrite (SegA, LOW); 
    digitalWrite (SegB, LOW); 
    digitalWrite (SegC, LOW); 
    digitalWrite (SegD, LOW); 
    digitalWrite (SegE, LOW); 
    digitalWrite (SegF, LOW); 
    digitalWrite (SegG, LOW);    
    if (digit == 1){
      digitalWrite (SegB, HIGH);
      digitalWrite (SegC, HIGH);
      }
    if (digit == 2){
      digitalWrite (SegA, HIGH);
      digitalWrite (SegB, HIGH);
      digitalWrite (SegD, HIGH);
      digitalWrite (SegE, HIGH);
      digitalWrite (SegG, HIGH);
      }
    if (digit == 3){
      digitalWrite (SegA, HIGH);
      digitalWrite (SegB, HIGH);
      digitalWrite (SegC, HIGH);
      digitalWrite (SegD, HIGH);
      digitalWrite (SegG, HIGH);
      }
    if (digit == 4){
      digitalWrite (SegB, HIGH);
      digitalWrite (SegC, HIGH);
      digitalWrite (SegF, HIGH);
      digitalWrite (SegG, HIGH);
      }
    if (digit == 5){
      digitalWrite (SegA, HIGH);
      digitalWrite (SegC, HIGH);
      digitalWrite (SegD, HIGH);
      digitalWrite (SegF, HIGH);
      digitalWrite (SegG, HIGH);
      }
    if (digit == 6){
      digitalWrite (SegA, HIGH);
      digitalWrite (SegC, HIGH);
      digitalWrite (SegD, HIGH);
      digitalWrite (SegE, HIGH);
      digitalWrite (SegF, HIGH);
      digitalWrite (SegG, HIGH);
      }
    if (digit == 7){
      digitalWrite (SegA, HIGH);
      digitalWrite (SegB, HIGH);
      digitalWrite (SegC, HIGH);
      }
    if (digit == 8){
      digitalWrite (SegA, HIGH);
      digitalWrite (SegB, HIGH);
      digitalWrite (SegC, HIGH);
      digitalWrite (SegD, HIGH);
      digitalWrite (SegE, HIGH);
      digitalWrite (SegF, HIGH);
      digitalWrite (SegG, HIGH);
      }
    if (digit == 9){
      digitalWrite (SegA, HIGH);
      digitalWrite (SegB, HIGH);
      digitalWrite (SegC, HIGH);
      digitalWrite (SegD, HIGH);
      digitalWrite (SegF, HIGH);
      digitalWrite (SegG, HIGH);
      }
    if (digit == 0){
      digitalWrite (SegA, HIGH);
      digitalWrite (SegB, HIGH);
      digitalWrite (SegC, HIGH);
      digitalWrite (SegD, HIGH);
      digitalWrite (SegE, HIGH);
      digitalWrite (SegF, HIGH);
      }
    delay(10);
   } 


