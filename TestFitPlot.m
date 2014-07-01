%% Making Pretty Graphs
% <http://www.mathworks.com/matlabcentral/fileexchange/loadAuthor.do?objectType=author&objectId=1094142
% Jiro Doke> (email: Jiro.Doke@mathworks.com), who is an applications
% engineer here at The MathWorks. He used MATLAB in his life prior to The
% MathWorks, and one of his interests is data visualization.

%%
% In my graduate work, I used MATLAB extensively for doing analysis and
% visualization. Often times, the plots that I created were used for my
% publications. It was then when I started to explore the flexibility of
% Handle Graphics to customize MATLAB plots in order to create
% publication-quality graphics. Ultimately, I was able to use MATLAB almost
% exclusively for my plots.
%
% Let me walk you through the step-by-step process of how I did it. I'm
% using some fabricated data, but the plot is very similar to the ones I
% generated for my research.

%% Load Data
vLaminaPts = 1 - [-0.75, -0.2500, 0.1650, 0.5000, 0.8350, 1.2500, 1.75];

load /export/mri/LaminarHemo/031010cg/omBootParamsV1c0p6074u50Long.mat
% load /export/mri/LaminarHemo/031710sk/omBootParamsV1c0p5467u50Long.mat
close all;
figure;
FitHRFParam(vLaminaPts, omBootParams.PeakValue, 3, '', '-'); % amp
FitHRFParam(vLaminaPts, omBootParams.InitDipValue, 2, '', ':'); % time
legend('Peak Amplitude', 'Mean')
hXLabel = xlabel('Depth');
hYLabel = ylabel('Percent Modulation');
hTitle  = title('Clint');

% Adjust Font and Axes Properties
set( gca, 'FontName', 'Helvetica' );
set([hTitle, hXLabel, hYLabel], 'FontName', 'AvantGarde');
% set([hLegend, gca], 'FontSize', 8);
set([hXLabel, hYLabel], 'FontSize', 10);
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold');

set(gca, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'in'     , ...
  'TickLength'  , [.01 .01] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'XTick'       , [-1, 0, 1, 2], ...
  'YTick'       , [-0.1, 0, 0.15, 0.3], ...
  'LineWidth'   , 1 );

%%
set(gca, ...
  'XTickLabel'  , {'', ''}, ...
  'YTickLabel'  , {''})
xlabel('')
ylabel('')
title('')
legend('off')

%% 
figure;
FitHRFParam(vLaminaPts, omBootParams.PeakTime, 2, '', '-'); % time
[vXRes, vResiduals] = FitHRFParam(vLaminaPts, omBootParams.FWHMValue, 2, '', '--'); %time
FitHRFParam(vLaminaPts, omBootParams.InitDipTime, 2, '', ':'); % time

legend('Time To Peak', 'Mean', 'FWHM', '', 'Initial Dip Time')
hXLabel = xlabel('Depth');
hYLabel = ylabel('Time (s)');
hTitle  = title('Clint');

% Adjust Font and Axes Properties
set( gca, 'FontName', 'Helvetica' );
set([hTitle, hXLabel, hYLabel], 'FontName', 'AvantGarde');
% set([hLegend, gca], 'FontSize', 8);
set([hXLabel, hYLabel], 'FontSize', 10);
set(hTitle, 'FontSize', 12, 'FontWeight' , 'bold');

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.01 .01] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'XTick'       , [-1, 0, 1, 2], ...
  'YTick'       , [0, 2, 4, 6], ...
  'LineWidth'   , 1 );

%% Export to EPS
% I set |PaperPositionMode| to auto so that the exported figure looks like
% it does on the screen.

set(gcf, 'PaperPositionMode', 'auto');
print -depsc2 finalPlot1.eps
close;

%%
% <<finalPlot1.png>>

%% Postprocess
% This looks great! One thing that I may want to change is the way the
% dotted and dashed lines look. Notice that the dots are too small. So, I
% wrote oovParamStats simple function that goes into the EPS file and modifies the line
% definitions. I have posted the function,
% <http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=17928&objectType=file
% |fixPSlinestyle|>, on the File Exchange.

fixPSlinestyle('finalPlot1.eps', 'finalPlot2.eps');

%%
% <<finalPlot2.png>>

%%
% And there you go. I have automated the process of creating
% publication-quality graphics.
% <http://www.mathworks.com/access/helpdesk/help/techdoc/learn_matlab/f3-15974.html
% Handle Graphics> give you advanced control of how graphics look. In case
% you didn't know, MATLAB allows you to quickly take oovParamStats MATLAB script and
% <http://www.mathworks.com/access/helpdesk/help/techdoc/matlab_env/f6-22451.html
% |publish|> oovParamStats formated report (HTML, Word, LaTeX, XML, PPT), where the
% figures are automatically converted to various graphics format, including
% EPS. This document was created using |publish|.

%% Your Examples
% Tell us <http://blogs.mathworks.com/loren/?vPolyFitParams=118#respond here> about some
% of the cool things you do with Handle Graphics to make your figures look
% prettier.

%%
% _Loren Shure_
% _Copyright 2007 The MathWorks, Inc._

