
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Trafic_Light.c,25 :: 		void interrupt(){
;Trafic_Light.c,26 :: 		if(INTF_BIT==1){     //manual interrrupt
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;Trafic_Light.c,27 :: 		INTF_BIT=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;Trafic_Light.c,28 :: 		click++;
	INCF       _click+0, 1
;Trafic_Light.c,29 :: 		}
L_interrupt0:
;Trafic_Light.c,30 :: 		}
L_end_interrupt:
L__interrupt47:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Trafic_Light.c,33 :: 		void main(void) {
;Trafic_Light.c,34 :: 		unsigned short int i=0;
	CLRF       main_i_L0+0
;Trafic_Light.c,35 :: 		adcon1=6;       //to make port a work as output
	MOVLW      6
	MOVWF      ADCON1+0
;Trafic_Light.c,36 :: 		trisa=0;
	CLRF       TRISA+0
;Trafic_Light.c,37 :: 		trisb=0b10000001;
	MOVLW      129
	MOVWF      TRISB+0
;Trafic_Light.c,38 :: 		trisc=0;
	CLRF       TRISC+0
;Trafic_Light.c,39 :: 		trisd=0;
	CLRF       TRISD+0
;Trafic_Light.c,40 :: 		porta=255;
	MOVLW      255
	MOVWF      PORTA+0
;Trafic_Light.c,41 :: 		portb=0;
	CLRF       PORTB+0
;Trafic_Light.c,42 :: 		portc=0;
	CLRF       PORTC+0
;Trafic_Light.c,43 :: 		portd=0;
	CLRF       PORTD+0
;Trafic_Light.c,44 :: 		GIE_BIT=1;        //global interrupt enable
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Trafic_Light.c,45 :: 		INTE_BIT=1;      //interrupt enable bit
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;Trafic_Light.c,46 :: 		INTEDG_BIT=0;    //faling edge
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;Trafic_Light.c,47 :: 		NOT_RBPU_BIT=0;  // pull up inside the system
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;Trafic_Light.c,49 :: 		for(;;){
L_main1:
;Trafic_Light.c,50 :: 		Manual();
	CALL       _Manual+0
;Trafic_Light.c,51 :: 		for(i=1 ;i<=12;i++){
	MOVLW      1
	MOVWF      main_i_L0+0
L_main4:
	MOVF       main_i_L0+0, 0
	SUBLW      12
	BTFSS      STATUS+0, 0
	GOTO       L_main5
;Trafic_Light.c,52 :: 		Manual();                   //check for Manual operation
	CALL       _Manual+0
;Trafic_Light.c,53 :: 		red1=1;green1=0;yellow1=0;  //east
	BSF        PORTB+0, 3
	BCF        PORTB+0, 1
	BCF        PORTB+0, 2
;Trafic_Light.c,54 :: 		red2=0;green2=1;yellow2=0;  // west
	BCF        PORTB+0, 6
	BSF        PORTB+0, 4
	BCF        PORTB+0, 5
;Trafic_Light.c,55 :: 		Douple_Dabble(PORT_C,PORT_D,i);
	MOVLW      2
	MOVWF      FARG_Douple_Dabble_port1+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port1+1
	MOVLW      3
	MOVWF      FARG_Douple_Dabble_port2+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port2+1
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_Douple_Dabble_x+0
	CLRF       FARG_Douple_Dabble_x+1
	CALL       _Douple_Dabble+0
;Trafic_Light.c,51 :: 		for(i=1 ;i<=12;i++){
	INCF       main_i_L0+0, 1
;Trafic_Light.c,56 :: 		}
	GOTO       L_main4
L_main5:
;Trafic_Light.c,57 :: 		i=1;
	MOVLW      1
	MOVWF      main_i_L0+0
;Trafic_Light.c,58 :: 		for(i ;i<=3 ;i++){
L_main7:
	MOVF       main_i_L0+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_main8
;Trafic_Light.c,59 :: 		Manual();
	CALL       _Manual+0
;Trafic_Light.c,60 :: 		red1=1;green1=0;yellow1=0;
	BSF        PORTB+0, 3
	BCF        PORTB+0, 1
	BCF        PORTB+0, 2
;Trafic_Light.c,61 :: 		red2=0;green2=0;yellow2=1;
	BCF        PORTB+0, 6
	BCF        PORTB+0, 4
	BSF        PORTB+0, 5
;Trafic_Light.c,62 :: 		Douple_Dabble(PORT_C,PORT_D,i+12);
	MOVLW      2
	MOVWF      FARG_Douple_Dabble_port1+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port1+1
	MOVLW      3
	MOVWF      FARG_Douple_Dabble_port2+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port2+1
	MOVLW      12
	ADDWF      main_i_L0+0, 0
	MOVWF      FARG_Douple_Dabble_x+0
	CLRF       FARG_Douple_Dabble_x+1
	BTFSC      STATUS+0, 0
	INCF       FARG_Douple_Dabble_x+1, 1
	CALL       _Douple_Dabble+0
;Trafic_Light.c,58 :: 		for(i ;i<=3 ;i++){
	INCF       main_i_L0+0, 1
;Trafic_Light.c,63 :: 		}
	GOTO       L_main7
L_main8:
;Trafic_Light.c,64 :: 		i=1;
	MOVLW      1
	MOVWF      main_i_L0+0
;Trafic_Light.c,65 :: 		for(i ;i<=20 ;i++){
L_main10:
	MOVF       main_i_L0+0, 0
	SUBLW      20
	BTFSS      STATUS+0, 0
	GOTO       L_main11
;Trafic_Light.c,66 :: 		Manual();
	CALL       _Manual+0
;Trafic_Light.c,67 :: 		red1=0;green1=1;yellow1=0;
	BCF        PORTB+0, 3
	BSF        PORTB+0, 1
	BCF        PORTB+0, 2
;Trafic_Light.c,68 :: 		red2=1;green2=0;yellow2=0;
	BSF        PORTB+0, 6
	BCF        PORTB+0, 4
	BCF        PORTB+0, 5
;Trafic_Light.c,69 :: 		Douple_Dabble(PORT_C,PORT_D,i);
	MOVLW      2
	MOVWF      FARG_Douple_Dabble_port1+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port1+1
	MOVLW      3
	MOVWF      FARG_Douple_Dabble_port2+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port2+1
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_Douple_Dabble_x+0
	CLRF       FARG_Douple_Dabble_x+1
	CALL       _Douple_Dabble+0
;Trafic_Light.c,65 :: 		for(i ;i<=20 ;i++){
	INCF       main_i_L0+0, 1
;Trafic_Light.c,70 :: 		}
	GOTO       L_main10
L_main11:
;Trafic_Light.c,71 :: 		i=1;
	MOVLW      1
	MOVWF      main_i_L0+0
;Trafic_Light.c,72 :: 		for(i ;i<=3 ;i++){
L_main13:
	MOVF       main_i_L0+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_main14
;Trafic_Light.c,73 :: 		Manual();
	CALL       _Manual+0
;Trafic_Light.c,74 :: 		red1=0;green1=0;yellow1=1;
	BCF        PORTB+0, 3
	BCF        PORTB+0, 1
	BSF        PORTB+0, 2
;Trafic_Light.c,75 :: 		red2=1;green2=0;yellow2=0;
	BSF        PORTB+0, 6
	BCF        PORTB+0, 4
	BCF        PORTB+0, 5
;Trafic_Light.c,76 :: 		Douple_Dabble(PORT_C,PORT_D,i+20);
	MOVLW      2
	MOVWF      FARG_Douple_Dabble_port1+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port1+1
	MOVLW      3
	MOVWF      FARG_Douple_Dabble_port2+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port2+1
	MOVLW      20
	ADDWF      main_i_L0+0, 0
	MOVWF      FARG_Douple_Dabble_x+0
	CLRF       FARG_Douple_Dabble_x+1
	BTFSC      STATUS+0, 0
	INCF       FARG_Douple_Dabble_x+1, 1
	CALL       _Douple_Dabble+0
;Trafic_Light.c,72 :: 		for(i ;i<=3 ;i++){
	INCF       main_i_L0+0, 1
;Trafic_Light.c,77 :: 		}
	GOTO       L_main13
L_main14:
;Trafic_Light.c,79 :: 		}
	GOTO       L_main1
;Trafic_Light.c,80 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_Douple_Dabble:

;Trafic_Light.c,83 :: 		void Douple_Dabble(int port1 , int port2,int x ){      //display numbers from 0 to 23 on 2 SevenSegments
;Trafic_Light.c,84 :: 		if(x<=9){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_Douple_Dabble_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Douple_Dabble50
	MOVF       FARG_Douple_Dabble_x+0, 0
	SUBLW      9
L__Douple_Dabble50:
	BTFSS      STATUS+0, 0
	GOTO       L_Douple_Dabble16
;Trafic_Light.c,85 :: 		port (port1, x);
	MOVF       FARG_Douple_Dabble_port1+0, 0
	MOVWF      FARG_port_port_num+0
	MOVF       FARG_Douple_Dabble_port1+1, 0
	MOVWF      FARG_port_port_num+1
	MOVF       FARG_Douple_Dabble_x+0, 0
	MOVWF      FARG_port_i+0
	MOVF       FARG_Douple_Dabble_x+1, 0
	MOVWF      FARG_port_i+1
	CALL       _port+0
;Trafic_Light.c,86 :: 		port (port2, x);
	MOVF       FARG_Douple_Dabble_port2+0, 0
	MOVWF      FARG_port_port_num+0
	MOVF       FARG_Douple_Dabble_port2+1, 0
	MOVWF      FARG_port_port_num+1
	MOVF       FARG_Douple_Dabble_x+0, 0
	MOVWF      FARG_port_i+0
	MOVF       FARG_Douple_Dabble_x+1, 0
	MOVWF      FARG_port_i+1
	CALL       _port+0
;Trafic_Light.c,87 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Douple_Dabble17:
	DECFSZ     R13+0, 1
	GOTO       L_Douple_Dabble17
	DECFSZ     R12+0, 1
	GOTO       L_Douple_Dabble17
	DECFSZ     R11+0, 1
	GOTO       L_Douple_Dabble17
	NOP
	NOP
;Trafic_Light.c,88 :: 		}
	GOTO       L_Douple_Dabble18
L_Douple_Dabble16:
;Trafic_Light.c,89 :: 		else if(x>=10 && x<=19){
	MOVLW      128
	XORWF      FARG_Douple_Dabble_x+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Douple_Dabble51
	MOVLW      10
	SUBWF      FARG_Douple_Dabble_x+0, 0
L__Douple_Dabble51:
	BTFSS      STATUS+0, 0
	GOTO       L_Douple_Dabble21
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_Douple_Dabble_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Douple_Dabble52
	MOVF       FARG_Douple_Dabble_x+0, 0
	SUBLW      19
L__Douple_Dabble52:
	BTFSS      STATUS+0, 0
	GOTO       L_Douple_Dabble21
L__Douple_Dabble45:
;Trafic_Light.c,90 :: 		port (port1 , x+6);
	MOVF       FARG_Douple_Dabble_port1+0, 0
	MOVWF      FARG_port_port_num+0
	MOVF       FARG_Douple_Dabble_port1+1, 0
	MOVWF      FARG_port_port_num+1
	MOVLW      6
	ADDWF      FARG_Douple_Dabble_x+0, 0
	MOVWF      FARG_port_i+0
	MOVF       FARG_Douple_Dabble_x+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_port_i+1
	CALL       _port+0
;Trafic_Light.c,91 :: 		port (port2 , x+6);
	MOVF       FARG_Douple_Dabble_port2+0, 0
	MOVWF      FARG_port_port_num+0
	MOVF       FARG_Douple_Dabble_port2+1, 0
	MOVWF      FARG_port_port_num+1
	MOVLW      6
	ADDWF      FARG_Douple_Dabble_x+0, 0
	MOVWF      FARG_port_i+0
	MOVF       FARG_Douple_Dabble_x+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_port_i+1
	CALL       _port+0
;Trafic_Light.c,92 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Douple_Dabble22:
	DECFSZ     R13+0, 1
	GOTO       L_Douple_Dabble22
	DECFSZ     R12+0, 1
	GOTO       L_Douple_Dabble22
	DECFSZ     R11+0, 1
	GOTO       L_Douple_Dabble22
	NOP
	NOP
;Trafic_Light.c,93 :: 		}
	GOTO       L_Douple_Dabble23
L_Douple_Dabble21:
;Trafic_Light.c,94 :: 		else if(x>=20){
	MOVLW      128
	XORWF      FARG_Douple_Dabble_x+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Douple_Dabble53
	MOVLW      20
	SUBWF      FARG_Douple_Dabble_x+0, 0
L__Douple_Dabble53:
	BTFSS      STATUS+0, 0
	GOTO       L_Douple_Dabble24
;Trafic_Light.c,95 :: 		port (port1 , x+12);
	MOVF       FARG_Douple_Dabble_port1+0, 0
	MOVWF      FARG_port_port_num+0
	MOVF       FARG_Douple_Dabble_port1+1, 0
	MOVWF      FARG_port_port_num+1
	MOVLW      12
	ADDWF      FARG_Douple_Dabble_x+0, 0
	MOVWF      FARG_port_i+0
	MOVF       FARG_Douple_Dabble_x+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_port_i+1
	CALL       _port+0
;Trafic_Light.c,96 :: 		port (port2 , x+12);
	MOVF       FARG_Douple_Dabble_port2+0, 0
	MOVWF      FARG_port_port_num+0
	MOVF       FARG_Douple_Dabble_port2+1, 0
	MOVWF      FARG_port_port_num+1
	MOVLW      12
	ADDWF      FARG_Douple_Dabble_x+0, 0
	MOVWF      FARG_port_i+0
	MOVF       FARG_Douple_Dabble_x+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_port_i+1
	CALL       _port+0
;Trafic_Light.c,97 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Douple_Dabble25:
	DECFSZ     R13+0, 1
	GOTO       L_Douple_Dabble25
	DECFSZ     R12+0, 1
	GOTO       L_Douple_Dabble25
	DECFSZ     R11+0, 1
	GOTO       L_Douple_Dabble25
	NOP
	NOP
;Trafic_Light.c,98 :: 		}
L_Douple_Dabble24:
L_Douple_Dabble23:
L_Douple_Dabble18:
;Trafic_Light.c,99 :: 		}
L_end_Douple_Dabble:
	RETURN
; end of _Douple_Dabble

_port:

;Trafic_Light.c,102 :: 		void port (int port_num , int i){         //select port
;Trafic_Light.c,103 :: 		switch(port_num){
	GOTO       L_port26
;Trafic_Light.c,104 :: 		case PORT_A:
L_port28:
;Trafic_Light.c,105 :: 		porta=i;
	MOVF       FARG_port_i+0, 0
	MOVWF      PORTA+0
;Trafic_Light.c,106 :: 		break;
	GOTO       L_port27
;Trafic_Light.c,107 :: 		case PORT_B:
L_port29:
;Trafic_Light.c,108 :: 		portb=i;
	MOVF       FARG_port_i+0, 0
	MOVWF      PORTB+0
;Trafic_Light.c,109 :: 		break;
	GOTO       L_port27
;Trafic_Light.c,110 :: 		case PORT_C:
L_port30:
;Trafic_Light.c,111 :: 		portc=i;
	MOVF       FARG_port_i+0, 0
	MOVWF      PORTC+0
;Trafic_Light.c,112 :: 		break;
	GOTO       L_port27
;Trafic_Light.c,113 :: 		case PORT_D:
L_port31:
;Trafic_Light.c,114 :: 		portd=i;
	MOVF       FARG_port_i+0, 0
	MOVWF      PORTD+0
;Trafic_Light.c,115 :: 		break;
	GOTO       L_port27
;Trafic_Light.c,116 :: 		case PORT_E:
L_port32:
;Trafic_Light.c,117 :: 		porte=i;
	MOVF       FARG_port_i+0, 0
	MOVWF      PORTE+0
;Trafic_Light.c,118 :: 		break;
	GOTO       L_port27
;Trafic_Light.c,119 :: 		}
L_port26:
	MOVLW      0
	XORWF      FARG_port_port_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__port55
	MOVLW      0
	XORWF      FARG_port_port_num+0, 0
L__port55:
	BTFSC      STATUS+0, 2
	GOTO       L_port28
	MOVLW      0
	XORWF      FARG_port_port_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__port56
	MOVLW      1
	XORWF      FARG_port_port_num+0, 0
L__port56:
	BTFSC      STATUS+0, 2
	GOTO       L_port29
	MOVLW      0
	XORWF      FARG_port_port_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__port57
	MOVLW      2
	XORWF      FARG_port_port_num+0, 0
L__port57:
	BTFSC      STATUS+0, 2
	GOTO       L_port30
	MOVLW      0
	XORWF      FARG_port_port_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__port58
	MOVLW      3
	XORWF      FARG_port_port_num+0, 0
L__port58:
	BTFSC      STATUS+0, 2
	GOTO       L_port31
	MOVLW      0
	XORWF      FARG_port_port_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__port59
	MOVLW      4
	XORWF      FARG_port_port_num+0, 0
L__port59:
	BTFSC      STATUS+0, 2
	GOTO       L_port32
L_port27:
;Trafic_Light.c,120 :: 		}
L_end_port:
	RETURN
; end of _port

_Manual:

;Trafic_Light.c,123 :: 		void Manual(){
;Trafic_Light.c,124 :: 		unsigned short int delay=0;
	CLRF       Manual_delay_L0+0
;Trafic_Light.c,125 :: 		while(Manual_Automatic_switch==0){  //press to switch Manual
L_Manual33:
	BTFSC      PORTB+0, 7
	GOTO       L_Manual34
;Trafic_Light.c,126 :: 		while(click==1){
L_Manual35:
	MOVF       _click+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Manual36
;Trafic_Light.c,127 :: 		for(delay ;delay<3 ;delay++ ){
L_Manual37:
	MOVLW      3
	SUBWF      Manual_delay_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Manual38
;Trafic_Light.c,128 :: 		red1=1;green1=0;yellow1=0;
	BSF        PORTB+0, 3
	BCF        PORTB+0, 1
	BCF        PORTB+0, 2
;Trafic_Light.c,129 :: 		red2=0;green2=0;yellow2=1;      //yellow stays 3 sec to aviod accidents
	BCF        PORTB+0, 6
	BCF        PORTB+0, 4
	BSF        PORTB+0, 5
;Trafic_Light.c,130 :: 		Douple_Dabble(PORT_C,PORT_D,(delay+1));
	MOVLW      2
	MOVWF      FARG_Douple_Dabble_port1+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port1+1
	MOVLW      3
	MOVWF      FARG_Douple_Dabble_port2+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port2+1
	MOVF       Manual_delay_L0+0, 0
	ADDLW      1
	MOVWF      FARG_Douple_Dabble_x+0
	CLRF       FARG_Douple_Dabble_x+1
	BTFSC      STATUS+0, 0
	INCF       FARG_Douple_Dabble_x+1, 1
	CALL       _Douple_Dabble+0
;Trafic_Light.c,127 :: 		for(delay ;delay<3 ;delay++ ){
	INCF       Manual_delay_L0+0, 1
;Trafic_Light.c,131 :: 		}
	GOTO       L_Manual37
L_Manual38:
;Trafic_Light.c,132 :: 		delay=3;
	MOVLW      3
	MOVWF      Manual_delay_L0+0
;Trafic_Light.c,133 :: 		red2=0;green2=1;yellow2=0;  //stop the east street and start the west for the passengers to cross the road
	BCF        PORTB+0, 6
	BSF        PORTB+0, 4
	BCF        PORTB+0, 5
;Trafic_Light.c,134 :: 		}
	GOTO       L_Manual35
L_Manual36:
;Trafic_Light.c,135 :: 		delay=0;
	CLRF       Manual_delay_L0+0
;Trafic_Light.c,136 :: 		while(click==2){
L_Manual40:
	MOVF       _click+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_Manual41
;Trafic_Light.c,137 :: 		for(delay ;delay<3 ;delay++ ){
L_Manual42:
	MOVLW      3
	SUBWF      Manual_delay_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Manual43
;Trafic_Light.c,138 :: 		red1=0;green1=0;yellow1=1;
	BCF        PORTB+0, 3
	BCF        PORTB+0, 1
	BSF        PORTB+0, 2
;Trafic_Light.c,139 :: 		red2=1;green2=0;yellow2=0;    //yellow stays 3 sec to aviod accidents
	BSF        PORTB+0, 6
	BCF        PORTB+0, 4
	BCF        PORTB+0, 5
;Trafic_Light.c,140 :: 		Douple_Dabble(PORT_C,PORT_D,(delay+1));
	MOVLW      2
	MOVWF      FARG_Douple_Dabble_port1+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port1+1
	MOVLW      3
	MOVWF      FARG_Douple_Dabble_port2+0
	MOVLW      0
	MOVWF      FARG_Douple_Dabble_port2+1
	MOVF       Manual_delay_L0+0, 0
	ADDLW      1
	MOVWF      FARG_Douple_Dabble_x+0
	CLRF       FARG_Douple_Dabble_x+1
	BTFSC      STATUS+0, 0
	INCF       FARG_Douple_Dabble_x+1, 1
	CALL       _Douple_Dabble+0
;Trafic_Light.c,137 :: 		for(delay ;delay<3 ;delay++ ){
	INCF       Manual_delay_L0+0, 1
;Trafic_Light.c,141 :: 		}
	GOTO       L_Manual42
L_Manual43:
;Trafic_Light.c,142 :: 		delay=3;                  //to stop thr loop
	MOVLW      3
	MOVWF      Manual_delay_L0+0
;Trafic_Light.c,143 :: 		red1=0;green1=1;yellow1=0;
	BCF        PORTB+0, 3
	BSF        PORTB+0, 1
	BCF        PORTB+0, 2
;Trafic_Light.c,144 :: 		}
	GOTO       L_Manual40
L_Manual41:
;Trafic_Light.c,145 :: 		}
	GOTO       L_Manual33
L_Manual34:
;Trafic_Light.c,146 :: 		click=0;     //to star over with 0 clicks
	CLRF       _click+0
;Trafic_Light.c,147 :: 		}
L_end_Manual:
	RETURN
; end of _Manual
