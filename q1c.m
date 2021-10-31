while derror >= depsilon
    vVnew = zeros(length(vkGrid), 1);
    vIndex = zeros(length(vkGrid), 1);
    iIndex = 1;
    for i = 1:length(vkGrid)
        vObjRHS = -Inf(length(vkGrid), 1);
        dObjRHS = -Inf;
        j = 1;
        while j <= length(vkGrid)
            dObjRHStemp = log(vkGrid(i)^dalpha - vkGrid(j)) + dbeta * vV(j);
            if dObjRHStemp >= dObjRHS
                vObjRHS(j) = dObjRHStemp;
                dObjRHS = dObjRHStemp;
                j = j + 1;
            else
                j = Inf;
            end
        end
        vObjRHS(imag(vObjRHS) ~= 0) = -Inf;
        [dVnew, iIndex] = max(vObjRHS);
        vVnew(i) = dVnew;
        vIndex(i) = iIndex;
    end
    derror = max(abs(vVnew - vV));
    vV = vVnew;
end

vkSol = zeros(1000, 1);
vkSol(1) = dk0;

for i = 2:1000
    iOriginalIndex = find(vkGrid == vkSol(i - 1));
    iBestIndex = vIndex(iOriginalIndex);
    vkSol(i) = vkGrid(iBestIndex);
end

vkSolForward1 = [vkSol(2:end); vkSol(end)];
vcSol = vkSol.^dalpha - vkSolForward1;
vrSol = dalpha * vkSol.^(dalpha - 1);