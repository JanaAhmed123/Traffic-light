#line 1 "C:/Users/Jana Ahmed/Documents/Desktop/Embedded/FinalProjct/Trafic_Light.c"
#line 17 "C:/Users/Jana Ahmed/Documents/Desktop/Embedded/FinalProjct/Trafic_Light.c"
unsigned short int click=0;


void Douple_Dabble(int port1 , int port2,int x );
void port (int port_num, int i);
void Manual();


void interrupt(){
 if(INTF_BIT==1){
 INTF_BIT=0;
 click++;
}
}


 void main(void) {
 unsigned short int i=0;
 adcon1=6;
 trisa=0;
 trisb=0b10000001;
 trisc=0;
 trisd=0;
 porta=255;
 portb=0;
 portc=0;
 portd=0;
 GIE_BIT=1;
 INTE_BIT=1;
 INTEDG_BIT=0;
 NOT_RBPU_BIT=0;

for(;;){
Manual();
 for(i=1 ;i<=12;i++){
 Manual();
  portb.b3 =1; portb.b1 =0; portb.b2 =0;
  portb.b6 =0; portb.b4 =1; portb.b5 =0;
 Douple_Dabble( 2 , 3 ,i);
 }
 i=1;
 for(i ;i<=3 ;i++){
 Manual();
  portb.b3 =1; portb.b1 =0; portb.b2 =0;
  portb.b6 =0; portb.b4 =0; portb.b5 =1;
 Douple_Dabble( 2 , 3 ,i+12);
 }
 i=1;
 for(i ;i<=20 ;i++){
 Manual();
  portb.b3 =0; portb.b1 =1; portb.b2 =0;
  portb.b6 =1; portb.b4 =0; portb.b5 =0;
 Douple_Dabble( 2 , 3 ,i);
 }
 i=1;
for(i ;i<=3 ;i++){
Manual();
  portb.b3 =0; portb.b1 =0; portb.b2 =1;
  portb.b6 =1; portb.b4 =0; portb.b5 =0;
 Douple_Dabble( 2 , 3 ,i+20);
 }

 }
}


void Douple_Dabble(int port1 , int port2,int x ){
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


void port (int port_num , int i){
 switch(port_num){
 case  0 :
 porta=i;
 break;
 case  1 :
 portb=i;
 break;
 case  2 :
 portc=i;
 break;
 case  3 :
 portd=i;
 break;
 case  4 :
 porte=i;
 break;
 }
}


void Manual(){
unsigned short int delay=0;
while( PORTB.B7 ==0){
 while(click==1){
 for(delay ;delay<3 ;delay++ ){
  portb.b3 =1; portb.b1 =0; portb.b2 =0;
  portb.b6 =0; portb.b4 =0; portb.b5 =1;
 Douple_Dabble( 2 , 3 ,(delay+1));
 }
 delay=3;
  portb.b6 =0; portb.b4 =1; portb.b5 =0;
 }
 delay=0;
 while(click==2){
 for(delay ;delay<3 ;delay++ ){
  portb.b3 =0; portb.b1 =0; portb.b2 =1;
  portb.b6 =1; portb.b4 =0; portb.b5 =0;
 Douple_Dabble( 2 , 3 ,(delay+1));
 }
 delay=3;
  portb.b3 =0; portb.b1 =1; portb.b2 =0;
 }
}
click=0;
 }
