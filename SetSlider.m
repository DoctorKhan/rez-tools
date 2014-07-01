function SetSlider(hSlider, value)

%
% SetSlider(hSlider, value);
%
% Transfers a value to a slider.
%
% Khan 10/12/09
%


% Determine whether value is a number between the
% slider's Min and Max. If it is, set the slider Value.
if isnumeric(value)
    if value < get(hSlider,'Min')
        set(hSlider,'Min',value);
    elseif value > get(hSlider,'Max')
        set(hSlider,'Max',value);
    end
    
    set(hSlider,'Value',value);
end

end
