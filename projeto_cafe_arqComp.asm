;Mapeamento:
    RS equ P1.3    ;Seleção pino 3 porta 1, P1.3
    EN equ P1.2    ;Ativando pino 2 porta 1, P1.2

;INICIO
				ORG 0000h
				LJMP START

				ORG 0030h

;Parte inicial, apresentaçao da máquina, escolha do tipo de café e confirmação:
APRESENTACAO1:
	DB "SEJA BEM"
	DB 00h 
	
APRESENTACAO2:
	DB "VINDO!"
	DB 00h 

ESCOLHA:
	DB "ESCOLHA UM"
	DB 00h 

SABOR:
	DB "SABOR"
	DB 00h 

DIGITO1:
	DB "DIGITE 1,2,3"
	DB 00h 

ESPRESSO:
	DB "PARA  ESPRESSO"
	DB 00h 

DIGITO2:
	DB "DIGITE 4,5,6"
	DB 00h 

CAPUCCINO:
	DB "CAPUCCINO"
	DB 00h 

DIGITO3:
	DB "DIGITE 7,8,9"
	DB 00h 

COADO:
	DB "PARA COADO"
	DB 00h 

PERGUNTA:
	DB "VOCE  ESCOLHEU"
	DB 00h

CONFIRMACAO:
	DB "*  SIM"
	DB 00h

CONFIRMACAO1:
	DB "#  NAO"
	DB 00h

ESPRESSO1:
	DB "ESPRESSO"
	DB 00h

CAPUCCINO1:
	DB "CAPUCCINO"
	DB 00h

COADO1:
	DB "   COADO"
	DB 00h

PREPARANDO:
	DB "PREPARANDO"
	DB 00h

CAFE:
	DB "CAFE..."
	DB 00h

PRONTO:
	DB "SEU CAFE ESTA"
	DB 00h

PRONTO1:
	DB "PRONTO!"
	DB 00h


ORG 0100h

START:
;MAPEAMENTO BOTÕES TECLA:
	MOV 40H, #'#' 
	MOV 41H, #'0'
	MOV 42H, #'*'
	MOV 43H, #'9'
	MOV 44H, #'8'
	MOV 45H, #'7'
	MOV 46H, #'6'
	MOV 47H, #'5'
	MOV 48H, #'4'
	MOV 49H, #'3'
	MOV 4AH, #'2'
	MOV 4BH, #'1'

;main:
MAIN:
	MOV R5, #100
	MOV R4, #150
	ACALL lcd_init
	
ROTINA:
	ACALL clearDisplay
	ACALL leituraTeclado
	MOV A, #03h
	ACALL posicaoLetraDisplay

;String inicial da maquina, de msg de BEM VINDO:
	MOV DPTR, #APRESENTACAO1 
	ACALL escreveStringROM
	MOV A, #45h
 	ACALL posicaoLetraDisplay
	MOV DPTR, #APRESENTACAO2         
	ACALL escreveStringROM	
	CALL delay
	ACALL clearDisplay
	MOV A, #06h

;Parte display, SABOR string e ESPRESSO:
	MOV A, #03h
	ACALL posicaoLetraDisplay
	MOV DPTR, #ESCOLHA		
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicaoLetraDisplay
	MOV DPTR, #SABOR
	ACALL escreveStringROM
	MOV A, R5
	MOV B, #10
	DIV AB
	ADD A, #30h
	CALL delay
	ACALL enviaLetra
	ACALL clearDisplay
	MOV A, #02h
	ACALL posicaoLetraDisplay
	MOV DPTR, #DIGITO1		
	ACALL escreveStringROM
	MOV A, #41h
	ACALL posicaoLetraDisplay
	MOV DPTR, #ESPRESSO		
	ACALL escreveStringROM
	CALL delay
	ACALL clearDisplay
	MOV A, #02h
	ACALL posicaoLetraDisplay

