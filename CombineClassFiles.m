function oBoth = CombineClassFiles(oHemo)

% bo = CombineClassFiles;
%
%
%
% Khan 07/19/2011 - Started
% Khan/Luther 01/06/2012 - Made it work

%% Default params
Default oHemo = HemoFromDir
%% Initialize
Destruct oHemo
HemoInit

pLeft  = AnatPath(oHemo, 'Left',  [sSubject, 'Left.Class' ]);
pRight = AnatPath(oHemo, 'Right', [sSubject, 'Right.Class']);
pBoth = AnatPath(oHemo, [sSubject, 'Both.Class' ]);

%% Main
oLeft  = readClassFile(pLeft);
oRight = readClassFile(pRight);

lh.tbWhite = (oLeft.data == oLeft.type.white);
rh.tbWhite = (oRight.data == oRight.type.white);
lh.tbCSF = (oLeft.data == oLeft.type.csf);
rh.tbCSF = (oRight.data == oRight.type.csf);
lh.tbUnknown = (oLeft.data == oLeft.type.unknown);
rh.tbUnknown = (oRight.data == oRight.type.unknown);

tbUnknown = (lh.tbUnknown | rh.tbUnknown);
tbCSF = (lh.tbCSF | rh.tbWhite);
tbWhite = (lh.tbWhite | rh.tbWhite);

%% Output
oBoth = oLeft;
oBoth.filename = pBoth;

oBoth.data(tbCSF) = oBoth.type.csf;
oBoth.data(tbUnknown) = oBoth.type.unknown;
oBoth.data(tbWhite) = oBoth.type.white;

writeClassFile(oBoth);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
