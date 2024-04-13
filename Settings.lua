local _, ns = ...

for k, v in ipairs(ns.Features) do
  print("-", k, ">", v.key, ":", v.name)
end
