% Rcl;
%
%
%
% Khan 04/28/2012
 
% %% Default params
% for ii = 1:length(varargin)-1
%     varargin{ii} = [varargin{ii} '|'];
% end
% sClasses = [varargin{:}];

%% Initialize
% voVars = evalin('caller', 'HorzVec(NumStruct(whos))');
% viClassVars = []; viVars = [];
%% Main
voRefresh = HorzVec(NumStruct(WhosObj));

%%
for oVar = voRefresh
    eval([oVar.name 'Obj = Obj2Struct(' oVar.name ');']) ;
    clear(oVar.name);
end
%%
for oVar = voRefresh
    eval([oVar.name '=' oVar.class '(' oVar.name 'Obj);']) ;
end

% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
