.686
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\msvcrt.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\msvcrt.lib


.data
inputFileName db 60 dup(0); input para o nome do arquivo que sera aberto
outputFileName db 60 dup(0); input para o nome do arquivo criado a partir do aberto anteriormente
message1 db "Digite o nome do arquivo de entrada: ", 0H
message2 db "Digite a coordenada X inicial da censura: ", 0H
message3 db "Digite a coordenada Y inicial da censura: ", 0H
message4 db "Digite a largura da censura: ", 0H
message5 db "Digite a altura da censura:", 0H
message6 db "Digite o nome do arquivo de saida:", 0H
inputHandle dd 0; inputHandle para o ReadConsole
outputHandle dd 0; outputHandle para o WriteConsole
console_count dd 0; contador do WriteConsole e ReadConsole
inputFileHandle dd 0; handle de entrada
outputFileHandle dd 0; handle de saida
readCount dd 0; contador do ReadFile
writeCount dd 0; contador do WriteFile
header db 50 dup(0); cabecalho com 54 bytes iniciados em 0
readWidth dd 0; vari?vel que vai guardar o valor da largura lido no cabe?alho
initialXCoordstr db 7 dup(0); vari?vel string para a coordenada inicial x recebida pelo usu?rio
initialYCoordstr db 7 dup(0); vari?vel string para a coordenada inicial y recebida pelo usu?rio
censorWidthstr db 7 dup(0); vari?vel string para a largura da censura recebida pelo usu?rio
censorHeightstr db 7 dup(0); vari?vel string para a altura recebida pelo usu?rio
initialXCoord dd 0;
initialYCoord dd 0;
censorWidth dd 0;
censorHeight dd 0;
fileBuffer db 3 dup(0); apontador para um array de bytes, onde serao guardados os bytes lidos pelo arquivo


.code
start:

invoke GetStdHandle, STD_INPUT_HANDLE
mov inputHandle, eax; obtem inputHandle
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov outputHandle, eax; obtem outputHandle

invoke WriteConsole, outputHandle, addr message1, sizeof message1, addr console_count, NULL; escreve a variavel mensagem no console

invoke ReadConsole, inputHandle, addr inputFileName, sizeof inputFileName, addr console_count, NULL; input da variavel fileName (o que foi pedido em mensagem)

invoke WriteConsole, outputHandle, addr message2, sizeof message2, addr console_count, NULL; escreve a variavel mensagem3 no console

invoke ReadConsole, inputHandle, addr initialXCoordstr, sizeof initialXCoordstr, addr console_count, NULL; input da string cor (o que foi pedido em mensagem3)

invoke WriteConsole, outputHandle, addr message3, sizeof message3, addr console_count, NULL; escreve a variavel mensagem4 no console

invoke ReadConsole, inputHandle, addr initialYCoordstr, sizeof initialYCoordstr, addr console_count, NULL; input da string intensidade (o que foi pedido em mensagem4)

invoke WriteConsole, outputHandle, addr message4, sizeof message4, addr console_count, NULL; escreve a variavel mensagem4 no console

invoke ReadConsole, inputHandle, addr censorWidthstr, sizeof censorWidthstr, addr console_count, NULL; input da string intensidade (o que foi pedido em mensagem4)

invoke WriteConsole, outputHandle, addr message5, sizeof message5, addr console_count, NULL; escreve a variavel message5 no console

