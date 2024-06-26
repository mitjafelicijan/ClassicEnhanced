local _, ns = ...

local feature = ns.Register({
  identifier = "PowerBarsColor",
  description = "Changes default colors of power bars such as mana.",
  category = "interface",
  frame = nil,
  config = {}
})

local function RecolorUnitFramePowerBar(frame)
  if frame then
    frame:SetStatusBarColor(
      ns.Config.ManaBarColor.r,
      ns.Config.ManaBarColor.g,
      ns.Config.ManaBarColor.b)
  end
end

local function PlayerPowerBar()
  local _, typeLabel = UnitPowerType("player")
  if typeLabel == "MANA" then
    RecolorUnitFramePowerBar(_G["PlayerFrameManaBar"])
  end
end

local function PlayerPetPowerBar()
  local _, typeLabel = UnitPowerType("pet")
  if typeLabel == "MANA" then
    RecolorUnitFramePowerBar(_G["PetFrameManaBar"])
  end
end

local function TargetPowerBar()
  local _, typeLabel = UnitPowerType("target")
  if typeLabel == "MANA" then
    RecolorUnitFramePowerBar(_G["TargetFrameManaBar"])
  end
end

local function ToTPowerBar()
  local _, typeLabel = UnitPowerType("targettarget")
  if typeLabel == "MANA" then
    RecolorUnitFramePowerBar(_G["TargetFrameToTManaBar"])
  end
end

local function GroupFramesPowerBars()
  for i = 1, MAX_PARTY_MEMBERS do
    local frame = _G["PartyMemberFrame" .. i]
    if frame then
      local unit = frame:GetAttribute("unit")
      if unit then
        local _, typeLabel = UnitPowerType(unit)
        if typeLabel == "MANA" then
          RecolorUnitFramePowerBar(_G["PartyMemberFrame" .. i .. "ManaBar"])
        end
      end
    end
  end
end

local function RaidFramesPowerBars()
  for i = 1, MAX_RAID_MEMBERS do
    local frame = _G["CompactRaidFrame" .. i]
    if frame then
      local unit = frame:GetAttribute("unit")
      if unit then
        local _, typeLabel = UnitPowerType(unit)
        if typeLabel == "MANA" then
          RecolorUnitFramePowerBar(_G["CompactRaidFrame" .. i .. "PowerBar"])
        end
      end
    end
  end
end

feature.frame = CreateFrame("Frame")
feature.frame:RegisterAllEvents()

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end
  
  PlayerPowerBar()
  PlayerPetPowerBar()
  TargetPowerBar()
  ToTPowerBar()

  if IsInGroup() or IsInRaid() then
    GroupFramesPowerBars()
    RaidFramesPowerBars()
  end
end)
