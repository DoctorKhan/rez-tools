function moTarget = CopyStruct(moTarget, coSource, varargin)

% moTarget = CopyStruct(moTarget, coSource, csFields, varargin);
%
% Copy fields from one struct to another.
%
% Khan 07/30/2011
% Khan 09/28/2011 - added csFields input

%% Arg Handling
if notDefined('coSource'), return; end
if ~iscell(coSource), coSource = {coSource}; end
coSource = HorzVec(coSource);

Default varargin = fieldnames(coSource{1});

%% Initialize
voFields = Str2Struct(varargin);

%% Main
for coSource1 = coSource, moSource = coSource{1};
%     [moTarget moSource] = MixedMatch(moTarget, moSource);
    for oSource = moSource
        for oField = voFields
            for ii = 1:numel(moTarget)
                try
                moTarget(ii).(oField.name) = oSource.(oField.name);
                catch me
                    Str(me.message);
                end
            end
        end
    end
end

if nargout == 0
    assignin('caller', inputname(1), moTarget2);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
