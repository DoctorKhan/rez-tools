function o = InvertStruct(a)

% InvertStruct;
%
%
%
% Khan 09/01/2011

%% Default params

%% Initialize
viDims = size(a);
[s, f] = Struct2Cell(a);
nFields = length(f);


%% Main
if length(a) > 1
	for iField = 1:nFields
		xField = s(iField,:);
		
		try
			v = cell2mat(xField);
			if isnumeric(v)
				xField = v;
			end
		catch
		end
		
		o.(f{iField}) = reshape(xField, viDims);
	end
else
	o = cell2struct(s, f, 1);
end

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
