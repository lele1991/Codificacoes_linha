%-------------------------------------------------------------------------%
%-----------------------Systems�s Parameters------------------------------%
machinefmt  = 'native';             % Order for read/write bytes or bits
encoding    = 'UTF-8';              % Character encoding
fs          = 10e3;                 % Sample Frequency
fc          = 50e3;                 % Carrier Frequency
br          = 5e3;                  % Bit Rate
M           = 2;                    % Number of Bits
ts          = 1/fs;                 % Sample Time
k           = log2(M);              % Bits for Symbols
m           = 0:M-1;                % Symbols�s Vector
baud        = br/k;                 % Baud rate
T           = 1/br;                 % Symbol�s Period
ppp         = round(fs/br);         % Points per period

p = bits_rx(1:ppp:end);
k=1;
%Remove points per period that have more to make conversion to a string
for i=1:8:length(p);
    aux = num2str(p(i:i+7));
    l(k) = bin2dec(aux);
    k=k+1;
end
 
%Write string to a txt file in standard ASCII
FID = fopen('saida.txt','w', machinefmt, encoding);
A = fprintf(FID, '%c', l);
ST = fclose(FID);
    