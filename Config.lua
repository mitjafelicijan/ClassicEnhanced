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

ns.KVStorage = {}

ns.KVStorage.defaults = function()
  ClassicEnhancedDB.KV = {}
end

ns.KVStorage.Get = function(key)
  if not ClassicEnhancedDB.KV then ns.KVStorage.defaults() end

  if key and ClassicEnhancedDB.KV[key] then
    return ClassicEnhancedDB.KV[key]
  end
end

ns.KVStorage.Set = function(key, value)
  if not ClassicEnhancedDB.KV then ns.KVStorage.defaults() end
  
  if key then
    ClassicEnhancedDB.KV[key] = value
  end
end

ns.KVStorage.Del = function(key)
  if not ClassicEnhancedDB.KV then ns.KVStorage.defaults() end

  if key and ClassicEnhancedDB.KV[key] then
    ClassicEnhancedDB.KV[key] = nil
  end
end

ns.Helpers = {}

ns.Helpers.TableContainsValue = function(table, value)
  if table then
    for _, v in pairs(table) do
      if v == value then
        return true
      end
    end
  end
end
