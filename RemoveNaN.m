function [out, mask] = RemoveNaN(in, mMask)

s = size(in);

switch length(s)
    case 2
        if(s(1) == 1)
            % Remove NaN from each element of the row vector
            vIn = in;
            for i = 1:length(vIn)
                if ~isnan(vIn(i))
                    vMask(i) = 1;
                    if notDefined('vOut')
                        vOut(1) = vIn(i);
                    else
                        vOut = horzcat(vOut, vIn(i));
                    end
                else
                    vMask(i) = 0;
                end
            end
            if notDefined('vOut')
                out = 0;
            else
                out = vOut;
            end
            mask = vMask;
        else
            mIn = in;
            for it = 1:s(1)
                vIn = mIn(it,:);
                [vOut, vMask] = RemoveNaN(vIn);
                if (vOut ~= 0)
                    cOut{it} = vOut;
                end
            end
            out = cOut;
        end        
end

%ins = reshape(in, [s(1), prod(s(2:end))]);

%if exist('mMask', 'var')
%    for it = 1:s(1)
%        vMask = mMask(:,it);
%        vPreData = ins(it, :);

%        for i = 1:length(vMask)
%            if vMask(i) == 1
%                if notDefined('vData')
%                    vData(1) = vPreData(i);
%                else
%                    vData = horzcat(vData, vPreData(i));
%                end
%            end
%        end
%        tOut(it, :) = vData;
%    end

end