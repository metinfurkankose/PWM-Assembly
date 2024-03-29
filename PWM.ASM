#include			<PIC16F877A.INC>
__config			H'3F31'

AN0_SONUC	EQU		0X0021
AC			EQU		0X0022
KAPA		EQU		0X0023
GECIKSAY1	EQU		0X0024


ORG			0X0000
GOTO		AYAR

ORG			0X0004
GOTO		KESME

ORG			0X0009
GOTO		MAIN

KESME
RETFIE

AYAR
	BSF			STATUS,RP0
	MOVLW		0X02	
	MOVWF		TRISA	
	CLRF		ADCON1
	CLRF		TRISC
	BCF			STATUS,RP0

	GOTO		MAIN

MAIN
	MOVLW		B'11001001'
	MOVWF		ADCON0
	CALL		US125GECIK
	BSF			ADCON0,2
	BTFSC		ADCON0,2
	GOTO		$-1
	MOVF		ADRESH,W
	MOVWF		AC
	MOVWF		AN0_SONUC
	SUBLW		D'100'
	MOVWF		KAPA
	BSF			PORTC,2
	INCF		AC
	ACIK
		DECFSZ		AC
		GOTO		ACIK
		BCF			PORTC,2
	KAPALI
		DECFSZ		KAPA
		GOTO		KAPALI
	GOTO		MAIN

;------------------GECIKME------------------

US125GECIK						;125 M�KRO SAN�YE GEC�KME
		MOVLW		0X0C
		MOVWF		GECIKSAY1
GEC1	
		DECFSZ		GECIKSAY1,F
		GOTO		GEC1
		RETURN


END