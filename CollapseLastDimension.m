function mCollapsedMatrix = CollapseLastDimension(mInput)
index = 1;
for x = 1:length(mInput(1,:,1)
    for y = 1:length(mInput(1,1,:))
        for t = 1:length(mInput(:,1,1))
            mCollapsedMatrix(t, index) = mInput(t,x,y);
        end
        index = index + 1;
    end
end

end