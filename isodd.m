function boolean = isodd(value)

%
% boolean = isodd(value);
%
% 
%
% Khan  02/27/09
%

    boolean = ~(value == floor(value/2)*2) & (floor(value) == value);
end
