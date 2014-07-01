function xData = StructData(oIn)

% xData = StructData(oIn);
%
%
%
% Khan 04/23/2012

%% Main
if isSub(oIn, 'tData')
   xData = oIn.tData;
elseif isSub(oIn, 'vertices')
    xData = oIn.vertices;
else
    xData = oIn;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
