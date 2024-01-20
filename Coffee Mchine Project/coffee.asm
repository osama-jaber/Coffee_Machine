
_MSdelay:

;coffee.c,6 :: 		void MSdelay(unsigned int val)
;coffee.c,8 :: 		for(i=0;i<val;i++)
	CLRF       _i+0
	CLRF       _i+1
L_MSdelay0:
	MOVF       FARG_MSdelay_val+1, 0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__MSdelay17
	MOVF       FARG_MSdelay_val+0, 0
	SUBWF      _i+0, 0
L__MSdelay17:
	BTFSC      STATUS+0, 0
	GOTO       L_MSdelay1
;coffee.c,9 :: 		for(j=0;j<165;j++);
	CLRF       _j+0
	CLRF       _j+1
L_MSdelay3:
	MOVLW      0
	SUBWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__MSdelay18
	MOVLW      165
	SUBWF      _j+0, 0
L__MSdelay18:
	BTFSC      STATUS+0, 0
	GOTO       L_MSdelay4
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
	GOTO       L_MSdelay3
L_MSdelay4:
;coffee.c,8 :: 		for(i=0;i<val;i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;coffee.c,9 :: 		for(j=0;j<165;j++);
	GOTO       L_MSdelay0
L_MSdelay1:
;coffee.c,10 :: 		}
L_end_MSdelay:
	RETURN
; end of _MSdelay

_ADC_init:

;coffee.c,12 :: 		void ADC_init(void){
;coffee.c,13 :: 		ADCON1=0xCE;
	MOVLW      206
	MOVWF      ADCON1+0
;coffee.c,14 :: 		ADCON0= 0x41;
	MOVLW      65
	MOVWF      ADCON0+0
;coffee.c,15 :: 		TRISA=0x01;
	MOVLW      1
	MOVWF      TRISA+0
;coffee.c,17 :: 		}
L_end_ADC_init:
	RETURN
; end of _ADC_init

_read_temp:

;coffee.c,19 :: 		unsigned int read_temp(void){
;coffee.c,21 :: 		ADCON0 = ADCON0 | 0x04;
	BSF        ADCON0+0, 2
;coffee.c,22 :: 		while( ADCON0 & 0x04);
L_read_temp6:
	BTFSS      ADCON0+0, 2
	GOTO       L_read_temp7
	GOTO       L_read_temp6
L_read_temp7:
;coffee.c,23 :: 		read=(ADRESH<<8)| ADRESL;
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;coffee.c,24 :: 		return (read*500)/1023;
	MOVLW      244
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
;coffee.c,25 :: 		}
L_end_read_temp:
	RETURN
; end of _read_temp

_PMW_init:

;coffee.c,27 :: 		void PMW_init(void){
;coffee.c,29 :: 		T2CON = 0b00000101;  // TMR2ON = 1, T2CKPS1 = 0, T2CKPS0 = 1 (prescaler 4)
	MOVLW      5
	MOVWF      T2CON+0
;coffee.c,30 :: 		PR2 = 249;           // PR2 value for 5 kHz PWM frequency
	MOVLW      249
	MOVWF      PR2+0
;coffee.c,33 :: 		CCPR1L = 0;
	CLRF       CCPR1L+0
;coffee.c,34 :: 		CCP1CON = 0b00001100;  // PWM mode
	MOVLW      12
	MOVWF      CCP1CON+0
;coffee.c,36 :: 		CCPR2L = 0;
	CLRF       CCPR2L+0
;coffee.c,37 :: 		CCP2CON = 0b00001100;  // PWM mode
	MOVLW      12
	MOVWF      CCP2CON+0
;coffee.c,38 :: 		}
L_end_PMW_init:
	RETURN
; end of _PMW_init

_pour:

