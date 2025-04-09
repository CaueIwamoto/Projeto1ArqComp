					ORG 0000H

					LJMP INICIO

;Definindo variáveis e dados:
					ORG 0030H
;Agua, 9 unidades:
agua: DB 09H

;Cafe moído, 9 unidades:
cafe: DB 09H

;Leite, 6 unidades:
leite: DB 06H

;Gelo, 3 unidades:
gelo: DB 03H


INICIO:
	MOV P3, #00H  ;desliga o led de preparo
	MOV P2, #00H  ;atualiza/limpa displays

;Loop, para mostrar e rodar no display:
LOOP:
	MOV A, P1
	ANL A, #0FH   ;isola P1.0 a P1.3

	MOV R0, A

;Determinando tipo de café e quantidade (espresso ou lungo):
	MOV A, R0
	ANL A, #07H   ;tipo de café (0 a 5)
	MOV R1, A

	MOV A, R0
	ANL A, #08H  ;QUANTIDADE

	JZ QUANT_ESPRESSO  ;bit 3 = 0 espresso
	MOV R2, #02H
	LJMP CHECAR_TIPO

;QUANTIDADE ESPRESSO FUNÇÃO:
QUANT_ESPRESSO:
	MOV R2, #01H    ;espresso = uma unidade de cada


;verificação do tipo de café e ingredientes:
CHECAR_TIPO:
	MOV A, R1
	CJNE A, #00H, T1
	ACALL VERIFICA_AGUA
	ACALL VERIFICA_CAFE
	LJMP PREPARAR

;cafés: espresso, coado, cappuccino,
;barista, caffe latte e caffe gelatto

T1: CJNE A, #01H, T2
	ACALL VERIFICA_AGUA
	ACALL VERIFICA_CAFE
	LJMP PREPARAR

T2: CJNE A, #02H, T3
	ACALL VERIFICA_AGUA
	ACALL VERIFICA_CAFE
	ACALL VERIFICA_LEITE
	LJMP PREPARAR

T3: CJNE A, #03H, T4
	ACALL VERIFICA_AGUA
	ACALL VERIFICA_CAFE
	ACALL VERIFICA_LEITE
	LJMP PREPARAR

T4: CJNE A, #04H, T5
	ACALL VERIFICA_AGUA
	ACALL VERIFICA_CAFE
	ACALL VERIFICA_LEITE
	LJMP PREPARAR

T5:
	ACALL VERIFICA_AGUA
	ACALL VERIFICA_CAFE
	ACALL VERIFICA_LEITE
	ACALL VERIFICA_GELO

	LJMP PREPARAR


;função para simular o preparo:
PREPARAR:
	ACALL SUB_AGUA
	ACALL SUB_CAFE
	MOV A, R1
	CJNE A, #00H, CHK1
	LJMP LIGAR_LED

CHK1: CJNE A, #01H, CHK2
	LJMP LIGAR_LED

CHK2: CJNE A, #02H, CHK3
	ACALL SUB_LEITE
	LJMP LIGAR_LED

CHK3: CJNE A, #03H, CHK4
	ACALL SUB_LEITE
	LJMP LIGAR_LED

CHK4: CJNE A, #04H, CHK5
	ACALL SUB_LEITE
	LJMP LIGAR_LED

CHK5: 
	ACALL SUB_LEITE
	ACALL SUB_GELO

;ligar led:
LIGAR_LED:
	SETB P3.0
	ACALL DELAY
	CLR P3.0

	ACALL ATUALIZA_DISPLAY

	LJMP LOOP

;sub rotinas da verificação café e ingredientes
VERIFICA_AGUA:
	MOV A, agua
	CJNE A, #00H, RET_AGUA
	LJMP LOOP
;return:
RET_AGUA: RET

VERIFICA_CAFE:
	MOV A, cafe
	CJNE A, #00H, RET_CAFE
	LJMP LOOP
;return:
RET_CAFE: RET

VERIFICA_LEITE:
	MOV A, leite
	CJNE A, #00H, RET_LEITE
	LJMP LOOP
;return:
RET_LEITE: RET

VERIFICA_GELO:
	MOV A, gelo
	CJNE A, #00H, RET_GELO
	LJMP LOOP
;return:
RET_GELO: RET


;sub rotinas da simulaçao do preparo
;onde os ingredientes são subtraidos
SUB_AGUA:
	MOV A, agua
	CLR C
	SUBB A, R2
	MOV agua, A
	RET

SUB_CAFE:
	MOV A, cafe
	CLR C
	SUBB A, R2
	MOV cafe, A
	RET

SUB_LEITE:
	MOV A, leite
	CLR C
	SUBB A, R2
	MOV leite, A
	RET

SUB_GELO:
	MOV A, gelo
	CLR C
	SUBB A, R2
	MOV gelo, A
	RET

;funcao atualiza_display, onde ele 
;atualiza o nivel de agua no P2 após
;um café ter sido preparado
ATUALIZA_DISPLAY:
	MOV A, agua
	MOV P2, A
	RET


;funcao delay, pausar o programa
;durante execução
DELAY:
	MOV R3, #0FFH

D1: 
	MOV R4, #0FFH

D2: 
	DJNZ R4, D2
	DJNZ R3, D1
	RET

END
