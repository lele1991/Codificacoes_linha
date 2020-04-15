function [y] = MANCHESTER(x, A, st)
    j = 1; 
    k = true;
    N = length(x)/st;
    y = zeros(1, N);
    for i = 1 : (N)

        if (k == true) 
            if (x(j) == 1)
                y(i) = A; 
            end
            if (x(j) == 0)
                y(i) = -A; 
            end
        end

        if (k == false) 
            if (x(j) == 1)
                y(i) = -A; 
            end
            if (x(j) == 0)
                y(i) = A; 
            end
        end

        if mod(i, 1/st) == 0
            j = j + 1;
        end

        if (mod(i, (1/st)/2)) == 0
            k = xor(k,1); %(k xor 1);    
        end
    end
end