invoke ReadConsole, inputHandle, addr censorHeightstr, sizeof censorHeightstr, addr console_count, NULL; input da variavel censorHeight (

invoke WriteConsole, outputHandle, addr message6, sizeof message6, addr console_count, NULL; escreve a variavel message6 no console

invoke ReadConsole, inputHandle, addr outputFileName, sizeof outputFileName, addr console_count, NULL; input da variavel fileName2 (o que foi pedido em mensagem2) 
  
mov esi, offset inputFileName ; Armazenar apontador da string em esi
proximo:
 mov al, [esi] ; Mover caractere atual para al
 inc esi ; Apontar para o proximo caractere
 cmp al, 13 ; Verificar se eh o caractere ASCII CR - FINALIZAR
 jne proximo
 dec esi ; Apontar para caractere anterior
 xor al, al ; ASCII 0 
 mov [esi], al ; Inserir ASCII 0 no lugar do ASCII CR

mov esi, offset initialXCoordstr ;
proximo2:
 mov al, [esi] ; Mover caractere atual para al
 inc esi ; Apontar para o proximo caractere
 cmp al, 13 ; Verificar se eh o caractere ASCII CR - FINALIZAR
 jne proximo2
 dec esi ; Apontar para caractere anterior
 xor al, al ; ASCII 0 
 mov [esi], al ; Inserir ASCII 0 no lugar do ASCII CR

mov esi, offset initialYCoordstr ;
proximo3:
 mov al, [esi] ; Mover caractere atual para al
 inc esi ; Apontar para o proximo caractere
 cmp al, 13 ; Verificar se eh o caractere ASCII CR - FINALIZAR
 jne proximo3
 dec esi ; Apontar para caractere anterior
 xor al, al ; ASCII 0 
 mov [esi], al ; Inserir ASCII 0 no lugar do ASCII CR

mov esi, offset censorWidthstr ;
proximo4:
 mov al, [esi] ; Mover caractere atual para al
 inc esi ; Apontar para o proximo caractere
 cmp al, 13 ; Verificar se eh o caractere ASCII CR - FINALIZAR
 jne proximo4
 dec esi ; Apontar para caractere anterior
 xor al, al ; ASCII 0 
 mov [esi], al ; Inserir ASCII 0 no lugar do ASCII CR

mov esi, offset censorHeightstr ;
proximo5:
 mov al, [esi] ; Mover caractere atual para al
 inc esi ; Apontar para o proximo caractere
 cmp al, 13 ; Verificar se eh o caractere ASCII CR - FINALIZAR
 jne proximo5
 dec esi ; Apontar para caractere anterior
 xor al, al ; ASCII 0 
 mov [esi], al ; Inserir ASCII 0 no lugar do ASCII CR

mov esi, offset outputFileName ; Armazenar apontador da string em esi
proximo6:
 mov al, [esi] ; Mover caractere atual para al
 inc esi ; Apontar para o proximo caractere
 cmp al, 13 ; Verificar se eh o caractere ASCII CR - FINALIZAR
 jne proximo6
 dec esi ; Apontar para caractere anterior
 xor al, al ; ASCII 0
 mov [esi], al ; Inserir ASCII 0 no lugar do ASCII C
 
invoke atodw, addr initialXCoordstr
mov initialXCoord, eax; transforma a coordenada X inicial digitada pelo usu?rio em um valor num?rico

invoke atodw, addr initialYCoordstr
mov initialYCoord, eax; transforma a coordenada Y inicial digitada pelo usu?rio em um valor num?rico

invoke atodw, addr censorWidthstr
mov censorWidth, eax; transforma a largura da censura digitada pelo usu?rio em um valor num?rico

invoke atodw, addr censorHeightstr
mov censorHeight, eax; transforma a altura da censura digitada pelo usu?rio em um valor num?rico



invoke CreateFile, addr inputFileName, GENERIC_READ, 0, NULL,
OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
mov inputFileHandle, eax; abre um file existente atraves da variavel inputFileName

invoke CreateFile, addr outputFileName, GENERIC_WRITE, 0, NULL,
CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
mov outputFileHandle, eax; cria um file atraves da variavel outputFileName

invoke ReadFile, inputFileHandle, addr header, 18, addr readCount,
NULL ; Le 18 bytes do arquivo de entrada

invoke WriteFile, outputFileHandle, addr header, 18, addr writeCount,
NULL ; Escreve 18 bytes do arquivo de entrada no arquivo de sa?da

invoke ReadFile, inputFileHandle, addr readWidth, 4, addr readCount,
NULL ;Le 4 bytes do arquivo de entrada e armazena na variavel readWidth

invoke WriteFile, outputFileHandle, addr readWidth, 4, addr writeCount,
NULL ; Escreve 4 bytes do arquivo de entrada no arquivo de sa?da

invoke ReadFile, inputFileHandle, addr header, 32, addr readCount,
NULL ; Le 32 bytes do arquivo de entrada

invoke WriteFile, outputFileHandle, addr header, 32, addr writeCount,
NULL ; Escreve 32 bytes do arquivo de entrada no arquivo de sa?da


_loop:
invoke ReadFile, inputFileHandle, addr fileBuffer, 3, addr readCount,
NULL ; Le 3 bytes do arquivo (pixel)

cmp readCount, 0; compara readCount com 0 para saber se a opera??o chegou ao fim
je fim; pula para a label fim

push offset fileBuffer; da um push no offset do fileBuffer
; variaveis da pilha chamadas de tras para frente para estar na ordem correta na funcao

invoke WriteFile, outputFileHandle, addr fileBuffer, 3, addr writeCount,
NULL ; Escreve 3 bytes do arquivo (pixel)
jmp _loop; volta para a label _loop


fim:
invoke CloseHandle, inputFileHandle; fecha o handle de entrada
invoke CloseHandle, outputFileHandle; fecha o handle de sa�da
  invoke ExitProcess, 0
end start 