.686
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\include\kernel32.lib
includelib \masm32\include\user32.lib
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
fileHandle dd 0; handle de entrada
fileHandle2 dd 0; handle de saida
readCount dd 0; contador do ReadFile
writeCount dd 0; contador do WriteFile
header1 db 18 dup(0); cabecalho com 18 bytes 
headerLargura db 4 dup(0); cabeçalho da largura
header3 db 32 dup(0);
fileBuffer db 3 dup(0); apontador para um array de bytes, onde serao guardados os bytes lidos pelo arquivo
initialXCoord dd 0;
initialYCoord dd 0;
censorWidth dd 0;
censorHeight dd 0;

.code
start:

invoke GetStdHandle, STD_INPUT_HANDLE
mov inputHandle, eax; obtem inputHandle
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov outputHandle, eax; obtem outputHandle

invoke WriteConsole, outputHandle, addr message1, sizeof message1, addr console_count, NULL; escreve a variavel mensagem no console

invoke ReadConsole, inputHandle, addr inputFileName, sizeof inputFileName, addr console_count, NULL; input da variavel fileName (o que foi pedido em mensagem)

invoke WriteConsole, outputHandle, addr message2, sizeof message2, addr console_count, NULL; escreve a variavel mensagem3 no console

invoke ReadConsole, inputHandle, addr initialXCoord, sizeof initialXCoord, addr console_count, NULL; input da string cor (o que foi pedido em mensagem3)

invoke WriteConsole, outputHandle, addr message3, sizeof message3, addr console_count, NULL; escreve a variavel mensagem4 no console

invoke ReadConsole, inputHandle, addr initialYCoord, sizeof initialYCoord, addr console_count, NULL; input da string intensidade (o que foi pedido em mensagem4)

invoke WriteConsole, outputHandle, addr message4, sizeof message4, addr console_count, NULL; escreve a variavel mensagem4 no console

invoke ReadConsole, inputHandle, addr censorWidth, sizeof censorWidth, addr console_count, NULL; input da string intensidade (o que foi pedido em mensagem4)

invoke WriteConsole, outputHandle, addr message5, sizeof message5, addr console_count, NULL; escreve a variavel message5 no console

invoke ReadConsole, inputHandle, addr censorHeight, sizeof censorHeight, addr console_count, NULL; input da variavel censorHeight (

invoke WriteConsole, outputHandle, addr message6, sizeof message6, addr console_count, NULL; escreve a variavel message6 no console

invoke ReadConsole, inputHandle, addr outputFileName, sizeof outputFileName, addr console_count, NULL; input da variavel fileName2 (o que foi pedido em mensagem2) 
  
mov esi, offset inputFileName ; Armazenar apontador da string em esi