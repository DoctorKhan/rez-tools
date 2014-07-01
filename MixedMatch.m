function [xA, xB, viPerm] = MixedMatch(xA, xB)

% [xA, xBOut, viMap] = MixedMatch(xA, xB);
%
% Expand a matrix through repmat to match the size of another.
%
% Khan 01/03/2011
% Khan 08/18/2011 - Recoded so it actually works.

%% Default
viPerm = [];

%% Initialize
if isempty(xA) || isempty(xB)
    return
end

%% Main
xA = squeeze(ExpandDims(xA, xB));
xB = squeeze(ExpandDims(xB, xA));
viPerm = MatchDims(xB, xA);
if nargout < 2
    xA = ipermute(xA, viPerm);
else
    xB = permute(xB, viPerm);
end
        end % Function
       
        
        %% Note: type "doc hungarian" for variable prefix explanation.
