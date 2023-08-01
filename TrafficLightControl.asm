
_main:

;TrafficLightControl.c,16 :: 		void main() {
;TrafficLightControl.c,17 :: 		trisb=0;trisc=0;trisd=0;              //make ports a ,b and c as output
	CLRF       TRISB+0
	CLRF       TRISC+0
	CLRF       TRISD+0
;TrafficLightControl.c,18 :: 		trisb.b0=1;                           //make interrupt bin as input
	BSF        TRISB+0, 0
;TrafficLightControl.c,19 :: 		trisb.b7=1;                           //make button bin as input
	BSF        TRISB+0, 7
;TrafficLightControl.c,20 :: 		portd.b0=1;                           // turns 7-segments display on
	BSF        PORTD+0, 0
;TrafficLightControl.c,21 :: 		Global();
	CALL       _Global+0
;TrafficLightControl.c,22 :: 		bin_flag();
	CALL       _bin_flag+0
;TrafficLightControl.c,23 :: 		while (1)
L_main0:
;TrafficLightControl.c,25 :: 		start=0;
	CLRF       _start+0
	CLRF       _start+1
;TrafficLightControl.c,26 :: 		system();
	CALL       _system+0
;TrafficLightControl.c,27 :: 		}}
	GOTO       L_main0
L_end_main:
	GOTO       $+0
; end of _main

_steady:

;TrafficLightControl.c,28 :: 		steady()// making the counter continue numbering when it shifted into manual till yellow
;TrafficLightControl.c,30 :: 		for(;counter>=0;counter--)
L_steady2:
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__steady58
	MOVLW      0
	SUBWF      _counter+0, 0
L__steady58:
	BTFSS      STATUS+0, 0
	GOTO       L_steady3
;TrafficLightControl.c,32 :: 		portc=counter;
	MOVF       _counter+0, 0
	MOVWF      PORTC+0
;TrafficLightControl.c,33 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_steady5:
	DECFSZ     R13+0, 1
	GOTO       L_steady5
	DECFSZ     R12+0, 1
	GOTO       L_steady5
	DECFSZ     R11+0, 1
	GOTO       L_steady5
	NOP
	NOP
;TrafficLightControl.c,30 :: 		for(;counter>=0;counter--)
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;TrafficLightControl.c,34 :: 		}
	GOTO       L_steady2
L_steady3:
;TrafficLightControl.c,35 :: 		yellow=1;
	MOVLW      1
	MOVWF      _yellow+0
	MOVLW      0
	MOVWF      _yellow+1
;TrafficLightControl.c,36 :: 		flag++;
	INCF       _flag+0, 1
	BTFSC      STATUS+0, 2
	INCF       _flag+1, 1
;TrafficLightControl.c,37 :: 		}
L_end_steady:
	RETURN
; end of _steady

_system:

;TrafficLightControl.c,38 :: 		void system ()//automatic system mode
;TrafficLightControl.c,40 :: 		if (flag%2==0)
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       _flag+1, 0
	MOVWF      R1+1
	MOVLW      0
	ANDWF      R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__system60
	MOVLW      0
	XORWF      R1+0, 0
L__system60:
	BTFSS      STATUS+0, 2
	GOTO       L_system6
;TrafficLightControl.c,41 :: 		counter =35;
	MOVLW      35
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
	GOTO       L_system7
L_system6:
;TrafficLightControl.c,43 :: 		counter=21;
	MOVLW      21
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
L_system7:
;TrafficLightControl.c,44 :: 		back = counter;
	MOVF       _counter+0, 0
	MOVWF      _back+0
	MOVF       _counter+1, 0
	MOVWF      _back+1
;TrafficLightControl.c,45 :: 		portb=0;
	CLRF       PORTB+0
;TrafficLightControl.c,46 :: 		portd.b0=1;
	BSF        PORTD+0, 0
;TrafficLightControl.c,47 :: 		for (;counter>=0||automatic==1;counter--)
L_system8:
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__system61
	MOVLW      0
	SUBWF      _counter+0, 0
L__system61:
	BTFSC      STATUS+0, 0
	GOTO       L__system51
	MOVLW      0
	XORWF      _automatic+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__system62
	MOVLW      1
	XORWF      _automatic+0, 0
L__system62:
	BTFSC      STATUS+0, 2
	GOTO       L__system51
	GOTO       L_system9
