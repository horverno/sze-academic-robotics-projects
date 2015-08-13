diff_scn = diff(data);
posDiff = 0;
for i=2:size(data,2)
    if abs(sqrt(diff_scn(1,i-1)^2-diff_scn(1,i)^2))>1.6
        posDiff = i
        break
    end
end