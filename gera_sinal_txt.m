%-------------------------------------------------------------------------%
% clear all;
% The signal to be generate will based in a text that will be converter to
% standard ASCII and after will be save in a file.
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
TAM         = 1024;                 % Number of bits to be used
%--------------------------Generate Signal--------------------------------%
%Read txt file and save the information 
FID = fopen('entrada.txt', 'rb', machinefmt, encoding);
ent = fread(FID, 500, 'char');
ST = fclose(FID);
% Converter to binary format 
k = dec2bin(ent,8);
[m,n] = size(k);
d=1;
for i = 1:m;
    for j = 1:n;
        x(d) = str2double(k(i,j));
        d = d+1;
    end
end
% Increase number of points per period from bit rate and sample frequency.
j = 1;
for i = 1:length(x);
    x1(j:j+(ppp-1)) = x(i);
    j = j + ppp;
end

% Write binary signal in a file.
FID = fopen('signal_dig.txt','w', machinefmt, encoding);
fprintf(FID, '%d\n ', x1);
ST1 = fclose(FID);


