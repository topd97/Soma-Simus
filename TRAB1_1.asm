;---------------------------------------------------
; Programa: TRAB1_1
; Autor: Thiago Outeiro
; Data: 14/04/2019
;---------------------------------------------------

ORG 200h

;Declarando variaveis
                       
teste1Baixa:      DB   21h
teste1Alta:       DB   70h
teste2Baixa:      DB   0F3h
teste2Alta:       DB   1Fh
endTeste1:        DW   teste1Baixa
endTeste2:        DW   teste2Baixa
endTemp:          DS   2
endRet:           DS   2
endRetGeral:      DS   2
tempBaixa:        DB   0
tempAlta:         DB   0
podeUnder:        DB   0
deuOVer:          DB   0
precisaDesinverter: DB 0h
somar:              DB 0h
retAlto:           DS       1
retBaixo:          DS       1
var1Alta:         DS       1
var1Baixa:        DS       1
var2Alta:         DS       1
var2Baixa:        DS       1
resultBaixa:      DS       1
resultAlta:       DS       1
VISOR:            EQU      0
a:                DB       0
b:                DB       0
c:                DB       0
d:                DB       0
e:                DB       0
f:                DB       0


ORG 0
INICIOEXEMPLO: ;Inicialização de variaveis para a pilha
        LDA endTeste1+1
        PUSH
        LDA endTeste1
        PUSH
        LDA endTeste2+1
        PUSH
        LDA endTeste2
        PUSH
        LDA #0
        JSR ROTINA
        HLT


ROTINA:;Inicio verdadeiro da rotina do exercicio
       ADD #0
       STA  somar

       POP
       STA endRetGeral
       POP
       STA endRetGeral+1


       POP
       STA endTemp
       POP
       STA endTemp+1
       LDA @endTemp
       STA var2Baixa

       LDA endTemp
       ADD #1
       STA endTemp
       LDA @endTemp
       STA var2Alta

       POP
       STA endTemp
       POP
       STA endTemp+1
       LDA @endTemp
       STA var1Baixa

       LDA endTemp
       ADD #1
       STA endTemp
       LDA @endTemp
       STA var1Alta

       LDA somar
       JZ CONTINUA
       LDA var2Alta
       PUSH
       LDA var2Baixa
       PUSH
       JSR INVERTE
       POP
       STA var2Baixa
       POP
       STA var2Alta

CONTINUA:
       LDA var1Alta
       AND var2Alta
       AND #80h       ;#10000000b
       JZ CONTINUASOMA

       LDA podeUnder  ;como ambos sao negativos pode dar Underflow
       ADD #1
       STA podeUnder
       LDA precisaDesinverter
       ADD #1
       STA precisaDesinverter

       LDA var2Alta
       PUSH
       LDA var2Baixa
       PUSH
       JSR INVERTE
       POP
       STA var2Baixa
       POP
       STA var2Alta

       LDA var1Alta
       PUSH
       LDA var1Baixa
       PUSH
       JSR INVERTE
       POP
       STA var1Baixa
       POP
       STA var1Alta
CONTINUASOMA:
             LDA var1Baixa
             ADD var2Baixa
             STA resultBaixa
             LDA var1Alta
             ADC var2Alta
             STA resultAlta

             PUSH
             JSR VERIFICAOVER

             LDA precisaDesinverter
             JZ  IMPRIME

             SUB #1
             STA precisaDesinverter

             LDA resultAlta
             PUSH
             LDA resultBaixa
             PUSH
             JSR INVERTE
             POP
             STA resultBaixa
             POP
             STA resultAlta
             JMP IMPRIME

INVERTE:
        POP
        STA endRet
        POP
        STA endRet+1
        POP
        STA tempBaixa
        POP
        STA tempAlta

        LDA tempBaixa
        NOT
        ADD #1
        STA tempBaixa
        LDA tempAlta
        NOT
        ADC #0
        PUSH
        LDA tempBaixa
        PUSH

        LDA endRet+1
        PUSH
        LDA endRet
        PUSH
        RET

IMPRIME:

        LDA resultAlta
        OUT VISOR
        LDA resultBaixa
        OUT VISOR

        ;colocar o retorno na pilha

        LDA endRetGeral+1
        PUSH
        LDA endRetGeral
        PUSH
        LDA deuOver
        RET

VERIFICAOVER:
             POP
             STA endRet
             POP
             STA endRet+1

             POP
             AND #80h
             JNZ OVERACONTECEU
             STA deuOver
             JMP ENCERRAOVER
OVERACONTECEU:
             LDA #1
             STA deuOver
ENCERRAOVER:
             LDA endRet+1
             PUSH
             LDA endRet
             PUSH
             RET























