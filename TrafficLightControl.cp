#line 1 "C:/Users/mahmoud/Desktop/Traffic Light controller/TrafficLightControl.c"
int counter;
unsigned int flag=0;
int start=0;
int automatic=0;
int back;
int yellow;
void transsition();
void traffic();
void system ();
void interrupt();
void Global();
void choice();
void bin_flag();
void manual();
void steady();
void main() {
trisb=0;trisc=0;trisd=0;
trisb.b0=1;
trisb.b7=1;
portd.b0=1;
Global();
bin_flag();
while (1)
{
 start=0;
 system();
}}
steady()
{
 for(;counter>=0;counter--)
 {
 portc=counter;
 delay_ms(1000);
 }
 yellow=1;
 flag++;
}
void system ()
{
if (flag%2==0)
 counter =35;
 else
 counter=21;
 back = counter;
 portb=0;
 portd.b0=1;
 for (;counter>=0||automatic==1;counter--)
 {
 if (automatic==1)
 {
 automatic=0;
 portd.b0=1;
 if (yellow)
 {
 back=56-back;
 counter=back;
 yellow=0;
 }

 else
 counter=back;
 if (start)
 {
 return;
 }}
 if (counter==31||counter==15)
 counter-=6;
 portc=counter;
 traffic();
 delay_ms(1000);
 }
 flag++;
}
void traffic()
{
 portb=0;
 if (flag%2==0)
 { portb.b1=1;
 if (counter>3||automatic==1)
 portb.b6=1;
 else
 portb.b5=1;

 }
 else{
 portb.b4=1;
 if (counter>3||automatic==1)
 portb.b3=1;
 else
 portb.b2=1;
 }}
void Global()
{
 gie_bit=1;
}
void bin_flag()
{
 inte_bit=1;
 intedg_bit=1;
}
void interrupt()
{
 if (intf_bit==1)
 { if (portb.b0==0)
 {
 intf_bit=0;
 return;
 }
 automatic=1;
 transsition();
 choice();
 }
}
void transsition()
{ if (intf_bit==0)
 return;
 if (portb.B5==1||portb.b2==1)
 {
 steady();
 traffic();
 }
}
void choice ()
{ portd.B0=0;
 while (portb.b0)
 {
 while(portb.b0==1&&portb.b7==0);
 if(portb.b0==0)
 break;
 manual();
 }
 }
void manual()
{ start=1;
 yellow=0;
 portb=0;
 for(counter=3;counter>=0;counter--)
 {
 portd.b0=1;
 portc=counter;
 if (flag%2==1)
 {
 portb.b4=1;
 portb.b2=1;
 }
 else
 {
 portb.B5=1;
 portb.B1=1;
 }
 delay_ms(1000);
 }
 flag++;
 traffic();
 }
