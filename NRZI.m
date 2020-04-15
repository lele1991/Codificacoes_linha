function [y] = UNRZI(x, A, st)   %unipolar nrzi
    N = length(x)/st;
    y = zeros(1, N);            %vet saida
    j = 1;
    for i = 1 : (N)
        if x(j) == 0
           y(i) = A; 
        end

        if mod(i, 1/st) == 0
            j = j + 1;
        end
    end
end