L__system51:
;TrafficLightControl.c,49 :: 		if (automatic==1)
	MOVLW      0
	XORWF      _automatic+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__system63
	MOVLW      1
	XORWF      _automatic+0, 0
L__system63:
	BTFSS      STATUS+0, 2
	GOTO       L_system13
;TrafficLightControl.c,51 :: 		automatic=0;
	CLRF       _automatic+0
	CLRF       _automatic+1
;TrafficLightControl.c,52 :: 		portd.b0=1;
	BSF        PORTD+0, 0
;TrafficLightControl.c,53 :: 		if (yellow) //change the case after yellow LED turns off
	MOVF       _yellow+0, 0
	IORWF      _yellow+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_system14
;TrafficLightControl.c,55 :: 		back=56-back;
	MOVF       _back+0, 0
	SUBLW      56
	MOVWF      R0+0
	MOVF       _back+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R0+1
	SUBWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _back+0
	MOVF       R0+1, 0
	MOVWF      _back+1
;TrafficLightControl.c,56 :: 		counter=back;
	MOVF       R0+0, 0
	MOVWF      _counter+0
	MOVF       R0+1, 0
	MOVWF      _counter+1
;TrafficLightControl.c,57 :: 		yellow=0;
	CLRF       _yellow+0
	CLRF       _yellow+1
;TrafficLightControl.c,58 :: 		}
	GOTO       L_system15
L_system14:
;TrafficLightControl.c,61 :: 		counter=back;
	MOVF       _back+0, 0
	MOVWF      _counter+0
	MOVF       _back+1, 0
	MOVWF      _counter+1
L_system15:
;TrafficLightControl.c,62 :: 		if (start)
	MOVF       _start+0, 0
	IORWF      _start+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_system16
;TrafficLightControl.c,64 :: 		return;
	GOTO       L_end_system
;TrafficLightControl.c,65 :: 		}}
L_system16:
L_system13:
;TrafficLightControl.c,66 :: 		if (counter==31||counter==15)
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__system64
	MOVLW      31
	XORWF      _counter+0, 0
L__system64:
	BTFSC      STATUS+0, 2
	GOTO       L__system50
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__system65
	MOVLW      15
	XORWF      _counter+0, 0
L__system65:
	BTFSC      STATUS+0, 2
	GOTO       L__system50
	GOTO       L_system19
L__system50:
;TrafficLightControl.c,67 :: 		counter-=6;
	MOVLW      6
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
L_system19:
;TrafficLightControl.c,68 :: 		portc=counter;
	MOVF       _counter+0, 0
	MOVWF      PORTC+0
;TrafficLightControl.c,69 :: 		traffic();
	CALL       _traffic+0
;TrafficLightControl.c,70 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_system20:
	DECFSZ     R13+0, 1
	GOTO       L_system20
	DECFSZ     R12+0, 1
	GOTO       L_system20
	DECFSZ     R11+0, 1
	GOTO       L_system20
	NOP
	NOP
;TrafficLightControl.c,47 :: 		for (;counter>=0||automatic==1;counter--)
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;TrafficLightControl.c,71 :: 		}
	GOTO       L_system8
L_system9:
;TrafficLightControl.c,72 :: 		flag++;
	INCF       _flag+0, 1
	BTFSC      STATUS+0, 2
	INCF       _flag+1, 1
;TrafficLightControl.c,73 :: 		}
L_end_system:
	RETURN
; end of _system

_traffic:

;TrafficLightControl.c,74 :: 		void traffic()//controlling the LEDs
;TrafficLightControl.c,76 :: 		portb=0;
	CLRF       PORTB+0
;TrafficLightControl.c,77 :: 		if (flag%2==0)
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       _flag+1, 0
	MOVWF      R1+1
	MOVLW      0
	ANDWF      R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__traffic67
	MOVLW      0
	XORWF      R1+0, 0
L__traffic67:
	BTFSS      STATUS+0, 2
	GOTO       L_traffic21
