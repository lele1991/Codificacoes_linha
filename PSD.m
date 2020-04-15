function [Spsd] = PSD(sinal, fs, cor)
    Spsd = pwelch(sinal, fs);
    figure(1)
    hold on;
    handle1 = plot(Spsd);
    set(handle1,'LineWidth',1.5,'Color', cor);
    xlim([8 100]);
    title(sprintf('%s', 'PSD'));
    hold off;  
end
