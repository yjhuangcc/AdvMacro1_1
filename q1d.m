% Obtain policy rule after two iterations
for n = 1:2
    vVnew = zeros(length(vkGrid), 1);
    vIndex = zeros(length(vkGrid), 1);
    for i = 1:length(vkGrid)
        vObjRHS = log(vkGrid(i)^dalpha - vkGrid) + dbeta * vV;
        vObjRHS(imag(vObjRHS) ~= 0) = -Inf;
        [vVnew(i), vIndex(i)] = max(vObjRHS);
    end
    vV = vVnew;
end

% Apply policy rule multiple times
while derror >= depsilon
    for i = 1:length(vkGrid)
        vVnew(i) = log(vkGrid(i)^dalpha - vkGrid(vIndex(i))) + dbeta * vV(i);
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