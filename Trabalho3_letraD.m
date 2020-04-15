%% 
%d) Para testar a influência do erro de bit em uma mensagem, gere a 
%sequência binária relativa a mensagem ASCII “Vamos ver quantos caracteres 
%estarão errados neste texto”. Aplique cada código de linha nesta mensagem 
%e varie a relação sinal ruído do canal. Analise os erros na mensagem.

clc; clear;
A = 1;
st = 1/10e3;
noise = 100;
gera_sinal_txt;
%%
signal_UNINRZ = UNRZ(x1, A, st);                    %UNI NRZ
RX_TX(signal_UNINRZ, noise);


%%
signal_UNIRZ = URZ(x1, A, st);			%UNI RZ
RX_TX(signal_UNIRZ, noise);

%%
signal_BINRZ = BNRZ(x1, A, st);			%BI NRZ
RX_TX(signal_BINRZ, noise);

%%
signal_BIRZ = BRZ(x1, A, st);				%BI RZ
RX_TX(signal_BIRZ, noise);

%%
signal_PQNRZ = PQNRZ(x1, A, st);			%Polar quat
RX_TX(signal_PQNRZ, noise);

%%
signal_NRZS = NRZS(x1, A, st);			%Non-return-to-zero space
RX_TX(signal_NRZS, noise);

%%
signal_MANCH = MANCHESTER(x1, A, st);     %Manchester
RX_TX(signal_MANCH, noise);
