function [sinalruido] = ruido(sinal, stitle, i, n)
    sinalruido = awgn(sinal, n);
%     figure(i)
%     hold on;
%     ploty = plot(sinalruido);
%     set(ploty,'LineWidth',1.0,'Color','g');
%     plotuni = plot(sinal);
%     set(plotuni,'LineWidth',1.0,'Color','r');
%     title(sprintf('%s', stitle));
%     hold off;
end
