function imgs=NormalizeContrastAndBrightness(imgs)
  imgs=FeatureNormalize(imgs',0)';
end