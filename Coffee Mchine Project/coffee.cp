#line 1 "C:/Users/osama/Desktop/University/Embedded Systems/Coffee Mchine Project/coffee.c"
unsigned char temp;
unsigned int i;
unsigned int j;
unsigned char temp_val[6];

 void MSdelay(unsigned int val)
{
 for(i=0;i<val;i++)
 for(j=0;j<165;j++);
}

 void ADC_init(void){
 ADCON1=0xCE;
 ADCON0= 0x41;
 TRISA=0x01;

}

unsigned int read_temp(void){
 unsigned int read;
 ADCON0 = ADCON0 | 0x04;
 while( ADCON0 & 0x04);
 read=(ADRESH<<8)| ADRESL;
 return (read*500)/1023;
}

void PMW_init(void){

 T2CON = 0b00000101;
 PR2 = 249;


 CCPR1L = 0;
 CCP1CON = 0b00001100;

 CCPR2L = 0;
 CCP2CON = 0b00001100;
}

void pour(void){

 MSdelay(3500);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Pouring..");
 PORTB = 0b00000010;
 MSdelay(60000);
 PORTB = 0b00000000;
}

void enjoy(void){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Enjoy :)");
 MSdelay(5000);
}


sbit LCD_RS at RD4_bit;
sbit LCD_EN at RD5_bit;
sbit LCD_D7 at RD3_bit;
sbit LCD_D6 at RD2_bit;
sbit LCD_D5 at RD1_bit;
sbit LCD_D4 at RD0_bit;


sbit LCD_RS_Direction at TRISD4_bit;
sbit LCD_EN_Direction at TRISD5_bit;
sbit LCD_D7_Direction at TRISD3_bit;
sbit LCD_D6_Direction at TRISD2_bit;
sbit LCD_D5_Direction at TRISD1_bit;
sbit LCD_D4_Direction at TRISD0_bit;





void main() {
 TRISB=0x00;
 TRISC=0x00;
 TRISD=0x00;
 TRISE=0b011;
 ADC_init();

 PORTB=0x00;
 PORTC=0x00;
 PORTD=0x00;
 Lcd_Init();
 PMW_init();
 PORTE=0b000;
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while (1) {
 MSdelay(200);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Select a drink");

 if (PORTE == 0b001) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Preparing..");


 CCPR2L = 249;
 MSdelay(6500);
 CCPR2L = 0;
 Lcd_Cmd(_LCD_CLEAR);


 Lcd_Out(1,1,"Checking temp");
 temp= read_temp();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"The temp is:");
 WordToStr(temp,temp_val);
 Lcd_Out(2,1,temp_val);
 MSdelay(3000);
 Lcd_Cmd(_LCD_CLEAR);

 if(temp>15){
 Lcd_Out(1,1,"Add ice");
 }else{
 Lcd_Out(1,1,"Perfect temp");
 }
 pour();
 enjoy();

 }
 if (PORTE == 0b010) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Preparing..");

 CCPR1L = 249;
 MSdelay(6510/2);
 CCPR1L = 0;

 CCPR2L = 249;
 MSdelay(6510/2);
 CCPR2L = 0;
 Lcd_Cmd(_LCD_CLEAR);


 Lcd_Out(1,1,"Checking temp");
 temp= read_temp();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"The temp is:");
 WordToStr(temp,temp_val);
 Lcd_Out(2,1,temp_val);
 MSdelay(3000);
 Lcd_Cmd(_LCD_CLEAR);

 if(temp>15){
 Lcd_Out(1,1,"Add ice");
 }else{
 Lcd_Out(1,1,"Perfect temp");
 }
 pour();
 enjoy();

 }
 }
}