;coffee.c,40 :: 		void pour(void){
;coffee.c,42 :: 		MSdelay(3500);
	MOVLW      172
	MOVWF      FARG_MSdelay_val+0
	MOVLW      13
	MOVWF      FARG_MSdelay_val+1
	CALL       _MSdelay+0
;coffee.c,43 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,44 :: 		Lcd_Out(1, 1, "Pouring..");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,45 :: 		PORTB = 0b00000010;
	MOVLW      2
	MOVWF      PORTB+0
;coffee.c,46 :: 		MSdelay(60000);
	MOVLW      96
	MOVWF      FARG_MSdelay_val+0
	MOVLW      234
	MOVWF      FARG_MSdelay_val+1
	CALL       _MSdelay+0
;coffee.c,47 :: 		PORTB = 0b00000000;
	CLRF       PORTB+0
;coffee.c,48 :: 		}
L_end_pour:
	RETURN
; end of _pour

_enjoy:

;coffee.c,50 :: 		void enjoy(void){
;coffee.c,51 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,52 :: 		Lcd_Out(1, 1, "Enjoy :)");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,53 :: 		MSdelay(5000);
	MOVLW      136
	MOVWF      FARG_MSdelay_val+0
	MOVLW      19
	MOVWF      FARG_MSdelay_val+1
	CALL       _MSdelay+0
;coffee.c,54 :: 		}
L_end_enjoy:
	RETURN
; end of _enjoy

_main:

