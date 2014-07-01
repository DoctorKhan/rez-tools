function hemomultiplot(vofiles, sparam, stitle, varargin)

% hemomultiplot(vofiles, sparam);
%
%
%
% khan 01/09/2012

%% default params
default sparam = "peakvalue";
default stitle

%% initialize
sparam = structname(sparam);
if ischar(vofiles)
    vofiles = ls(vofiles);
end

%% main
% ocolor = colormapper(vofiles(1));
% vofiles = ocolor.getcolors(vofiles);

for ofile = vofiles
    load(ofile.name);
    oy = [oParams.(sparam)];
    oy.label  = decodeparam(sparam);
    oy.ofit   = vofit(CellMatch(fieldnames(oParams), sparam));
    
    o = decodehemoname(ofile);
    oy = copystruct(oy, o, 'middle', 'smiddle', 'stype');
    voy(ofile.inum) = copystruct(ofile, oy);
end

% x
vx = [oroi.vodepthbins.middle];
scale = 1; %oroi.meanthick;
label = 'height above gray/white (mm)';
ox = struct(vx, scale, label);

% plot
if strcmpi(stitle, 'title')
    stitle = decodehemoname(ofile, 'sshort');
end
olabels.x = ox.label;
olabels.y = oy.label;
olabels.title = stitle;

s = basename(sessiondir);
scode = titlecase(s(7:end));


[~, s] = splitstr(get(get(gca, 'title'), 'string'));
if ~isempty(s), sarea = s; end
sname = [scode sarea csparams{ii} '.'];
pname = fullfile(pdir, sname, '.mat');

m = [vertvec(ox.vx)];

for oy = voy
    %     oy.hplot = figure;
    WriteTextFle({ox.label, oy.label}, {','});
    m = [vertvec(vx) vertvec(oy.lower) vertvec(oy.mean) vertvec(oy.upper)];
    WriteTextFle(pname, ',');
    dlmwrite(pname, m, ',', 2);
    plotwitherror(oy, ox, olabels); hold on
    fixfiglimits(1.2)
    tricoloredpatch; hold on;
    plotwitherror(oy, ox, olabels, gcf); hold on
    fixfiglimits
   
    
end


% fixfiglimits(1.2)
% a = xlim;
% xlim(a - [0 .2]);


% plotfillmulti(ox, voy, stitle, varargin{:});

end % function


%% note: type "doc hungarian" for variable prefix explanation.
