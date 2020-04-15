function [y] = BRZ(x, A, st)    % BIPOLAR RZ
    N = length(x)/st;
    y = zeros(1, N);            %vet saida
    j = 1; 
    k = true;
    for i = 1 : (N)
        if (k == true) && (x(j) == 1)
            y(i) = A; 
        else
            if (k == true) && (x(j) == 0)
            y(i) = -A;
            else
            y(i) = 0;
            end
        end

        if mod(i, 1/st) == 0
            j = j + 1;
        end

        if (mod(i, (1/st)/2)) == 0
            k = xor(k,1);  
        end
    end
end
