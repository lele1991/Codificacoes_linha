function [y] = URZ(x, A, st)        % UNIPOLAR RZ
    N = length(x)/st;
    y = zeros(1, N);    
    k = true;
    j = 1;
    for i = 1 : (N)

        if (k == true) && (x(j) == 1)
            y(i) = A; 
        else
            y(i) = 0;
        end

        if mod(i, 1/st) == 0
            j = j + 1;
        end

        if (mod(i, (1/st)/2)) == 0
            k = xor(k,1); %(k xor 1);    
        end

    end
end