;Parte String CAPUCCINO e COADO:
	MOV DPTR, #DIGITO2
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicaoLetraDisplay
	MOV DPTR, #CAPUCCINO	 
	ACALL escreveStringROM
	CALL delay
	ACALL clearDisplay
	MOV A, #02h
	ACALL posicaoLetraDisplay
	MOV DPTR, #DIGITO3		 
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicaoLetraDisplay
	MOV DPTR, #COADO	
	ACALL escreveStringROM
	CALL delay
	ACALL enviaLetra
	ACALL clearDisplay
	MOV A, #03h
	ACALL posicaoLetraDisplay
	MOV DPTR, #ESCOLHA
	ACALL escreveStringROM
	CALL delay

;Sub leitura teclado das opções:
OPCAO:
	ACALL leituraTeclado
	CJNE R0, #11h, OPCAOO1
	ACALL QUESTIONA
OPCAOO1:
	CJNE R0, #10h, OPCAOO2
	ACALL QUESTIONA
OPCAOO2:
	CJNE R0, #9h, OPCAOO3
	ACALL QUESTIONA
OPCAOO3:
	CJNE R0, #8h, OPCAOO4
	ACALL QUESTIONA1
OPCAOO4:
	CJNE R0, #7h, OPCAOO5
	ACALL QUESTIONA1
OPCAOO5:
	CJNE R0, #6h, OPCAOO6
	ACALL QUESTIONA1
OPCAOO6:
	CJNE R0, #5h, OPCAOO7
	ACALL QUESTIONA2
OPCAOO7:
	CJNE R0, #4h, OPCAOO8
	ACALL QUESTIONA2
OPCAOO8:
	CJNE R0, #3h, PROXIMO2
	ACALL QUESTIONA2
PROXIMO2:
	JNB F0, OPCAO
;Retorna para opção até usar o teclado


;Função QUESTIONA, onde pergunta para usuário a confirmação do tipo de café:
QUESTIONA:	
	ACALL clearDisplay
	MOV A, #01h
	ACALL posicaoLetraDisplay
	MOV DPTR, #PERGUNTA
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicaoLetraDisplay
	MOV DPTR, #ESPRESSO1
	ACALL escreveStringROM
	MOV A, R4
	MOV B, #10
	DIV AB
	ADD A, #30h
	CALL delay
	ACALL enviaLetra
	ACALL clearDisplay
	MOV A, #05h
	ACALL posicaoLetraDisplay
	MOV DPTR, #CONFIRMACAO
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicaoLetraDisplay
	MOV DPTR, #CONFIRMACAO1
	ACALL escreveStringROM
	CALL delay
	JMP OPCAO1
RET

;Retorna para a OPCAO1 até usar as teclas * ou # (*Sim  #Não):
OPCAO1:
	ACALL leituraTeclado
	CJNE R0, #2h, PROXIMO3
  	ACALL PREPARANDO1
PROXIMO3:
	CJNE R0, #0h, PROXIMO4
	ACALL clearDisplay
	ACALL ROTINA
PROXIMO4:
	JMP OPCAO1

;String parte de confirmação tipo café:
QUESTIONA1:
	ACALL clearDisplay
	MOV A, #01h
	ACALL posicaoLetraDisplay
	MOV DPTR, #PERGUNTA
	ACALL escreveStringROM
	MOV A, #43h
	ACALL posicaoLetraDisplay
	MOV DPTR, #CAPUCCINO1
	ACALL escreveStringROM
	MOV A, R4
	MOV B, #10
	DIV AB
	ADD A, #30h
	ACALL enviaLetra
	CALL delay
	ACALL clearDisplay
	MOV A, #05h
	ACALL posicaoLetraDisplay
	MOV DPTR, #CONFIRMACAO
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicaoLetraDisplay
	MOV DPTR, #CONFIRMACAO1
	ACALL escreveStringROM
	CALL delay
	JMP OPCAO2
RET

OPCAO2:
	ACALL leituraTeclado
	CJNE R0, #2h, PROXIMO5
  	ACALL PREPARANDO1           
