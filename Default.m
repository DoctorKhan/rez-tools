function varargout = Default(varargin)

% varargout = Default(varargin);
%
%
%
% Khan 07/20/2011

%% Default params

%% Initialize
varargin(cellfind(varargin, '-v')) = [];
varargin(cellfind(varargin, 'is')) = {'%'}; 
if nargout > 0
    csOut = outputnames;
    for ii = 1:nargout
        if evalin('caller', ['notDefined(''' csOut{ii} ''')'])
            varargout{ii} = varargin{ii};
        else
            varargout{ii} = evalin('caller', csOut{ii});
        end
    end
else
    for iArg = 1:length(varargin)
        if ~ischar(varargin{iArg}), varargin{iArg} = inputname(iArg); end
    end
    
    sAllArgs = [varargin{:}];
    csArgs = strtrim(regexp(sAllArgs, '(\||&)', 'split'));
    nArgs = length(csArgs);
    
    viNoEqual = setdiff(1:nArgs, cellmatch(csArgs, '='));
    
    for iArg = viNoEqual
        sArg = csArgs{iArg};
        if ~isempty(regexp(sArg, '\%', 'once'))
            csAssert = regexp(sArg, '\%', 'split');
            sVarName = csAssert{1};
            sVarType = csAssert{2};
            sqName = squote(sVarName);
            s = ['exist(' sqName ', ''var'') && ~isempty(' sqName ')'];
            if evalin('caller', s)
                         if ~evalin('caller', ['is' sVarType '(' sVarName ')'])
                             evalin('caller', Str('varargin = [', sVarName, ' varargin]; ', sVarName, '= [];'))
                         end
            end
            csArgs{iArg} = sVarName;
        else
            if isempty(regexp(csArgs{iArg}, '=', 'once'))
                csArgs{iArg} = regexprep(csArgs{iArg}, ' ', ' = ', 'once');
            end
        end
    end
        
    %% Main
    for csArg = csArgs
        csBoth = regexp(csArg{1}, ' *= *', 'split');
        
        sVar = strtrim(csBoth{1});
        
        if length(csBoth) < 2 || isempty(csBoth{2})
            sVal = squote('');
        else
            sVal = regexprep(strtrim(csBoth{2}), '"', '''');
        end
        
        if any(sVar == '.')
            sLine = ['try if isempty(' sVar '), ' sVar ' = ' sVal '; end; catch, ' sVar ' = ' sVal '; end'];
        else
            sLine = ['if ~exist(' squote(sVar) ', ' squote('var') ') || isempty(' ...
                sVar '), ' sVar ' = ' sVal '; end'];
        end
        try
            evalin('caller', sLine);
        catch ME           
%             assignin('caller', 'ME', ME);
            ME.stack(2:end)
            error([sLine, ' failed.']);
        end
    end % for
end % if
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