;coffee.c,76 :: 		void main() {
;coffee.c,77 :: 		TRISB=0x00;
	CLRF       TRISB+0
;coffee.c,78 :: 		TRISC=0x00;
	CLRF       TRISC+0
;coffee.c,79 :: 		TRISD=0x00;
	CLRF       TRISD+0
;coffee.c,80 :: 		TRISE=0b011;
	MOVLW      3
	MOVWF      TRISE+0
;coffee.c,81 :: 		ADC_init();
	CALL       _ADC_init+0
;coffee.c,83 :: 		PORTB=0x00;
	CLRF       PORTB+0
;coffee.c,84 :: 		PORTC=0x00;
	CLRF       PORTC+0
;coffee.c,85 :: 		PORTD=0x00;
	CLRF       PORTD+0
;coffee.c,86 :: 		Lcd_Init();   // Initialize LCD module
	CALL       _Lcd_Init+0
;coffee.c,87 :: 		PMW_init();
	CALL       _PMW_init+0
;coffee.c,88 :: 		PORTE=0b000;
	CLRF       PORTE+0
;coffee.c,89 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Turn off the cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,91 :: 		while (1) {
L_main8:
;coffee.c,92 :: 		MSdelay(200);
	MOVLW      200
	MOVWF      FARG_MSdelay_val+0
	CLRF       FARG_MSdelay_val+1
	CALL       _MSdelay+0
;coffee.c,93 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,94 :: 		Lcd_Out(1, 1, "Select a drink");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,96 :: 		if (PORTE == 0b001) {  // If button on RD2 is pressed
	MOVF       PORTE+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;coffee.c,97 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,98 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Turn off the cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,99 :: 		Lcd_Out(1, 1, "Preparing..");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,102 :: 		CCPR2L = 249;  // Turn on motor 1
	MOVLW      249
	MOVWF      CCPR2L+0
;coffee.c,103 :: 		MSdelay(6500);   // for a certain amount time  (test it)
	MOVLW      100
	MOVWF      FARG_MSdelay_val+0
	MOVLW      25
	MOVWF      FARG_MSdelay_val+1
	CALL       _MSdelay+0
;coffee.c,104 :: 		CCPR2L = 0;      // turn off the motor
	CLRF       CCPR2L+0
;coffee.c,105 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,108 :: 		Lcd_Out(1,1,"Checking temp");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,109 :: 		temp= read_temp();  // initial reading of the temperature
	CALL       _read_temp+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
;coffee.c,110 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,111 :: 		Lcd_Out(1,1,"The temp is:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,112 :: 		WordToStr(temp,temp_val);
	MOVF       _temp+0, 0
	MOVWF      FARG_WordToStr_input+0
	CLRF       FARG_WordToStr_input+1
	MOVLW      _temp_val+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;coffee.c,113 :: 		Lcd_Out(2,1,temp_val);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _temp_val+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,114 :: 		MSdelay(3000);
	MOVLW      184
	MOVWF      FARG_MSdelay_val+0
	MOVLW      11
	MOVWF      FARG_MSdelay_val+1
	CALL       _MSdelay+0
;coffee.c,115 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,117 :: 		if(temp>15){
	MOVF       _temp+0, 0
	SUBLW      15
	BTFSC      STATUS+0, 0
	GOTO       L_main11
;coffee.c,118 :: 		Lcd_Out(1,1,"Add ice");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,119 :: 		}else{
	GOTO       L_main12
L_main11:
;coffee.c,120 :: 		Lcd_Out(1,1,"Perfect temp");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,121 :: 		}
L_main12:
;coffee.c,122 :: 		pour();
	CALL       _pour+0
;coffee.c,123 :: 		enjoy();
	CALL       _enjoy+0
;coffee.c,125 :: 		}
L_main10:
;coffee.c,126 :: 		if (PORTE == 0b010) {  // If button on RD3 is pressed
	MOVF       PORTE+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main13
;coffee.c,127 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,128 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Turn off the cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,129 :: 		Lcd_Out(1, 1, "Preparing..");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,131 :: 		CCPR1L = 249;  // Turn on motor 2
	MOVLW      249
	MOVWF      CCPR1L+0
;coffee.c,132 :: 		MSdelay(6510/2);   // for half of the certain time  (test it)
	MOVLW      183
	MOVWF      FARG_MSdelay_val+0
	MOVLW      12
	MOVWF      FARG_MSdelay_val+1
	CALL       _MSdelay+0
;coffee.c,133 :: 		CCPR1L = 0;
	CLRF       CCPR1L+0
;coffee.c,135 :: 		CCPR2L = 249;  //Turn on motor 1
	MOVLW      249
	MOVWF      CCPR2L+0
;coffee.c,136 :: 		MSdelay(6510/2); // for half of the time (test it)
	MOVLW      183
	MOVWF      FARG_MSdelay_val+0
	MOVLW      12
	MOVWF      FARG_MSdelay_val+1
	CALL       _MSdelay+0
;coffee.c,137 :: 		CCPR2L = 0;
	CLRF       CCPR2L+0
;coffee.c,138 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,141 :: 		Lcd_Out(1,1,"Checking temp");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,142 :: 		temp= read_temp();  // initial reading of the temperature
	CALL       _read_temp+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
;coffee.c,143 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,144 :: 		Lcd_Out(1,1,"The temp is:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,145 :: 		WordToStr(temp,temp_val);
	MOVF       _temp+0, 0
	MOVWF      FARG_WordToStr_input+0
	CLRF       FARG_WordToStr_input+1
	MOVLW      _temp_val+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;coffee.c,146 :: 		Lcd_Out(2,1,temp_val);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _temp_val+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,147 :: 		MSdelay(3000);
	MOVLW      184
	MOVWF      FARG_MSdelay_val+0
	MOVLW      11
	MOVWF      FARG_MSdelay_val+1
	CALL       _MSdelay+0
;coffee.c,148 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;coffee.c,150 :: 		if(temp>15){
	MOVF       _temp+0, 0
	SUBLW      15
	BTFSC      STATUS+0, 0
	GOTO       L_main14
;coffee.c,151 :: 		Lcd_Out(1,1,"Add ice");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,152 :: 		}else{
	GOTO       L_main15
L_main14:
;coffee.c,153 :: 		Lcd_Out(1,1,"Perfect temp");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_coffee+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;coffee.c,154 :: 		}
L_main15:
;coffee.c,155 :: 		pour();
	CALL       _pour+0
;coffee.c,156 :: 		enjoy();
	CALL       _enjoy+0
;coffee.c,158 :: 		}
L_main13:
;coffee.c,159 :: 		}
	GOTO       L_main8
;coffee.c,160 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
