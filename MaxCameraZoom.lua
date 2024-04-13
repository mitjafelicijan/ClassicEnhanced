local _, ns = ...

local feature = {
  key = "MaxCameraZoom",
  name = "Able to zoom the camera out to a greater distance.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("PLAYER_ENTERING_WORLD")

  feature.frame:SetScript("OnEvent", function(self, event)
    ConsoleExec("cameraDistanceMaxZoomFactor 4")
  end)
else
  ConsoleExec("cameraDistanceMaxZoomFactor 1")
end
