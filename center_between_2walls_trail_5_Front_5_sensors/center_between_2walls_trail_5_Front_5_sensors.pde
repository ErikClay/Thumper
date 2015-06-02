// Sweep Sample
// Copyright (c) 2012 Dimension Engineering LLC
// See license.txt for license details.

#include <SabertoothSimplified.h>

#define trig_RF 39
#define echo_RF 38
#define trig_RB 13
#define echo_RB 12
#define trig_F 11
#define echo_F 10
#define trig_LF 9
#define echo_LF 8
#define trig_LB 37
#define echo_LB 36



SabertoothSimplified ST; // We'll name the Sabertooth object ST.
                         // For how to configure the Sabertooth, see the DIP Switch Wizard for
                         //   http://www.dimensionengineering.com/datasheets/SabertoothDIPWizard/start.htm
                         // Be sure to select Simplified Serial Mode for use with this library.
                         // This sample uses a baud rate of 9600.
                         //
                         // Connections to make:
                         //   Arduino TX->1  ->  Sabertooth S1
                         //   Arduino GND    ->  Sabertooth 0V
                         //   Arduino VIN    ->  Sabertooth 5V (OPTIONAL, if you want the Sabertooth to power the Arduino)
                         //
                         // Motor 1 = Left
                         // Motor 2 = Right
                         // F= Front
                         // RF= Right Front
                         // LF= Left Front
                         // RB= Right Back
                         // LB= Left Back
void setup()
{
  SabertoothTXPinSerial.begin(9600);
  Serial.begin(9600);
  //Setups each pin as a inpur or output
  // Trigger pins are Outputs
  // Echo pins are inputs
  pinMode(trig_RF, OUTPUT);
  pinMode(echo_RF, INPUT);
  pinMode(trig_RB, OUTPUT);
  pinMode(echo_RB, INPUT);
  pinMode(trig_F, OUTPUT);
  pinMode(echo_F, INPUT);
  pinMode(trig_LF, OUTPUT);
  pinMode(echo_LF, INPUT);
  pinMode(trig_LB, OUTPUT);
  pinMode(echo_LB, INPUT);

}

//*** MAIN ***

