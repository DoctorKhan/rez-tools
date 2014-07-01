function NormalizeAllDepthMaps(voHemo, varargin)

% NormalizeAllDepthMaps(voHemo, varargin);
%
%
%
% Khan 10/13/2011

%% Default params
Default varargin = {'force'}

%% Initialize
HemoInit

%% Main
for oHemo = voHemo
		cds(oHemo)
		mrGlobals
		
        TextWaitbar(oHemo, oHemo);
		oView = InitHidden('Volume', 'Timed', 'SliceBlock', varargin{:});
		NormalizedDepthMap(oView, oHemo, 'force', varargin{:});
		
		clear global oView
end

CombMeshHemis(voHemo, 'White', 'Pia');
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
