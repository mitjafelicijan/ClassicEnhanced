local name, ns = ...

if ClassicEnhancedDB == nil then
  ClassicEnhancedDB = {}
end

ns.Features = {}
ns.Config = {
  ManaBarColor = { r = 0.0, g = 0.6, b = 1 }
}

ns.Register = function(feature)
  if ClassicEnhancedDB[feature.identifier] == nil then
    ClassicEnhancedDB[feature.identifier] = false
  end
  
  tinsert(ns.Features, feature)
  return feature
end

ns.IsEnabled = function(identifier)
  if ClassicEnhancedDB[identifier] ~= nil then
    return ClassicEnhancedDB[identifier]
  end
end
