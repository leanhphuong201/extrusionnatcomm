%Find the correlation length
for i=1:16
    
    corrMat = corr_cell{i,1};
    figure; plot(r{i,1}.*grd_spc.*pxl_sz,corrMat(1:length(r{i}),:)); grid on;
    
    temp = corr_cell{i,1};
    temp = abs(temp);
    [row col] = find(temp == min(temp(1:100)));
    
    correlationLength(i,1) = r{i}(row,col).*grd_spc.*pxl_sz;
end