local _, ns = ...

local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function(self, event)
  if event == "PLAYER_ENTERING_WORLD" then
    frame.window = CreateFrame("Frame", nil, UIParent)
    frame.window:SetSize(1, 1)
    frame.window:SetPoint("TOPLEFT", 440, -32)

    local function ExecCMD(cmd)
      local editBox = ChatEdit_ChooseBoxForSend()
      if editBox then
        editBox:SetText(cmd)
        ChatEdit_SendText(editBox)
      end
    end

    local tools = {
      {
        name = "Framestack",
        fn = function()
          ExecCMD("/fstack")
        end
      },
      {
        name = "Event Trace",
        fn = function()
          ExecCMD("/etrace")
        end
      },
      {
        name = "Addon usage",
        fn = function()
          ExecCMD("/addonusage")
        end
      },
      {
        name = "LFG",
        fn = function()
          ExecCMD("/LFG")
        end
      },
      {
        name = "Reload UI",
        fn = function()
          ExecCMD("/reload")
        end
      },
    }

    for idx, tool in ipairs(tools) do
      local button = CreateFrame("Button", nil, frame.window, "UIPanelButtonTemplate")
      button:SetText(tool.name)
      button:SetWidth(100)
      button:SetPoint("CENTER", (110 * idx), 0)
      button:SetScript("OnClick", tool.fn)
    end
    
    self:UnregisterEvent("ADDON_LOADED")
  end
end)
