%b) Calcule as probabilidades de erro teóricas (Pb) de cada 
%codificação implementada (unipolares, bipolares e m-árias). 
%Faça a relação sinal-ruído Eb/No variar entre 0 e 30 dB, 
%com passos de 0.1 dB. Gere um gráfico semilog para observar Pb.

clc; clear;
ebn0_db = 0:0.1:30;
ebn0 = 10.^(ebn0_db./10);

pbUNI = qfunc(sqrt(ebn0));
pbBI =  qfunc(sqrt(2*ebn0));
figure(1);
semilogy(ebn0_db, pbUNI)
title('UNI');
xlabel('Eb/N0 (dB)')
ylabel('Pb')
grid on;
figure(2);
semilogy(ebn0_db, pbBI)
title('BI');
xlabel('Eb/N0 (dB)')
ylabel('Pb')
grid on;
hold off;

M = 6;
pb_mnaria4 = 2*((M-1)/M)*qfunc(sqrt((6/((M*M)-1))*ebn0));
figure;
semilogy(ebn0_db, pb_mnaria4);
hold on
title('M-Nária');
xlabel('Eb/N0 (dB)')
ylabel('Pb')
grid on
M = 4;
pb_mnaria8 = 2*((M-1)/M)*qfunc(sqrt((6/((M*M)-1))*ebn0));
semilogy(ebn0_db, pb_mnaria8);
M = 2;
pb_mnaria2 = 2*((M-1)/M)*qfunc(sqrt((6/((M*M)-1))*ebn0));
semilogy(ebn0_db, pb_mnaria2);
legend('M = 6', 'M = 4', 'M = 2')
hold off
