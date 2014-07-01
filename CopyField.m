function voStruct = CopyField(voStruct, sSource, sTarg)

% CopyField(voStruct, sSource, sTarg);
%
%
%
% Khan 11/07/2011

%% Default params


%% Initialize
% if ~isfield(voStruct, sSource)
% 	return; 
% end

%% Main
for ii = 1:length(voStruct)
	voStruct(ii).(sTarg) = voStruct(ii).(sSource);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
