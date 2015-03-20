function vn = normalizeVector(v)

  dim = size(v);

  if dim(1)==1 || dim(2)==1
      vn = v / sqrt(sum(v.^2));
  else
      vn = bsxfun(@rdivide, v, sqrt(sum(v.^2, 2)));
  end

end

%!assert (1,vectorNorm (normalizeVector ([3 4])))