;TrafficLightControl.c,78 :: 		{ portb.b1=1;
	BSF        PORTB+0, 1
;TrafficLightControl.c,79 :: 		if (counter>3||automatic==1)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__traffic68
	MOVF       _counter+0, 0
	SUBLW      3
L__traffic68:
	BTFSS      STATUS+0, 0
	GOTO       L__traffic53
	MOVLW      0
	XORWF      _automatic+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__traffic69
	MOVLW      1
	XORWF      _automatic+0, 0
L__traffic69:
	BTFSC      STATUS+0, 2
	GOTO       L__traffic53
	GOTO       L_traffic24
L__traffic53:
;TrafficLightControl.c,80 :: 		portb.b6=1;
	BSF        PORTB+0, 6
	GOTO       L_traffic25
L_traffic24:
;TrafficLightControl.c,82 :: 		portb.b5=1;
	BSF        PORTB+0, 5
L_traffic25:
;TrafficLightControl.c,84 :: 		}
	GOTO       L_traffic26
L_traffic21:
;TrafficLightControl.c,86 :: 		portb.b4=1;
	BSF        PORTB+0, 4
;TrafficLightControl.c,87 :: 		if (counter>3||automatic==1)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__traffic70
	MOVF       _counter+0, 0
	SUBLW      3
L__traffic70:
	BTFSS      STATUS+0, 0
	GOTO       L__traffic52
	MOVLW      0
	XORWF      _automatic+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__traffic71
	MOVLW      1
	XORWF      _automatic+0, 0
L__traffic71:
	BTFSC      STATUS+0, 2
	GOTO       L__traffic52
	GOTO       L_traffic29
L__traffic52:
;TrafficLightControl.c,88 :: 		portb.b3=1;
	BSF        PORTB+0, 3
	GOTO       L_traffic30
L_traffic29:
;TrafficLightControl.c,90 :: 		portb.b2=1;
	BSF        PORTB+0, 2
L_traffic30:
;TrafficLightControl.c,91 :: 		}}
L_traffic26:
L_end_traffic:
	RETURN
; end of _traffic

_Global:

;TrafficLightControl.c,92 :: 		void Global()//enable global interrupt enable
;TrafficLightControl.c,94 :: 		gie_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;TrafficLightControl.c,95 :: 		}
L_end_Global:
	RETURN
; end of _Global

_bin_flag:

;TrafficLightControl.c,96 :: 		void bin_flag()//enable bin interrupt enable and making the change depending on rising edge
;TrafficLightControl.c,98 :: 		inte_bit=1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;TrafficLightControl.c,99 :: 		intedg_bit=1;  //rising edge
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;TrafficLightControl.c,100 :: 		}
L_end_bin_flag:
	RETURN
; end of _bin_flag

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TrafficLightControl.c,101 :: 		void interrupt()
;TrafficLightControl.c,103 :: 		if (intf_bit==1)
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt31
;TrafficLightControl.c,104 :: 		{  if (portb.b0==0)
	BTFSC      PORTB+0, 0
	GOTO       L_interrupt32
;TrafficLightControl.c,106 :: 		intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;TrafficLightControl.c,107 :: 		return;
	GOTO       L__interrupt75
;TrafficLightControl.c,108 :: 		}
L_interrupt32:
;TrafficLightControl.c,109 :: 		automatic=1; //check if user enters the manual mode or not
	MOVLW      1
	MOVWF      _automatic+0
	MOVLW      0
	MOVWF      _automatic+1
;TrafficLightControl.c,110 :: 		transsition();
	CALL       _transsition+0
;TrafficLightControl.c,111 :: 		choice();
	CALL       _choice+0
;TrafficLightControl.c,112 :: 		}
L_interrupt31:
;TrafficLightControl.c,113 :: 		}
L_end_interrupt:
L__interrupt75:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_transsition:

;TrafficLightControl.c,114 :: 		void transsition()   // make transsition case between manual and automatic if interrupt accident in yellow time
;TrafficLightControl.c,115 :: 		{    if (intf_bit==0)
	BTFSC      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_transsition33
;TrafficLightControl.c,116 :: 		return;
	GOTO       L_end_transsition
L_transsition33:
;TrafficLightControl.c,117 :: 		if (portb.B5==1||portb.b2==1)
	BTFSC      PORTB+0, 5
	GOTO       L__transsition54
	BTFSC      PORTB+0, 2
	GOTO       L__transsition54
	GOTO       L_transsition36
L__transsition54:
;TrafficLightControl.c,119 :: 		steady();
	CALL       _steady+0
;TrafficLightControl.c,120 :: 		traffic();
	CALL       _traffic+0
;TrafficLightControl.c,121 :: 		}
L_transsition36:
;TrafficLightControl.c,122 :: 		}
L_end_transsition:
	RETURN
