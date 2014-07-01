function progress = LoopProg(viIteration, viLoopMaxes)

% progress = LoopProg(viIteration, viLoopMaxes);
%
% Calculates fractional progress throughout multiple loops.
%
% Khan 03/29/2010

%% Default params


%% Initialize
complete = prod(viLoopMaxes);
nLoops = length(viIteration);

%% Main
if isscalar(viIteration)
    progress = viIteration/viLoopMaxes;
% else
%     vProg = viIteration-1;
% %     vProg(end) = vProg(end);
%     progress = dot(vProg, viLoopMaxes - 1);
%     progress = progress + 1;
%     progress = progress/complete;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
