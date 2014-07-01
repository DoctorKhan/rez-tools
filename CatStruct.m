function xoStruct = CatStruct(iDim, o1, o2)

% xoStruct = CatStruct(iDim, o1, o2);
%
%
%
% Khan 03/23/2012
 
%% Default params


%% Initialize


%% Main

%% Initialize
cs1 = fieldnames(o1); cs2 = fieldnames(o2);

for oField = Str2Struct(setdiff(cs2, cs1))
    o1.(oField.name) = [];
end    

for oField = Str2Struct(setdiff(cs1, cs2))
    o2.(oField.name) = [];
end    

%% Main
xoStruct = cat(iDim, o1, o2);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