; end of _transsition

_choice:

;TrafficLightControl.c,123 :: 		void choice () // make the program stay in manual mode and change the traffic depends on changing in button bin
;TrafficLightControl.c,124 :: 		{    portd.B0=0;
	BCF        PORTD+0, 0
;TrafficLightControl.c,125 :: 		while (portb.b0)
L_choice37:
	BTFSS      PORTB+0, 0
	GOTO       L_choice38
;TrafficLightControl.c,127 :: 		while(portb.b0==1&&portb.b7==0);
L_choice39:
	BTFSS      PORTB+0, 0
	GOTO       L_choice40
	BTFSC      PORTB+0, 7
	GOTO       L_choice40
L__choice55:
	GOTO       L_choice39
L_choice40:
;TrafficLightControl.c,128 :: 		if(portb.b0==0)
	BTFSC      PORTB+0, 0
	GOTO       L_choice43
;TrafficLightControl.c,129 :: 		break;
	GOTO       L_choice38
L_choice43:
;TrafficLightControl.c,130 :: 		manual();
	CALL       _manual+0
;TrafficLightControl.c,131 :: 		}
	GOTO       L_choice37
L_choice38:
;TrafficLightControl.c,132 :: 		}
L_end_choice:
	RETURN
; end of _choice

_manual:

;TrafficLightControl.c,133 :: 		void manual() //switch between two manual streats //flag variable make change to leds based on last case
;TrafficLightControl.c,134 :: 		{     start=1;
	MOVLW      1
	MOVWF      _start+0
	MOVLW      0
	MOVWF      _start+1
;TrafficLightControl.c,135 :: 		yellow=0;
	CLRF       _yellow+0
	CLRF       _yellow+1
;TrafficLightControl.c,136 :: 		portb=0;
	CLRF       PORTB+0
;TrafficLightControl.c,137 :: 		for(counter=3;counter>=0;counter--)
	MOVLW      3
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
L_manual44:
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manual79
	MOVLW      0
	SUBWF      _counter+0, 0
L__manual79:
	BTFSS      STATUS+0, 0
	GOTO       L_manual45
;TrafficLightControl.c,139 :: 		portd.b0=1;
	BSF        PORTD+0, 0
;TrafficLightControl.c,140 :: 		portc=counter;
	MOVF       _counter+0, 0
	MOVWF      PORTC+0
;TrafficLightControl.c,141 :: 		if (flag%2==1)
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       _flag+1, 0
	MOVWF      R1+1
	MOVLW      0
	ANDWF      R1+1, 1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manual80
	MOVLW      1
	XORWF      R1+0, 0
L__manual80:
	BTFSS      STATUS+0, 2
	GOTO       L_manual47
;TrafficLightControl.c,143 :: 		portb.b4=1;
	BSF        PORTB+0, 4
;TrafficLightControl.c,144 :: 		portb.b2=1;
	BSF        PORTB+0, 2
;TrafficLightControl.c,145 :: 		}
	GOTO       L_manual48
L_manual47:
;TrafficLightControl.c,148 :: 		portb.B5=1;
	BSF        PORTB+0, 5
;TrafficLightControl.c,149 :: 		portb.B1=1;
	BSF        PORTB+0, 1
;TrafficLightControl.c,150 :: 		}
L_manual48:
;TrafficLightControl.c,151 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manual49:
	DECFSZ     R13+0, 1
	GOTO       L_manual49
	DECFSZ     R12+0, 1
	GOTO       L_manual49
	DECFSZ     R11+0, 1
	GOTO       L_manual49
	NOP
	NOP
;TrafficLightControl.c,137 :: 		for(counter=3;counter>=0;counter--)
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;TrafficLightControl.c,152 :: 		}
	GOTO       L_manual44
L_manual45:
;TrafficLightControl.c,153 :: 		flag++;
	INCF       _flag+0, 1
	BTFSC      STATUS+0, 2
	INCF       _flag+1, 1
;TrafficLightControl.c,154 :: 		traffic();
	CALL       _traffic+0
;TrafficLightControl.c,155 :: 		}
L_end_manual:
	RETURN
; end of _manual
