local _, ns = ...

local feature = ns.Register({
  identifier = "MaxCameraZoom",
  description = "Able to zoom the camera out to a greater distance.",
  category = "utility",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then
    ConsoleExec("cameraDistanceMaxZoomFactor 1.0")
    return
  end

  ConsoleExec("cameraDistanceMaxZoomFactor 4.0")
end)

