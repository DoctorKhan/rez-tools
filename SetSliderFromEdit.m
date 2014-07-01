function SetSliderFromEdit(hEdit, hSlider)

%
% SetSliderFromEdit(hEdit, hSlider);
%
% Transfers a value from an edit field to a slider.
%
% Khan 02/18/09
%

editValue = str2double(get(hEdit,'String')); editValue = editValue(1);
% Determine whether editValue is a number between the
% slider's Min and Max. If it is, set the slider Value.
if isnumeric(editValue)
    if editValue < get(hSlider,'Min')
        set(hSlider,'Min',editValue);
    elseif editValue > get(hSlider,'Max')
        set(hSlider,'Max',editValue);
    end
    
    set(hSlider,'Value',editValue);
end

end