PROXIMO5:
	CJNE R0, #0h, PROXIMO6
	ACALL ROTINA
PROXIMO6:
	JMP OPCAO2

;Limpa/atualiza display:
QUESTIONA2:
	ACALL clearDisplay
	MOV A, #01h
	ACALL posicaoLetraDisplay
	MOV DPTR, #PERGUNTA
	ACALL escreveStringROM
	MOV A, #42h
	ACALL posicaoLetraDisplay
	MOV DPTR, #COADO1
	ACALL escreveStringROM
	MOV A, R4
	MOV B, #10
	DIV AB
	ADD A, #30h
	ACALL enviaLetra
	CALL delay
	ACALL clearDisplay
	MOV A, #05h
	ACALL posicaoLetraDisplay
	MOV DPTR, #CONFIRMACAO
	ACALL escreveStringROM
	MOV A, #45h
	ACALL posicaoLetraDisplay
	MOV DPTR, #CONFIRMACAO1
	ACALL escreveStringROM
	CALL delay
	JMP OPCAO3
RET

;Preparando:
OPCAO3:
	ACALL leituraTeclado
	CJNE R0, #2h, PROXIMO7
  	ACALL PREPARANDO1
PROXIMO7:
	CJNE R0, #0h, PROXIMO8
	ACALL ROTINA
PROXIMO8:
	JMP OPCAO3

;String PREPARANDO:
PREPARANDO1:
	ACALL clearDisplay
	MOV A, #03h
	ACALL posicaoLetraDisplay
	MOV DPTR, #PREPARANDO
	ACALL escreveStringROM
	MOV A, #44h        
	ACALL posicaoLetraDisplay
	MOV DPTR, #CAFE
	ACALL escreveStringROM
	;CALL delay
	CALL delay1
PRONTO2:
	ACALL clearDisplay
	MOV A, #02h
	ACALL posicaoLetraDisplay
	MOV DPTR, #PRONTO
	ACALL escreveStringROM
	MOV A, #44h
	ACALL posicaoLetraDisplay
	MOV DPTR, #PRONTO1
	ACALL escreveStringROM
	CALL delay1
	ACALL clearDisplay
	LJMP ROTINA


;Inicia a String CAFE:
escreveStringROM:
  MOV R1, #00h

;LOOP:
loop:
	MOV A, R1
	MOVC A,@A+DPTR  ;lê memória do programa
	JZ finish		;se o acumulador for 0, então o fim da data foi atingindo, 
	                ;saindo do loop
	
	ACALL enviaLetra	;manda data do acumulador para módulo do LCD display
	INC R1			
  	MOV A, R1
	JMP loop  ;repete o loop
finish:
	RET

leituraTeclado:
  	MOV R0, #0 ; zera R0 para começar a verificação
  	CLR F0

;escaneia a primeira linha:
	MOV P0, #0FFh   
  	CLR P0.0            ;limpa a primeira linha
  	CALL colScan        ;chama subrotina para escanear as colunas
  	JB F0, finish1      ;se a flag F0 estiver definida, sai da subrotina

;escaneia a segunda linha:
  	SETB P0.0           ;define a primeira linha
  	CLR P0.1            ;limpa a segunda linha
	CALL colScan        ;chama subrotina para escanear as colunas
  	JB F0, finish1      ;se F0 for definida, sai da subrotina

;escaneia a terceira linha:
 	SETB P0.1           ;define a segunda linha
 	CLR P0.2            ;limpa a terceira linha
 	CALL colScan        ;chama subrotina para escanear as colunas
  	JB F0, finish1      ;se F0 for definida, sai da subrotina

;escaneia a quarta linha
 	SETB P0.2					;define a terceira linha
  	CLR P0.3					;limpa a quarta linha
  	CALL colScan				;chama subrotina para escanear as colunas
  	JB F0, finish1			;se F0 for definida, sai da subrotina

finish1:
	RET ;retorna se nenhuma tecla foi pressionada

