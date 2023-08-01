int counter;   //counts seconds
unsigned int flag=0;      //switch between two streets
int start=0;   //indicator for if the user clicks on the button or not
int automatic=0; //indicator for if the program enters interrupt case or not
int back;       //return the counter from the first
int yellow;     //indicator to change traffic after stopping at yellow
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
trisb=0;trisc=0;trisd=0;              //make ports a ,b and c as output
trisb.b0=1;                           //make interrupt bin as input
trisb.b7=1;                           //make button bin as input
portd.b0=1;                           // turns 7-segments display on
Global();
bin_flag();
while (1)
{
      start=0;
      system();
}}
steady()// making the counter continue numbering when it shifted into manual till yellow
{
    for(;counter>=0;counter--)
    {
      portc=counter;
      delay_ms(1000);
    }
    yellow=1;
    flag++;
}
void system ()//automatic system mode
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
     if (yellow) //change the case after yellow LED turns off
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
void traffic()//controlling the LEDs
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
void Global()//enable global interrupt enable
{
     gie_bit=1;
}
void bin_flag()//enable bin interrupt enable and making the change depending on rising edge
{
     inte_bit=1;
     intedg_bit=1;  //rising edge
}
void interrupt()
{
     if (intf_bit==1)
     {  if (portb.b0==0)
        {
         intf_bit=0;
         return;
        }
        automatic=1; //check if user enters the manual mode or not
        transsition();
        choice();
     }
}
void transsition()   // make transsition case between manual and automatic if interrupt accident in yellow time
{    if (intf_bit==0)
     return;
     if (portb.B5==1||portb.b2==1)
     {
     steady();
     traffic();
     }
}
void choice () // make the program stay in manual mode and change the traffic depends on changing in button bin
{    portd.B0=0;
     while (portb.b0)
     {
        while(portb.b0==1&&portb.b7==0);
        if(portb.b0==0)
        break;
         manual();
     }
     }
void manual() //switch between two manual streats //flag variable make change to leds based on last case
{     start=1;
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