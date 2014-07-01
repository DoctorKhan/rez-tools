classdef InterpScattered
% Simple version. Accepts matrix coordinate input.
% Khan 08/31/2010    
    properties (SetAccess = public)
        coInterp, vbFin, nValDims
    end
    
    methods
        function oTri = InterpScattered(mCoords, mValues)
            if nargin > 0
                mCoords = double(mCoords); mValues = double(mValues);
                [m oTri.vbFin] = Finite(HorzMat(mCoords));
                mVals = Finite(mValues, oTri.vbFin);
                
                [m, mVals] = MixedMatch(m, mVals);
                assert(size(m,2) == size(mVals,2));
                
                oTri.nValDims = size(mVals,1);
                [x y z] = Foliate(m, @VertVec);
                for ii = 1:oTri.nValDims;
                    v = VertVec(mVals(ii,:));
                    tic; warning off; %#ok<*WNOFF>
                    oTri.coInterp{ii} = TriScatteredInterp(x, y, z, v); 
                    toc; warning on; %#ok<*WNON>
                end
            end
        end
        
        function [mInterp, mInterpFin, vbFin] = Eval(oTri, mC)
            [x, y, z] = Foliate(mC);
            nPts = length(x);
            mInterp = nan(oTri.nValDims, nPts);
           
            TextWaitbar(0, 'Interpolating...');
            for ii = 1:oTri.nValDims
                mInterp(ii,:) = oTri.coInterp{ii}(x,y,z);
                TextWaitbar(ii/oTri.nValDims);
            end
            
            [mInterpFin, vbFin] = Finite(mInterp);
        end
    end % Function
end % Class
%% Note: type "doc hungarian" for variable prefix explanation.
