function patches=CenterPatches(patches)
  patches=bsxfun(@minus,patches,mean(patches,2));
end