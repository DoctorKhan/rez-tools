% ClassTemplate;
%
%
%
% Khan 04/15/2012

classdef ClassTemplate < dynamicprops
    properties (SetAccess = public)
        iNum = 1;
    end
    
    methods % constructor
        function oClassTemplate = ClassTemplate(oArgs, varargin)
            if nargin > 0
                oClassTemplate = ClassTemplate;
                if isa(oFirst, 'ClassTemplate') || isstruct(oFirst)
                    oInput = oFirst;
                else
                    oInput = ClassTemplateCons(oArgs, varargin{:});
                end
                oClassTemplate = CopyStruct(oClassTemplate, oInput);
            end % constructor
        end % methods
        
        function oClassTemplate = subsasgn(oClassTemplate, voInd, xValue)
            ciInd = voInd(1).subs;
            sProp = voInd(end).subs;
            
            if isempty(oClassTemplate), oClassTemplate = ClassTemplate; end
            switch [voInd.type]
                case '().'
                    try
                        oClassTemplate(ciInd{:});
                    catch %#ok<*CTCH>
                        oClassTemplate(ciInd{:}) = oClassTemplate;
                    end
                    try
                        oClassTemplate(ciInd{:}).addprop(sProp);
                    end
                    oClassTemplate(ciInd{:}).(sProp) = xValue;
                case '.'
                    sProp = voInd.subs;
                    try  %#ok<*TRYNC>
                        oClassTemplate.addprop(sProp);
                    end
                    oClassTemplate.(sProp) = xValue;
                otherwise
                    oClassTemplate = builtin('subsasgn', oClassTemplate, voInd, xValue);
            end %switch
        end % function
        
    end % methods
end % classdef


%% Note: type "doc hungarian" for variable prefix explanation.
