function cfigure(t, y, stitle)
    A = max(y);
    B = min(y);
    %f = figure('Color', [1 1 1]);
    figure;
    plot(t,y,'b','LineWidth', 1);
    ylim([B-(1.2) A*1.2]);
    xlabel('Tempo [s]');
    ylabel('Amplitude [V]');
    title(sprintf('%s', stitle));
    grid on;
end

