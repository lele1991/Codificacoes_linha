% Trabalho 02 - Codificacao de Linha
% Aluna Letícia de Oliveira Nunes
% 27 de fevereiro 2020

n = 10;                              % quantidade de bits
bits = randi([0,1],1,n); 
%bits = [1 0 1 1 0 0 0 1 1 0 1 0];
A = 5;                               % [V]
Ts = 0.001;                          % [s]
st = 1/10e3;                         % [s], periodo de amostragem
N = length(bits)/st;                 % [amostras]
t = linspace(0, length(bits)*Ts, N);

print1 = true;

disp('quantidade de bits:');
disp(n);
disp('vetor de bits:');
disp(bits);

% UNIPOLAR NRZ
x = UNRZ(bits, A, st);
if(print1 == true)
    cfigure(t, x, 'UNIPOLAR NRZ');
    fprintf('UNIPOLAR NRZ\tTaxa de bits: %d\n', 1/Ts);
end

% UNIPOLAR RZ 
x = URZ(bits, A, st);
if(print1 == true)
    cfigure(t, x, 'UNIPOLAR RZ');
    fprintf('UNIPOLAR RZ\tTaxa de bits: %d\n', 1/Ts);
end

% BIPOLAR NRZ
x = BNRZ(bits, A, st);
if(print1 == true)
    cfigure(t, x, 'BIPOLAR NRZ');
    fprintf('BIPOLAR NRZ\tTaxa de bits: %d\n', 1/Ts);
end

% BIPOLAR RZ
x = BRZ(bits, A, st);
if(print1 == true)
    cfigure(t, x, 'BIPOLAR RZ');
    fprintf('BIPOLAR RZ\tTaxa de bits: %d\n', 1/Ts);
end

% POLAR QUATERNÁRIO
x = PQNRZ(bits, A, st);
if(print1 == true)
    cfigure(t, x, 'POLAR QUATERNÁRIO NRZ');
    fprintf('POLAR QUATERNÁRIO NRZ\tTaxa de bits: %d\n', 2/Ts);
end

% Non-return-to-zero space
x = NRZS(bits, A, st);
if(print1 == true)
    cfigure(t, x, 'Non-return-to-zero space');
    fprintf('Non-return-to-zero space\tTaxa de bits: %d\n', 1/Ts);
end

% MANCHESTER, conforme GE Thomas
x = MANCHESTER(bits, A, st);
if(print1 == true)
    cfigure(t, x, 'MANCHESTER, conforme GE Thomas');
    fprintf('MANCHESTER\tTaxa de bits: %d\n', 1/Ts);
end

%--------------------------------------------------------------------------------
clc; clear;
n = 20;                 % quantidade de bits
bits = randi([0,1],1,n); 
A = 1;                  % [V]
Ts = 0.001;             % [s]
T = 1/10e3;             % [s], periodo de amostragem
N = length(bits)/T;     % [amostras]
t = linspace(0, length(bits)*Ts, N);

alpha = (randi(101, 1) - 1)/100;    % Atenuacao
epsilon = (A^2) * Ts;
snr = 1;

% BIPOLAR NRZ
x = BNRZ(bits, A, T);
y = awgn(x, 15);
%y = awgn(x,snr,10*log(epsilon));
y = y*alpha;
cfigure(t, y, 'BIPOLAR NRZ');
figure;
plot_fft(Ts, y, 0, 2, 'b');

% Filtro
fc = 50;
wc = 2 * fc * T;
n = 4;
Rs = 80;
[b,a] = cheby2(n,Rs,wc);
z = filter(b, a, y);
cfigure(t, z, 'Sinal Filtrado - BIPOLAR NRZ');
saida = zeros(1, N);

% Limiar
for i=1:N
   if (z(i) > 0)
      saida(i) = A/2;
   end
   if (z(i) <= 0)
       saida(i) = -A/2;
   end
end
cfigure(t, saida, 'Saida - BIPOLAR NRZ');

% Vetor saida
i = 1;
vetor_saida = zeros(1, length(bits));
disp(length(bits));
for j = (1/T)/2 : 1/T : N
    
    disp(saida(j));
    disp(i);
    if saida(j) > 0
       vetor_saida(i) = 1;
    end
    
    if saida(j) <= 0
       vetor_saida(i) = 0; 
    end
   
    i = i + 1;
end

% NRZ-space
x = NRZS(bits, A, T);
y = awgn(x, 15);
y = y*alpha;
cfigure(t, y, 'NRZ-SPACE');
figure;
plot_fft(Ts, y, 0, 2, 'b');

% Filtro
fc = 50;
wc = 2 * fc * T;
n = 4;
Rs = 80;
[b,a] = cheby2(n,Rs,wc);
z = filter(b, a, y);
cfigure(t, z, 'Sinal Filtrado - NRZ-SPACE');
saida = zeros(1, N);

% Limiar
for i=1:N
   if (z(i) > 0.5)
      saida(i) = A;
   end
   if (z(i) <= 0.5)
       saida(i) = 0;
   end
end
cfigure(t, saida, 'Saida - NRZ-SPACE');

% Vetor saida
i = 1;
vetor_saida = zeros(1, length(bits));
disp(length(bits));
for j = (1/T)/2 : 1/T : N
    disp(saida(j));
    disp(i);
    if saida(j) > 0.5
       vetor_saida(i) = 1;
    end
    
    if saida(j) <= 0.5
       vetor_saida(i) = 0; 
    end
   
    i = i + 1;
end

vet = zeros(1, length(bits));

if(vetor_saida(1) == 0)
   vet(1) = 1;
else
    vet(1) = 0; 
end

for i = 2:length(bits)
   if(xor(vetor_saida(i),vetor_saida(i-1)) == 1)
      vet(i) = 0;
   else
       vet(i) = 1;
   end
end

% NRZ-SPACE
x = NRZS(bits, A, T);
y = awgn(x, 15);
y = y*alpha;
cfigure(t, y, 'NRZ-SPACE');
figure;
plot_fft(Ts, y, 0, 2, 'b');

% Filtro
fc = 50;
wc = 2 * fc * T;
n = 4;
Rs = 80;
[b,a] = cheby2(n,Rs,wc);
z = filter(b, a, y);
cfigure(t, z, 'Sinal Filtrado - NRZ-SPACE');
saida = zeros(1, N);

% Limiar
for i=1:N
   if (z(i) > 0.5)
      saida(i) = A;
   end
   if (z(i) <= 0.5)
       saida(i) = 0;
   end
end
cfigure(t, saida, 'Saida - NRZ-SPACE');

% Vetor saida
i = 1;
vetor_saida = zeros(1, length(bits));
disp(length(bits));
for j = (1/T)/2 : 1/T : N
    
    disp(saida(j));
    disp(i);
    if saida(j) > 0.5
       vetor_saida(i) = 1;
    end
    
    if saida(j) <= 0.5
       vetor_saida(i) = 0; 
    end
   
    i = i + 1;
end

vet = zeros(1, length(bits));

if(vetor_saida(1) == 0)
   vet(1) = 1;
else
    vet(1) = 0; 
end

for i = 2:length(bits)
   if(xor(vetor_saida(i),vetor_saida(i-1)) == 1)
      vet(i) = 0;
   else
       vet(i) = 1;
   end
end
