function Plot_wavfiles(wavfiles)
% function Plot_wavfiles
% 
% Plots a given list of wavfiles.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    close all;
    
    for idx = 1:length(wavfiles)
        process_wavfile(wavfiles{idx});
    end
    
    function process_wavfile(filename)
        plot_wavfile(filename);
        fprintf('Wavfile "%s" plotted\n',filename);
        fprintf('Press any key to continue\n\n');
        while ~waitforbuttonpress
        end
        close all;
    end
    
    function plot_wavfile(filename)
        [y,Fs]  = audioread(filename);
        t       = (1:length(y))/Fs;
        
        t_offset = 1;
        
        figure
        set(gcf, 'DefaultTextInterpreter', 'none');
        suptitle(filename);
        
        subplot(2,2,1);
        plot(t,y);
        grid minor;
        xlabel('t [s]');
        ylabel('y [V]');
        xlim([0 0+t_offset]);
        
        subplot(2,2,2);
        plot(t,y);
        grid minor;
        xlabel('t [s]');
        ylabel('y [V]');
        xlim([t(end)-t_offset t(end)]);
        
        subplot(2,2,[3,4]);
        plot(t,y);
        grid minor;
        xlabel('t [s]');
        ylabel('y [V]');
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
