function [ct, m] = HemoFitAnalysis

% HemoFitAnalysis;
%
%
%
% Khan 08/29/2011

%% Default params
%% Initialize
HemoInit
viOrder = [ 3 5 7 1 2 4 6 ];
voHemo = NumStruct(voHemo);

%% Main
for iCNR = 1:4
	cnr = vCNRs(iCNR);
	for oHemo = voHemo
		cds(oHemo);
		voFiles = dir(['Boot*', cnr, '.mat']);
		mP = cell2mat(MultiLoad(voFiles, 'oFit.p'));
		ct{oHemo.iNum, iCNR} = mP(viOrder, :);
		
% 		mP(:, oHemo.iNum) = mean(cP{oHemo.iNum}, 2);
	end
end


m = cell2mat(cellfun(@Mean12, ct, 'UniformOutput', false));
mean(m,2)
mean(m,1)


end % Function
%% Note: type "doc hungarian" for variable prefix explanation.
