function [y] = NRZS(x, A, st)       % NRZ-SPACE
    N = length(x)/st;
    j = 1;
    k = false;
    y = zeros(1, N);

    for i = 1 : (N)

        if(k == true)
            y(i) = A; 
        else
            y(i) = 0;
        end

        if (mod(i, 1/st)-1 == 0) && (x(j) == 0)
           k = xor(k,1); 
        end

        if mod(i, 1/st) == 0
            j = j + 1;
        end

    end

end

