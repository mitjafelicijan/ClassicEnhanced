local _, ns = ...

local feature = ns.Register({
  identifier = "GroupFinder",
  description = "Group finder window that parses Looking for Group channels.",
  category = "social",
  frame = nil,
  config = {
    movable = false,
    windowWidth = 420,
    windowHeight = 540,
    listings = {
      -- Dungeons
      { id = "rfc", list = {}, level = "13-16", type = "dungeon", name = "Ragefire Chasm", keywords = {"rfc"} },
      { id = "dm",  list = {}, level = "17-21", type = "dungeon", name = "Deadmines",  keywords = {"dm", "vc"} },
      { id = "wc", list = {}, level = "17-23", type = "dungeon", name = "Wailing Caverns",  keywords = {"wc"} },
      { id = "sfk", list = {}, level = "18-23", type = "dungeon", name = "Shadowfang Keep",  keywords = {"sfk"} },
      { id = "bfd", list = {}, level = "20-27", type = "dungeon", name = "Blackfathom Deeps",  keywords = {"bfd"} },
      { id = "stocks", list = {}, level = "23-30", type = "dungeon", name = "The Stockade",  keywords = {"stocks"} },
      { id = "rfk", list = {}, level = "25-32", type = "dungeon", name = "Razorfen Kraul",  keywords = {"rfk"} },
      { id = "gnomer", list = {}, level = "28-35", type = "dungeon", name = "Gnomeregan",  keywords = {"gnomer", "gnomeregan"} },
      { id = "smg", list = {}, level = "29-35", type = "dungeon", name = "Scarlet Monastery Graveyard",  keywords = {"sm"} },
      { id = "sml", list = {}, level = "31-37", type = "dungeon", name = "Scarlet Monastery Library",  keywords = {"sm"} },
      { id = "smc", list = {}, level = "36-42", type = "dungeon", name = "Scarlet Monastery Cathedral",  keywords = {"sm"} },
      { id = "rfd", list = {}, level = "37-43", type = "dungeon", name = "Razorfen Downs",  keywords = {"rfd"} },
      { id = "ulda", list = {}, level = "41-47", type = "dungeon", name = "Uldaman",  keywords = {"ulda"} },
      { id = "zf", list = {}, level = "44-49", type = "dungeon", name = "Zul'Farrak",  keywords = {"zf"} },
      { id = "mara", list = {}, level = "47-52", type = "dungeon", name = "Maraudon",  keywords = {"mara", "maraudon"} },
      { id = "brd", list = {}, level = "49-53", type = "dungeon", name = "Blackrock Depths",  keywords = {"brd"} },
      { id = "dme", list = {}, level = "55-60", type = "dungeon", name = "Dire Maul",  keywords = {"dme", "dmw", "dmn"} },
      { id = "strat", list = {}, level = "55-60", type = "dungeon", name = "Stratholme",  keywords = {"strat"} },
      { id = "scholo", list = {}, level = "55-60", type = "dungeon", name = "Scholomance",  keywords = {"scholo"} },
      { id = "lbrs", list = {}, level = "55-60", type = "dungeon", name = "Lower Blackrock Spire",  keywords = {"lbrs"} },
      { id = "ubrs", list = {}, level = "55-60", type = "dungeon", name = "Upper Blackrock Spire",  keywords = {"ubrs"} },

      -- Raids
      { id = "st", list = {}, level = "50", type = "raid", name = "Sunken Temple",  keywords = {"sunken"} },
      { id = "mc", list = {}, level = "60", type = "raid", name = "Molten Core",  keywords = {} },
      { id = "ol", list = {}, level = "60", type = "raid", name = "Onyxia's Lair",  keywords = {} },
      { id = "bw", list = {}, level = "60", type = "raid", name = "Blackwing Lair",  keywords = {} },
      { id = "dn", list = {}, level = "60", type = "raid", name = "Dragons of Nightmare",  keywords = {} },
      { id = "zg", list = {}, level = "60", type = "raid", name = "Zul'Gurub",  keywords = {} },
      { id = "raq", list = {}, level = "60", type = "raid", name = "Ruins of Ahn'Qiraj",  keywords = {} },
      { id = "taq", list = {}, level = "60", type = "raid", name = "Temple of Ahn'Qiraj",  keywords = {} },
      { id = "nax", list = {}, level = "60", type = "raid", name = "Naxxramas",  keywords = {} },
    }
  }
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end
  
  if event == "ADDON_LOADED" then
    
    feature.frame.window = CreateFrame("Frame", "MyAddonFrame", UIParent)
    feature.frame.window:SetSize(350, 512)
    feature.frame.window:SetPoint("CENTER", 0, 0)
    feature.frame.window:SetMovable(true)
    feature.frame.window:EnableMouse(true)
    feature.frame.window:RegisterForDrag("LeftButton")
    feature.frame.window:SetScript("OnDragStart", feature.frame.window.StartMoving)
    feature.frame.window:SetScript("OnDragStop", feature.frame.window.StopMovingOrSizing)

    -- Create a texture to hold your background image
    feature.frame.window.background = feature.frame.window:CreateTexture(nil, "BACKGROUND")
    feature.frame.window.background:SetAllPoints(feature.frame.window)
    feature.frame.window.background:SetTexture("Interface\\AddOns\\ClassicEnhanced\\UI\\GroupFinder")
    feature.frame.window.background:SetVertexColor(1, 1, 1, 1)
    feature.frame.window.background:SetTexCoord(0.0, 0.68, 0.0, 1.0)

    -- Add title to the frame.
    local title = feature.frame.window:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetText("Group Finder")
    title:SetPoint("TOP", 20, -18)
    title:SetShadowColor(0, 0, 0, 1)

    -- Create a close button.
    feature.frame.window.close = CreateFrame("Button", nil, feature.frame.window, "UIPanelCloseButton")
    feature.frame.window.close:SetPoint("TOPRIGHT", feature.frame.window, "TOPRIGHT", 6, -8)
    feature.frame.window.close:SetScript("OnClick", function()
        feature.frame.window:Hide()
    end)

    feature.frame.window:Show()

    -- Create the dropdown frame
    feature.frame.window.dropdown = CreateFrame("Frame", "MyDropdown", feature.frame.window, "UIDropDownMenuTemplate")
    feature.frame.window.dropdown:SetPoint("TOPRIGHT", 0, -50)
    feature.frame.window.dropdown:SetSize(230, 40)

    local function InitializeDropdown(self, level)
      local info = UIDropDownMenu_CreateInfo()
      for _, item in ipairs(feature.config.listings) do
        local menuItem = item
        info.text = item.name .. " (" .. item.level .. ")"
        info.checked = item.checked
        info.func = (function(menuItem)
          return function(_, _, _, value)
            menuItem.checked = value
            print("ID:", menuItem.id, menuItem.name, "checked:", menuItem.checked)
          end
        end)(item)
        info.keepShownOnClick = true
        info.isNotRadio = true
        UIDropDownMenu_AddButton(info, level)
      end
    end

    UIDropDownMenu_Initialize(feature.frame.window.dropdown, InitializeDropdown)
    UIDropDownMenu_SetText(feature.frame.window.dropdown, "Dungeons & Raids")
    UIDropDownMenu_SetWidth(feature.frame.window.dropdown, 230)

    feature.frame.window.refresh = CreateFrame("Button", "MyButton", feature.frame.window, "UIPanelButtonTemplate")
    feature.frame.window.refresh:SetText("Refresh")
    feature.frame.window.refresh:SetPoint("BOTTOMLEFT", 17, 17)
    feature.frame.window.refresh:SetSize(123, 17)
    feature.frame.window.refresh:SetScript("OnClick", function()
      print("Selected items:")
      for _, item in ipairs(feature.config.listings) do
        if item.checked then
          print(item.id, item.name)
        end
      end
    end)
    
    -- Register slash command.
    SLASH_TweaksLFG1 = "/lfg"
    SlashCmdList["TweaksLFG"] = function(msg, editbox)
      feature.frame.window:Show()
    end
    
    self:UnregisterEvent("ADDON_LOADED")
  end
end)
