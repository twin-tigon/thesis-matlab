function output = exp_fastl2007(varargin)
%EXP_JELFS2011  Figures from Fastl and Zwicker (2007)
%   Usage: output = exp_fastl2007(flag);
%
%   EXP_FASTL2007 reproduces Fluctuation strength data from the book Fastl 
%       and Zwicker (2007).
%
%   Examples:
%   ---------
%     exp_fastl2007;
%
% Programmed by Alejandro Osses V., HTI, TU/e, the Netherlands, 2014-2015
% Created on    : 02/08/2015
% Last update on: 02/08/2015 % Update this date manually
% Last use on   : 02/08/2015 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fmod = [0.25 0.5 1 2 4 8 16 32]; % Hz
FS_BBN_std1 = [22.5  57   79   101  100    82   29     6; ...
                3.5  29.5 59.5  90   97    68.5 20     1; ... 
               30    70   98   110  102.25 84.5 44    14];
FS_BBN_std2 = [12.5  27   45.5  75   99.75 92   24.25  9.75; ...
                5.5  24.5 39    51.5 60.5  67   13     4; ...
               16    30   48    92  110   110   32    19.5]; 

FS_AM_std1 = [3   10.25 26.25 66   100  99 30    9.5; ...
              0    7.75 20    50    98  75  7    0; ...
              5.5 20    50    90.5 102 110 49.5 12.25];
FS_AM_std2 = [5.5 15 33 53.5 91.5 99 25 0.25; ...
              1 12 26 39.5 65.5 73 14 -3; ...
              8.25 16.25 36 65.5 109.5 110 58 12];
FS_FM_std1 = [10.2 22.75 35 57.25 100 50   19.5   0.75; ...
               5.5  5    21 50     98 30.5 11    -1.5; ...
               2   42    79 95    101 73   39.75  9.75];
FS_FM_std2 = [10.25 20.5  50.25 60.5 100    20.5   7.5  2; ...
               8    19.25 40.5  55.5  75.75 10.25  4    0; ...
              13.5  23    60.25 89.5 110    90    35   10];

output.fmod = fmod; % Hz
output.FS_BBN_std1 = FS_BBN_std1;
output.FS_BBN_std2 = FS_BBN_std2;
output.FS_AM_std1 = FS_AM_std1;
output.FS_AM_std2 = FS_AM_std2;
output.FS_FM_std1 = FS_FM_std1;
output.FS_FM_std2 = FS_FM_std2;
output.FS100 = [1.8 1.3 2]; % vacil, 100% of fluctuation

if nargout == 0
    
    dx = 0.15;
    text_XLabel = 'f_m_o_d [Hz]';
    text_YLabel = 'Relative FS [%]';
    Ntest = length(fmod);
        
    figure; 
    subplot(1,3,1) % AM-BBN
    iq1L = FS_BBN_std1(1,:) - FS_BBN_std1(2,:);
    iq1U = FS_BBN_std1(3,:) - FS_BBN_std1(1,:);
    iq2L = FS_BBN_std2(1,:) - FS_BBN_std2(2,:);
    iq2U = FS_BBN_std2(3,:) - FS_BBN_std2(1,:);
    errorbar([1:Ntest]-dx,FS_BBN_std1(1,:),iq1L,iq1U,'bx','LineWidth',2); hold on
    errorbar([1:Ntest]+dx,FS_BBN_std2(1,:),iq2L,iq2U,'ro');
    plot([1:Ntest],mean([FS_BBN_std1(1,:); FS_BBN_std2(1,:)]),'k>--','LineWidth',2)
    xlabel(text_XLabel)
    ylabel(text_YLabel)
    grid on;
    xlim([0.5 Ntest+0.5])
    ha = gca;
    set(ha,'XTick',[1:Ntest])
    set(ha,'XTickLabel',fmod)
    title('AM BBN')
 
    subplot(1,3,2) % AM-SIN
    iq1L = FS_AM_std1(1,:) - FS_AM_std1(2,:);
    iq1U = FS_AM_std1(3,:) - FS_AM_std1(1,:);
    iq2L = FS_AM_std2(1,:) - FS_AM_std2(2,:);
    iq2U = FS_AM_std2(3,:) - FS_AM_std2(1,:);
    errorbar([1:Ntest]-dx,FS_AM_std1(1,:),iq1L,iq1U,'bx','LineWidth',2); hold on
    errorbar([1:Ntest]+dx,FS_AM_std2(1,:),iq2L,iq2U,'ro');
    plot([1:Ntest],mean([FS_AM_std1(1,:); FS_AM_std2(1,:)]),'k>--','LineWidth',2)
    xlabel(text_XLabel)
    ylabel(text_YLabel)
    grid on;
    xlim([0.5 Ntest+0.5])
    ha(end+1) = gca;
    set(ha(end),'XTick',[1:Ntest])
    set(ha(end),'XTickLabel',fmod)
    title('AM SIN')
    
    subplot(1,3,3) % AM-SIN
    iq1L = FS_FM_std1(1,:) - FS_FM_std1(2,:);
    iq1U = FS_FM_std1(3,:) - FS_FM_std1(1,:);
    iq2L = FS_FM_std2(1,:) - FS_FM_std2(2,:);
    iq2U = FS_FM_std2(3,:) - FS_FM_std2(1,:);
    errorbar([1:Ntest]-dx,FS_FM_std1(1,:),iq1L,iq1U,'bx','LineWidth',2); hold on
    errorbar([1:Ntest]+dx,FS_FM_std2(1,:),iq2L,iq2U,'ro');
    plot([1:Ntest],mean([FS_FM_std1(1,:); FS_FM_std2(1,:)]),'k>--','LineWidth',2)
    xlabel(text_XLabel)
    ylabel(text_YLabel)
    grid on;
    xlim([0.5 Ntest+0.5])
    ha(end+1) = gca;
    set(ha(end),'XTick',[1:Ntest])
    set(ha(end),'XTickLabel',fmod)
    title('FM SIN')
    
    legend('4-Hz std','0.5-Hz std','avg')
    linkaxes(ha,'xy');
    ylim([-5 110])

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
