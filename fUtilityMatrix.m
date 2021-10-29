% This function returns a length(vkGrid)-by-length(vkGrid) log-utility
% matrix, with current capital level on rows and next-period capital level
% in columns. There is a feasibility constraint (positive consumption).

% Input list:
% dalpha: Productivity of capital
% vkGrid: Grid of all capital levels

function mtxUMAT = fUtilityMatrix(dalpha, vkGrid)
    iGridLength = length(vkGrid);
    mtxUMAT = -Inf(iGridLength, iGridLength);
    for irow = 1:iGridLength
        for icolumn = 1:iGridLength
            if vkGrid(icolumn) < vkGrid(irow)^dalpha % Feasibility
                mtxUMAT(irow, icolumn) = log(vkGrid(irow)^dalpha - vkGrid(icolumn));
            end
        end
    end
end