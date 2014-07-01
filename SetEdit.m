function SetEdit(hEdit, value)

%
% SetSlider(hEdit, value);
%
% Transfers a value to an edit box.
%
% Khan 10/12/09
%


% Determine whether value is a number between the
% slider's Min and Max. If it is, set the slider Value.
if isnumeric(value)
    if value < get(hEdit,'Min')
        set(hEdit,'Min',value);
    elseif value > get(hEdit,'Max')
        set(hEdit,'Max',value);
    end
    
    set(hEdit,'String', num2str(value));
end

end