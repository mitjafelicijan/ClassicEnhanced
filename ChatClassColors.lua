local _, ns = ...

local feature = ns.Register({
  identifier = "ChatClassColors",
  description = "Chat will have class colored player names.",
  category = "social",
  frame = nil,
  config = {}
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")

feature.frame:SetScript("OnEvent", function(self, event)
  if event == "ADDON_LOADED" then
    if not ns.IsEnabled(feature.identifier) then
      SetCVar("chatClassColorOverride", "1")

      for void, v in ipairs({"SAY", "EMOTE", "YELL", "GUILD", "OFFICER", "WHISPER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "RAID_WARNING", "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER"}) do
        SetChatColorNameByClass(v, false)
      end

      for i = 1, 50 do
        SetChatColorNameByClass("CHANNEL" .. i, false)
      end

      return
    end

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