colScan:
  	JNB P0.4, gotKey    ;se a primeira coluna estiver limpa, tecla foi pressionada
  	INC R0              ;incrementa para verificar a próxima tecla
  	JNB P0.5, gotKey    ;verifica a segunda coluna
  	INC R0              ;incrementa para verificar a próxima tecla
  	JNB P0.6, gotKey    ;verifica a terceira coluna
  	INC R0              ;incrementa para verificar a próxima tecla
  	RET                 ;retorna se nenhuma tecla foi encontrada

gotKey:
  	SETB F0             ;define a flag F0 para indicar que uma tecla foi encontrada
  	RET                 ;retorna se uma tecla foi encontrada

;inicializa display, também parte do mapeamento:
lcd_init:

	CLR RS		

	CLR P1.7		
	CLR P1.6
	SETB P1.5
	CLR P1.4

	SETB EN
	CLR EN

;chama delay:
	CALL delay	
	SETB EN
	CLR EN

	SETB P1.7

	SETB EN
	CLR EN

;chama delay novamente:
	CALL delay

	CLR P1.7
	CLR P1.6
	CLR P1.5
	CLR P1.4

	SETB EN
	CLR EN

	SETB P1.6
	SETB P1.5

	SETB EN
	CLR EN

	CALL delay

	CLR P1.7
	CLR P1.6
	CLR P1.5
	CLR P1.4

	SETB EN
	CLR EN

	SETB P1.7
	SETB P1.6
	SETB P1.5
	SETB P1.4

	SETB EN
	CLR EN

	CALL delay
	RET

;Função que envia a letra:
enviaLetra:
	SETB RS
	MOV C, ACC.7
	MOV P1.7, C	
	MOV C, ACC.6
	MOV P1.6, C	
	MOV C, ACC.5
	MOV P1.5, C	
	MOV C, ACC.4
	MOV P1.4, C	

	SETB EN	
	CLR EN	

	MOV C, ACC.3
	MOV P1.7, C	
	MOV C, ACC.2
	MOV P1.6, C	
	MOV C, ACC.1
	MOV P1.5, C	
	MOV C, ACC.0
	MOV P1.4, C	

	SETB EN	
	CLR EN	

	CALL delay	
	CALL delay	
	RET

;Posiciona o cursor na linha e coluna desejada
posicaoLetraDisplay:
	CLR RS	
	SETB P1.7
	MOV C, ACC.6
	MOV P1.6, C	
	MOV C, ACC.5
	MOV P1.5, C	
	MOV C, ACC.4
	MOV P1.4, C	

	SETB EN	
	CLR EN	

	MOV C, ACC.3
	MOV P1.7, C	
	MOV C, ACC.2
	MOV P1.6, C	
	MOV C, ACC.1
	MOV P1.5, C	
	MOV C, ACC.0
	MOV P1.4, C	

	SETB EN	
	CLR EN	

	CALL delay	
	CALL delay  
	RET


;Retorna o cursor para primeira posição sem limpar/atualizar o display:
retornaLetra:
	CLR RS	
	CLR P1.7
	CLR P1.6
	CLR P1.5
	CLR P1.4

	SETB EN	
	CLR EN

	CLR P1.7
	CLR P1.6
	SETB P1.5
	SETB P1.4

	SETB EN	
	CLR EN	

	CALL delay	
	RET


;Limpa/atualiza o display:
clearDisplay:
	CLR RS	
	CLR P1.7
	CLR P1.6
	CLR P1.5
	CLR P1.4

	SETB EN	
	CLR EN

	CLR P1.7
	CLR P1.6
	CLR P1.5
	SETB P1.4

	SETB EN
	CLR EN

	MOV R6, #40
	rotC:
	CALL delay
	DJNZ R6, rotC
	RET


;Primeiro delay:
delay:
	MOV R7, #50
	DJNZ R7, $
	RET

;Segundo delay:
delay1:
	MOV R1, #10
	loop1:
	MOV R0, #255
	DJNZ R0, $
	DJNZ R1, loop1
	RET
