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
nomeArquivoDeEntrada db 60 dup(0); input para o nome do arquivo que sera aberto
nomeArquivoDeSaida db 60 dup(0); input para o nome do arquivo criado a partir do aberto anteriormente
mensagem1 db "Digite o nome do arquivo de entrada: ", 0H
mensagem2 db "Digite a coordenada X inicial da censura: ", 0H
mensagem3 db "Digite a coordenada Y inicial da censura: ", 0H
mensagem4 db "Digite a largura da censura: ", 0H
mensagem5 db "Digite a altura da censura:", 0H
mensagem6 db "Digite o nome do arquivo de saida:", 0H



.code
start:


    invoke ExitProcess, NULL
end start
```