function N = Scale( A )
N=(A-min(A(:)))./(max(A(:))-min(A(:)));
end
