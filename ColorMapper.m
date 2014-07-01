classdef ColorMapper
    properties (SetAccess = public)
        miColorOrder
    end
    % The following properties can be set only by class methods
    properties (SetAccess = private)
        mMap, minLim, span
        nColors
    end
    
    methods
        function o = ColorMapper(viLimits,sMap)
            Default viLimits = [0 1];
            if isstruct(viLimits)
                oFile = viLimits;
                switch DecodeHemoName(oFile, 'sType')
                    case 'thickness'
                        viLimits = [ 1 4 ];
                    case 'curvature'
                        viLimits = [ -.25 .25 ];
                    otherwise
                        viLimits = [ -1 2 ];
                end
            end
            
            Default sMap = 'jet';
            
            o.mMap = colormap(sMap);
            o.span = diff(viLimits);
            o.minLim = viLimits(1);
            o.nColors = size(o.mMap,1);
        end
        
        function mOut = GetColors(o, vData)
            if isstruct(vData)
                voData = vData;
                for oData = voData
                    if exist(StructName(oData), 'file')
                        colorFrac = DecodeHemoName(oData, 'middle');
                    else
                        colorFrac = oData.iNum/oData.nTot;
                    end
                    voData(oData.iNum).vColor = o.GetColors(colorFrac);
                end
                mOut = voData;
            else
                vColors = (vData-o.minLim)/o.span;
                viColors = ceil(vColors*(o.nColors-1)+1);
                viColors(viColors < 1) = 1;
                viColors(viColors > o.nColors) = o.nColors;
                mOut = o.mMap(viColors,:);
            end
        end
        
        function SetColorOrder(o, vData, hPlot)
            o.miColorOrder = o.GetColors(vData);
            Default hPlot = 0;
            set(hPlot,'DefaultAxesColorOrder', o.miColorOrder)
        end
    end
end