function [signal_UNINRZ, signal_UNIRZ, signal_BINRZ, signal_BIRZ, signal_PQNRZ, signal_NRZS, signal_MANCH, n, fs] = gerasinal(bits_enviado)
%     %bits = [1 0 1 1 0 0 0 1 1 0 1 0];          % quantidade de bits
%     bits = rand(1, n)>0.5;
%     %bits = randi([0,1], 1, n);
%     Ts = 0.001;                                 % [s]                              
%     N = length(bits)/st;                        % [amostras]
%     bits = randi([0,1], 1, n);
%     t = linspace(0, length(bits)*Ts, N);
%     fs = 32e3;
    n = 20;
    Rs = 1e3;
    Rb = 5000;
    fs = 10*Rb;
    A = 1;
    st = 1/10e3;
    N = length(bits_enviado)/st;
    t = linspace(0, length(bits_enviado)*st, N);

    signal_UNINRZ = UNRZ(bits_enviado, A, st);			%UNI NRZ
    %cfigure(t, signal_UNINRZ, 'UNIPOLAR NRZ');
    signal_UNIRZ = URZ(bits_enviado, A, st);			%UNI RZ
    %cfigure(t, signal_UNIRZ, 'UNIPOLAR NRZ');
    signal_BINRZ = BNRZ(bits_enviado, A, st);			%BI NRZ
    %cfigure(t, signal_BINRZ, 'UNIPOLAR NRZ');
    signal_BIRZ = BRZ(bits_enviado, A, st);				%BI RZ
    %cfigure(t, signal_BIRZ, 'UNIPOLAR NRZ');
    signal_PQNRZ = PQNRZ(bits_enviado, A, st);			%Polar quat
    %cfigure(t, signal_PQNRZ, 'UNIPOLAR NRZ');
    signal_NRZS = NRZS(bits_enviado, A, st);			%Non-return-to-zero space
    %cfigure(t, signal_NRZS, 'UNIPOLAR NRZ');
    signal_MANCH = MANCHESTER(bits_enviado, A, st);     %Manchester
    %cfigure(t, signal_MANCH, 'UNIPOLAR NRZ');
end