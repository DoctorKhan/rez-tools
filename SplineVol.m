% SplineVol;
%
%
%
% Khan 06/10/2012

classdef SplineVol < dynamicprops
    properties (SetAccess = public)
        cmoSpline, iNum = 1;
    end
    
    methods % constructor
        function oSplineVol = SplineVol(oIn, varargin)
            if nargin > 0
                oSplineVol = SplineVol;
                if isa(oIn, 'SplineVol') || isstruct(oIn)
                    oInput = oIn;
                else
                    oInput = SplineVolCons(oIn, varargin{:});
                end
                oSplineVol = CopyStruct(oSplineVol, oInput);
            end % constructor
        end % methods
        
        function oSplineVol = subsasgn(oSplineVol, voInd, xValue)
            ciInd = voInd(1).subs;
            sProp = voInd(end).subs;
            
            if isempty(oSplineVol), oSplineVol = SplineVol; end
            switch [voInd.type]
                case '().'
                    try
                        oSplineVol(ciInd{:});
                    catch %#ok<*CTCH>
                        oSplineVol(ciInd{:}) = oSplineVol;
                    end
                    try
                        oSplineVol(ciInd{:}).addprop(sProp);
                    end
                    oSplineVol(ciInd{:}).(sProp) = xValue;
                case '.'
                    sProp = voInd.subs;
                    try  %#ok<*TRYNC>
                        oSplineVol.addprop(sProp);
                    end
                    oSplineVol.(sProp) = xValue;
                otherwise
                    oSplineVol = builtin('subsasgn', oSplineVol, voInd, xValue);
            end %switch
        end % function
        
          function oSplineVol = subsref(oSplineVol, voInd, xValue)
            ciInd = voInd(1).subs;
            sProp = voInd(end).subs;
            
            if isempty(oSplineVol), oSplineVol = SplineVol; end
            switch voInd.type
                case '().'
                    try
                        vX = ciInd{1};
                        vY = ciInd{2};
                        vZ = ciInd{3};
                        
                        vXl = floor(vX);
                        vXu = ceil(vX);
                        vYl = floor(vY);
                        vYu = ceil(vY);
                        vZl = floor(vZ);
                        vZu = ceil(vZ);
                        
                        cmoSpline{1}(Vyl
                        oSplineVol();
                    catch %#ok<*CTCH>
                        oSplineVol(ciInd{:}) = oSplineVol;
                    end
                    try
                        oSplineVol(ciInd{:}).addprop(sProp);
                    end
                    oSplineVol(ciInd{:}).(sProp) = xValue;
                otherwise
                    oSplineVol = builtin('subsref', oSplineVol, voInd, xValue);
            end %switch
        end % function
        
    end % methods
end % classdef


%% Note: type "doc hungarian" for variable prefix explanation.
