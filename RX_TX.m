function RX_TX (x2, noise)
%% Transmissor
Rb = 100e3;
Tb = 1/Rb;
Nb = 15e3;          %número de bits transmitidos
Eb = 1e-3;          %Energia média de bit requerida
alfa = .5;          %fator de decaimento (rolloff)
span = 6;           %limita a duracao do pulso formatado ao longo de "span" simbolos
sps = 20;           %amostras por simbolo
fs = 10*Rb;         %frequencia de amostragem
Ts = 1/fs;
A = sqrt(Eb/(Tb));                          %Amplitude do codigo para alcancar o Eb exigido
%bits = randi([0 1],Nb,1);
% bits = rand(Nb,1);
% bits = (bits > 0.8);
%bits = ones
%simb = bits;                               %impulsos do código unipolar
simb = 2*x2 - 1;                            %impulsos do código polar
b = rcosdesign(alfa, span, sps);            %coeficientes do filtro raised cosine
s = upfirdn(simb, A*sqrt(Tb)*b, sps);       %interpola e filtra o sinal interpolado
t = 0:Ts:(length(s)-1)*Ts;

%% Canal
EbNodB = noise;                             %Eb/No (dB)
EbNo = 10^(EbNodB/10);                      %Eb/No
No = Eb/EbNo;
sigma = sqrt(No/2);
%r = s + sigma*randn(size(s));              %Adiciona ruído branco
r = awgn(s, EbNodB);

%% Gráficos
% figure(1);
% plot(t,r,'red');
% hold on;
% plot(t,s);
% xlabel('t (s.)');
% legend('com ruído','sem ruído');
% 
% S = fft(s);
% vetf = linspace(-0.5*fs,0.5*fs,length(t));
% figure(2);
% plot(vetf,fftshift(abs(S)));
% xlabel('f (Hz)');
% ylabel('|S(f)|');
% 
% eyediagram(r(sps*4:end-4*sps), sps*2);              %diagrama do olho antes do filtro casado
% saida_casado = filter(b,1,r);
% eyediagram(saida_casado(sps*4:end-4*sps), sps*2);   %diagrama do olho depois do filtro casado

%% Receptor
z = upfirdn(r, A*sqrt(Tb)*b, 1, sps);      %filtra e dezima (aplica o filtro casado no sinal recebido e coleta a amostra para realizar a detecÃƒÂ§ÃƒÂ£o binÃƒÂ¡ria)
z = z(span+1:end-span);                    %descarta as amostras provenientes do atraso provocado pelo filtro
bits_rx = z>=0;
ler_sinal_dig
BER_sim = mean(abs(x2 - bits_rx));       %Calculo da BER: eh necessario simular uma grande sequencia de bits para confirmar o valor teorico
BER_teorica = qfunc(sqrt(2*EbNo));

end