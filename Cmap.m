classdef Cmap
    properties (SetAccess = public)
        mCbar, vX, scale, offset, nColors, hMap;
    end
    
    % The following properties can be set only by class methods
    properties (SetAccess = private)
    end
    
    methods
        function oMap = Cmap(hMap, nColors, scale, offset)
            Default hMap = @jet;
            Default nColors = 256;
            Default scale = 1 & offset = 0;
            mCbar = hMap(nColors);
            vX = scale*normalize(1:nColors) + offset;
            oInput = Struct(vX, mCbar, scale, offset, nColors, hMap);
            oMap = CopyStruct(oMap, oInput);
        end
                
        function vColor = subsref(oMap, oIndices)
            switch [oIndices.type]
%                 case '().'
%                     ciIndices = oIndices(1).subs;
%                     sProp = oIndices(2).subs;
%                     try oMap.addprop(sProp); end
%                     oMap(ciIndices{:}).(sProp) = xValue;
                case '()'
                    ciIndices = oIndices.subs;
                    vColor = interp1(oMap.vX, oMap.mCbar, ciIndices{:});
                case '.'
                    vColor = oMap.(sProp);
                otherwise
                    vColor = builtin('subsref', oMap, oIndices);
            end
        end
    end
end