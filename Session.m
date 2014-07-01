% Session;
%
%
%
% Khan 05/16/2012

classdef Session < dynamicprops
    properties (SetAccess = public)
        iNum = 1;
    end
    
    methods % constructor
        function oSession = Session(oIn, varargin)
            if nargin > 0
                oSession = Session;
                if isa(oIn, 'Session') || isstruct(oIn)
                    oInput = oIn;
                else
                    oInput = SessionCons(oIn, varargin{:});
                end
                oSession = CopyStruct(oSession, oInput);
            end % constructor
        end % methods
        
        function oSession = subsasgn(oSession, voInd, xValue)
            ciInd = voInd(1).subs;
            sProp = voInd(end).subs;
            
            if isempty(oSession), oSession = Session; end
            switch [voInd.type]
                case '().'
                    try
                        oSession(ciInd{:});
                    catch %#ok<*CTCH>
                        oSession(ciInd{:}) = oSession;
                    end
                    try
                        oSession(ciInd{:}).addprop(sProp);
                    end
                    oSession(ciInd{:}).(sProp) = xValue;
                case '.'
                    sProp = voInd.subs;
                    try  %#ok<*TRYNC>
                        oSession.addprop(sProp);
                    end
                    oSession.(sProp) = xValue;
                otherwise
                    oSession = builtin('subsasgn', oSession, voInd, xValue);
            end %switch
        end % function
        
    end % methods
end % classdef


%% Note: type "doc hungarian" for variable prefix explanation.
