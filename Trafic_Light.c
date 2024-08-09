#define green1 portb.b1
#define yellow1 portb.b2
#define red1 portb.b3
#define green2 portb.b4
#define yellow2 portb.b5
#define red2 portb.b6

#define PORT_A 0
#define PORT_B 1
#define PORT_C 2
#define PORT_D 3
#define PORT_E 4

#define Manual_Automatic_switch PORTB.B7


unsigned short int click=0;


void Douple_Dabble(int port1 , int port2,int x );
void port (int port_num, int i);
void Manual();


void interrupt(){
    if(INTF_BIT==1){     //manual interrrupt
       INTF_BIT=0;
       click++;
}
}


 void main(void) {
      unsigned short int i=0;
      adcon1=6;       //to make port a work as output
      trisa=0;
      trisb=0b10000001;
      trisc=0;
      trisd=0;
      porta=255;
      portb=0;
      portc=0;
      portd=0;
     GIE_BIT=1;        //global interrupt enable
      INTE_BIT=1;      //interrupt enable bit
      INTEDG_BIT=0;    //faling edge
      NOT_RBPU_BIT=0;  // pull up inside the system

for(;;){
Manual();
 for(i=1 ;i<=12;i++){
 Manual();                   //check for Manual operation
 red1=1;green1=0;yellow1=0;  //east
 red2=0;green2=1;yellow2=0;  // west
 Douple_Dabble(PORT_C,PORT_D,i);
 }
  i=1;
 for(i ;i<=3 ;i++){
 Manual();
 red1=1;green1=0;yellow1=0;
 red2=0;green2=0;yellow2=1;
 Douple_Dabble(PORT_C,PORT_D,i+12);
  }
 i=1;
 for(i ;i<=20 ;i++){
 Manual();
 red1=0;green1=1;yellow1=0;
 red2=1;green2=0;yellow2=0;
 Douple_Dabble(PORT_C,PORT_D,i);
    }
 i=1;
for(i ;i<=3 ;i++){
Manual();
 red1=0;green1=0;yellow1=1;
 red2=1;green2=0;yellow2=0;
 Douple_Dabble(PORT_C,PORT_D,i+20);
 }

 }
}


void Douple_Dabble(int port1 , int port2,int x ){      //display numbers from 0 to 23 on 2 SevenSegments
     if(x<=9){
          port (port1, x);
          port (port2, x);
          delay_ms(1000);
     }
     else if(x>=10 && x<=19){
           port (port1 , x+6);
           port (port2 , x+6);
           delay_ms(1000);
     }
     else if(x>=20){
           port (port1 , x+12);
           port (port2 , x+12);
           delay_ms(1000);
     }
}


void port (int port_num , int i){         //select port
     switch(port_num){
          case PORT_A:
               porta=i;
               break;
          case PORT_B:
               portb=i;
               break;
          case PORT_C:
               portc=i;
               break;
          case PORT_D:
               portd=i;
               break;
          case PORT_E:
               porte=i;
               break;
     }
}


void Manual(){
unsigned short int delay=0;
while(Manual_Automatic_switch==0){  //press to switch Manual
   while(click==1){
          for(delay ;delay<3 ;delay++ ){
             red1=1;green1=0;yellow1=0;
             red2=0;green2=0;yellow2=1;      //yellow stays 3 sec to aviod accidents
             Douple_Dabble(PORT_C,PORT_D,(delay+1));
           }
           delay=3;
           red2=0;green2=1;yellow2=0;  //stop the east street and start the west for the passengers to cross the road
       }
       delay=0;
   while(click==2){
           for(delay ;delay<3 ;delay++ ){
             red1=0;green1=0;yellow1=1;
             red2=1;green2=0;yellow2=0;    //yellow stays 3 sec to aviod accidents
             Douple_Dabble(PORT_C,PORT_D,(delay+1));
             }
            delay=3;                  //to stop thr loop
           red1=0;green1=1;yellow1=0;
       }
}
click=0;     //to star over with 0 clicks
 }