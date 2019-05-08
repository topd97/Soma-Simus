;---------------------------------------------------
; Programa: TRAB1_1
; Autor: Thiago Outeiro
; Data: 14/04/2019
;---------------------------------------------------

ORG 100h

;Declarando variaveis

teste1Alta:       DB   0FEh      ;00010000b
teste1Baixa:      DB   0FFh      ;11111111b
teste2Alta:       DB   0FEh      ;00010000b
teste2Baixa:      DB   0FFh      ;00010010b
precisaDesinverter: DB 0h
somar               DB 0h
retAlto           DS       1
retBaixo          DS       1
var1Alta:         DS       1
var1Baixa:        DS       1
var2Alta:         DS       1
var2Baixa:        DS       1
resultBaixa:      DS       1
resultAlta:       DS       1
VISOR:            EQU      0

ORG 0
INICIO: ;Inicialização de variaveis para a pilha
        LDA teste1Alta
        PUSH
        LDA teste1Baixa
        PUSH
        LDA teste2Alta
        PUSH
        LDA teste2Baixa
        PUSH
        LDA #0
        JMP ROTINA
ROTINA:;Inicio verdadeiro da rotina do exercicio
       ADD #0
       STA  somar
       POP
       STA var2Baixa
       POP
       STA var2Alta
       POP
       STA var1Baixa
       POP
       STA var1Alta
       PUSH
       LDA var1Baixa
       PUSH
       JSR INVERTE
       POP
       POP
       LDA var1Alta
       AND var2Alta
       AND #80h       ;#10000000b
       JNZ INVERTE
CONTINUASOMA:
             LDA var1Baixa
             ADD var2Baixa
             STA resultBaixa
             LDA var1Alta
             ADC var2Alta
             STA resultAlta
             LDA precisaDesinverter
             JNZ DESINVERTE
             JMP IMPRIME
SUBTRACAO:
          POP
          STA resultBaixa
          POP
          STA resultAlta
          POP
          SUB resultBaixa
          STA resultBaixa
          POP
          SUB resultAlta
          STA resultAlta
          JMP IMPRIME

INVERTE:
        LDA precisaDesinverter
        NOT
        STA precisaDesinverter
        POP
        STA retAlto
        POP
        STA retBaixo
        POP
        NOT
        ADD #1
        STA var1Baixa
        LDA var1Alta
        NOT
        ADC #0
        STA var1Alta
        LDA var2Baixa
        NOT
        ADD #1
        STA var2Baixa
        LDA var2Alta
        NOT
        ADC #0
        STA var2Alta
        JMP CONTINUASOMA
DESINVERTE:
           LDA precisaDesinverter
           NOT
           STA precisaDesinverter
           LDA resultBaixa
           NOT
           ADD #1
           STA resultBaixa
           LDA resultAlta
           NOT
           ADC #0
           STA resultAlta
IMPRIME:
        LDA resultAlta
        OUT VISOR
        LDA resultBaixa
        OUT VISOR


END






















