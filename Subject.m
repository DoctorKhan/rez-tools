% Subject;
%
%
%
% Khan 05/16/2012

classdef Subject < dynamicprops
    properties (SetAccess = public)
        oHemo, oHemi, name, region, hemi, iNum = 1;
        sdf, pialMesh, whiteMesh, dist, mesh, wsdf
    end
    properties (SetAccess = private)
        fdata
    end
    
    methods % constructor
        function oSubject = Subject(oIn, varargin)
            if nargin > 0
                oSubject = Subject;
                if isa(oIn, 'Subject')
                    oInput = oIn;
                else
                    oInput = SubjectCons(oIn, varargin{:});
                end
                oSubject = CopyStruct(oSubject, oInput);
            end % constructor
        end % methods
        
        function oSubject = subsasgn(oSubject, voInd, xValue)
            ciInd = voInd(1).subs;
            sProp = voInd(end).subs;
            
            if isempty(oSubject), oSubject = Subject; end
            switch [voInd.type]
                case '().'
                    try
                        oSubject(ciInd{:});
                    catch %#ok<*CTCH>
                        oSubject(ciInd{:}) = oSubject;
                    end
                    try
                        oSubject(ciInd{:}).addprop(sProp);
                    end
                    oSubject(ciInd{:}).(sProp) = xValue;
                case '.'
                    sProp = voInd.subs;
                    try  %#ok<*TRYNC>
                        oSubject.addprop(sProp);
                    end
                    oSubject.(sProp) = xValue;
                otherwise
                    oSubject = builtin('subsasgn', oSubject, voInd, xValue);
            end %switch
        end % function
        
        function ShowPia(oSubject)
            SliceMeshOnVolume(oSubject.pialMesh, oSubject.sdf);
        end
        
        function ShowWhite(oSubject)
            SliceMeshOnVolume(oSubject.White, oSubject.sdf);
        end
        
        function wsdf = GetWsdf(oSubject)
             if isempty(oSubject.wsdf)
                wsdf = Load(AnatPath(oSubject.oHemo, 'Laminae.mat'), 'tNorm');
                oSubject.wsdf = wsdf;
             else
                 wsdf = oSubject.wsdf;
             end
        end
        
        function dist = GradDist(oSubject)
            if isempty(oSubject.whiteMesh)
                whiteMesh = GetMesh(oSubject.oHemo);
            end
            
            dist = GradTraject(whiteMesh, oSubject.GetWsdf);
            oSubject.dist = dist;
        end
    end % methods
end % classdef


%% Note: type "doc hungarian" for variable prefix explanation.
