function oStructOfMats = HRFStructArray2Struct(oIn)

% coOut = HRFStructArray2Struct(oIn);
%
% This just converts the old crappy structure to a more logical one for
% statistical analysis.
%
% Khan 03/31/2010

for ii = 1:size(oIn, 1)
	for jj = 1:size(oIn, 2)
		FWHMValue(ii,jj, :)			= oIn(ii, jj, :).vFWHM(2);
		InitialDipTime(ii,jj, :)	= oIn(ii, jj, :).vInitDip(1);
		InitialDipValue(ii,jj, :)	= oIn(ii, jj, :).vInitDip(2);
		PeakTime(ii,jj, :)			= oIn(ii, jj, :).vPeak(1);
		PeakValue(ii,jj, :)			= oIn(ii, jj, :).vPeak(2);
		UndershootTime(ii,jj, :)	= oIn(ii, jj, :).vUndershoot(1);
		UndershootValue(ii,jj, :)	= oIn(ii, jj, :).vUndershoot(2);
	end
end

oStructOfMats = Struct(FWHMValue, InitialDipTime, InitialDipValue, PeakTime, PeakValue, ...
	UndershootTime, UndershootValue);

% 
% %% Default params
% 
% 
% %% Initialize 1/2
% 
% EmptyStruct(oIn);
% 
% csFields = fieldnames(oIn);
% nFields = length(csFields);
% 
% %% Main 1/2
% 
% c3dOfMats = struct2cell(oIn);
% cOfMats = squeeze(reshape(c3dOfMats, numel(c3dOfMats), 1));
% mAll = cell2mat(cOfMats);
% 
% %% Init 2/2
% nDataCols = size(mAll,2);
% coOut = cell(nDataCols, 1);
% 
% %% Main Loop 2/2
% for iCol = 1:nDataCols
%     tData = reshape(mAll(:,iCol), size(c3dOfMats));
%     
%     for iField = 1:nFields
%         sField = csFields{iField};
%         if (iCol == 1)
%             sField = [sField(2:end), 'Time'];
%         else
%             sField = [sField(2:end), 'Value'];
%         end
%         oStructOfMats.(sField) = squeeze(tData(iField,:,:));
%     end
% end
% 
% oStructOfMats = orderfields(rmfield(oStructOfMats, 'FWHMTime'));
% 
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
