function [y] = PQNRZ(x, A, st)      % polar quaternario NRZ
    N = length(x)/st;
    y = zeros(1, N);                % vet saida

    % novo vetor para guardar valores dos pares de bits
    xq = zeros(1, floor(length(x)/2));
    j = 1;
    for i = 1 : (length(x)-1)
        if mod(i, 2) == 0
            if (x(i-1) == 0) && (x(i) == 0)
                xq(j) = 0;
            end

            if (x(i-1) == 0) && (x(i) == 1)
                xq(j) = 1;
            end

            if (x(i-1) == 1) && (x(i) == 0)
                xq(j) = 2;
            end

            if (x(i-1) == 1) && (x(i) == 1)
                xq(j) = 3;
            end
            j = j + 1;
        end
    end

    %polar quaternario natural
    j = 1;
    for i = 1 : (N)

        if xq(j) == 0
           y(i) = -3*A/2; 
        end
        if xq(j) == 1
           y(i) = -A/2; 
        end
        if xq(j) == 2
           y(i) = A/2; 
        end
        if xq(j) == 3
           y(i) = 3*A/2; 
        end    

        if mod(i, 2/st) == 0
            j = j + 1;
        end

    end
end