void loop(){
  //**Test sensors ar working properly**
//  int RF=ping_Rfront();
//  int F=ping_front();
//  int LF=ping_Lfront();
//  int RB=ping_Rback();
//  int LB=ping_Lback();
//  
//  Serial.print(RF);
//  Serial.println(" Right front");
//  Serial.print(RB);
//  Serial.println(" Right back");
//  Serial.print(F);
//  Serial.println(" Front");
//  Serial.print(LF);
//  Serial.println(" Left front");
//  Serial.print(LB);
//  Serial.println(" Left back");
//  delay(100);


  //**Motor Control**
 int power_F, power_B;
 int RF_value = ping_Rfront();
 int RB_value = ping_Rback();
 int F_value = ping_front();
 int LF_value = ping_Lfront();
 int LB_value = ping_Lback();
  
 while(ping_Lfront() >=  ping_Rback() && ping_Lfront() > ping_Rfront() && ping_front() > 30 ){
 
        if(LF_value > RF_value){
          
         ST.motor(1, 45);
         ST.motor(2, 60);
           // turns vehicle to the left.
      }
  }
  
 while(ping_Rfront() <= (ping_Lfront() + 3) && ping_Rfront() >= ping_Lfront() && ping_front() > 30){
        
        if (RF_value > LF_value){
          
        ST.motor(1, 60);
        ST.motor(2, 55);
        
        // turns vehicle slightly right.
        }
        else if (RF_value == LF_value){
          
          ST.motor(1, 60);
          ST.motor(1, 60);
        // keeps vehicle straight.
        }
      }

//  
// while (ping_Rfront() == ping_Rback() && ping_front() > 30){
//         
//         if (RB_value == LF_value){
//           
//             ST.motor(1, 60);
//             ST.motor(2, 60);
//        }
//        
//        else if((ping_Lfront() - 1) > ping_Lback() && ping_front() > 30 ){
//           
//              if (LF_value > LB_value){
//    
//                 ST.motor(1, 60);
//                 ST.motor(2, 50);
//                  // turns the thumber slightly to the right.
//                }
//       }
//        else if((ping_Lfront() + 1) <  ping_Lback() && ping_front() > 30 ){    
//              
//              if (LF_value < LB_value){
//    
//                 ST.motor(1, 50);
//                 ST.motor(2, 60);
//                  // turns the thumber slightly to the left.
//              }
//            }
//   }
 
//   while(ping_Rfront() >=  ping_Lback() && ping_front() > 30 ){
//    
//    int RF_value = ping_Rfront();
//    int LB_value = ping_Lback();
//  //  int LB_value = ping_Lback();
//    int RB_value = ping_Rback();
//    
//   if (RF_value == LB_value){
//        
//        while (ping_Rfront() == ping_Rback()){
//         
//         ST.motor(1, 60);
//         ST.motor(2, 60);
//        }
//        
//         while((ping_Rfront() - 1) >  ping_Rback() && ping_front() > 30 ){
//           
//              if (RF_value > RB_value){
//    
//                 ST.motor(1, 60);
//                 ST.motor(2, 50);
//                  // turns the thumber slightly to the left.
//                } 
//         }
////         while((ping_Rfront() + 1) <  ping_Rback() && ping_front() > 30 ){   
////              
////              if (RF_value < RB_value){
////    
////                 ST.motor(1, 63);
////                 ST.motor(2, 50);
////                  // turns the thumber slightly to the right.
////                }
////         }
//   }
//   else if (RF_value > LB_value && RF_value > LF_value){
//    
//         ST.motor(1, 60);
//         ST.motor(2, 45);
//     // turns the thumper to the right.
//    }  
//   }

//** STOPING CODE**
  while(ping_front() <= 30){
    
   int F_value = ping_front();
   
    if (F_value <= 30 && F_value >= 8){
      
      ST.motor(1,0);
      ST.motor(2,0);
     // Reverse vehicle if its to close.
    }
    else if(F_value < 8){ 
      ST.motor(1,-30);
      ST.motor(2,-30);
    // Stops vehicle if something is in front of it.
    }
  }

   delay(250);
}
// *** FUNCTIONS ***

long ping_Rfront(){
  // Right front ultrasonic sensor of the vehicle.
  long duration, distance;
  
  digitalWrite(trig_RF, LOW);
  delayMicroseconds(2);
  digitalWrite(trig_RF, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig_RF, LOW);
  duration = pulseIn(echo_RF, HIGH);
  distance = ((duration/2) / 29.1);
  
  return distance; // returns distance in cm.
}

long ping_Rback(){
  //Right rear ultrasonic sensor of the vehicle.
  long duration, distance;
  
  digitalWrite(trig_RB, LOW);
  delayMicroseconds(50);
  digitalWrite(trig_RB, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig_RB, LOW);
  duration = pulseIn(echo_RB, HIGH);
  distance = ((duration/2) / 29.1);

  return distance; // returns distance in cm.

}

long ping_front(){
  //Front ultrasonic sensor of the vehicle.
  long duration, distance;
  
  digitalWrite(trig_F, LOW);
  delayMicroseconds(50);
  digitalWrite(trig_F, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig_F, LOW);
  duration = pulseIn(echo_F, HIGH);
  distance = ((duration/2) / 29.1);

  return distance; // returns distance in cm.
}

long ping_Lfront(){
  //Left front ultrasonic sensor of the vehicle.
  long duration, distance;
  
  digitalWrite(trig_LF, LOW);
  delayMicroseconds(50);
  digitalWrite(trig_LF, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig_LF, LOW);
  duration = pulseIn(echo_LF, HIGH);
  distance = ((duration/2) / 29.1);

  return distance; // returns distance in cm.
}
long ping_Lback(){
  //Left rear ultrasonic sensor of the vehicle.
  long duration, distance;
  
  digitalWrite(trig_LB, LOW);
  delayMicroseconds(50);
  digitalWrite(trig_LB, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig_LB, LOW);
  duration = pulseIn(echo_LB, HIGH);
  distance = ((duration/2) / 29.1);

  return distance; // returns distance in cm.
}
