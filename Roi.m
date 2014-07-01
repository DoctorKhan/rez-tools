% Roi;
%
%
%
% Khan 05/16/2012

classdef Roi < dynamicprops
    properties (SetAccess = public)
        iNum = 1;
    end
    
    methods % constructor
        function oRoi = Roi(oIn, varargin)
            if nargin > 0
                oRoi = Roi;
                if isa(oIn, 'Roi') || isstruct(oIn)
                    oInput = oIn;
                else
                    oInput = RoiCons(oIn, varargin{:});
                end
                oRoi = CopyStruct(oRoi, oInput);
            end % constructor
        end % methods
        
        function oRoi = subsasgn(oRoi, voInd, xValue)
            ciInd = voInd(1).subs;
            sProp = voInd(end).subs;
            
            if isempty(oRoi), oRoi = Roi; end
            switch [voInd.type]
                case '().'
                    try
                        oRoi(ciInd{:});
                    catch %#ok<*CTCH>
                        oRoi(ciInd{:}) = oRoi;
                    end
                    try
                        oRoi(ciInd{:}).addprop(sProp);
                    end
                    oRoi(ciInd{:}).(sProp) = xValue;
                case '.'
                    sProp = voInd.subs;
                    try  %#ok<*TRYNC>
                        oRoi.addprop(sProp);
                    end
                    oRoi.(sProp) = xValue;
                otherwise
                    oRoi = builtin('subsasgn', oRoi, voInd, xValue);
            end %switch
        end % function
        
    end % methods
end % classdef


%% Note: type "doc hungarian" for variable prefix explanation.
