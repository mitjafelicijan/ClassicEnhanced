local _, ns = ...

local feature = {
  key = "ChatClassColors",
  name = "Chat will have class colored player names.",
  enabled = true,
  frame = nil,
  config = {}
}

tinsert(ns.Features, feature)

if feature.enabled then
  feature.frame = CreateFrame("Frame")
  feature.frame:RegisterEvent("ADDON_LOADED")

  feature.frame:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" then

      -- Set to 1 and and false to restore defaults
      
      SetCVar("chatClassColorOverride", "0")

      for void, v in ipairs({"SAY", "EMOTE", "YELL", "GUILD", "OFFICER", "WHISPER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "RAID_WARNING", "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER"}) do
        SetChatColorNameByClass(v, true)
      end

      for i = 1, 50 do
        SetChatColorNameByClass("CHANNEL" .. i, true)
      end

      self:UnregisterEvent("ADDON_LOADED")
    end
  end)
end
