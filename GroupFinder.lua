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
    classColor = {
      ["Warrior"] = "ffc79c6e",
      ["Paladin"] = "fff58cba",
      ["Hunter"] = "ffabd473",
      ["Rogue"] = "fffff569",
      ["Priest"] = "ffffffff",
      ["Shaman"] = "fff58cba",
      ["Mage"] = "ff69ccf0",
      ["Warlock"] = "ff9482c9",
      ["Druid"] = "ffff7d0a",
    },
    listings = {
      -- Dungeons
      { id = "ragefire-chasm", list = {}, level = "13-16", type = "dungeon", name = "Ragefire Chasm", keywords = {"rfc", "ragefire", "chasm"} },
      { id = "deadmines", list = {}, level = "17-21", type = "dungeon", name = "Deadmines",  keywords = {"deadmines", "vc"} },
      { id = "wailing-caverns", list = {}, level = "17-23", type = "dungeon", name = "Wailing Caverns",  keywords = {"wc", "wailing"} },
      { id = "shadowfang-keep", list = {}, level = "18-23", type = "dungeon", name = "Shadowfang Keep",  keywords = {"sfk", "arugal", "shadowfang"} },
      { id = "blackfathom-deeps", list = {}, level = "20-27", type = "dungeon", name = "Blackfathom Deeps",  keywords = {"bfd", "blackfathom", "deeps"} },
      { id = "the-stockade", list = {}, level = "23-30", type = "dungeon", name = "The Stockade",  keywords = {"stocks", "stockades"} },
      { id = "razorfen-kraul", list = {}, level = "25-32", type = "dungeon", name = "Razorfen Kraul",  keywords = {"rfk", "kraul"} },
      { id = "gnomeregan", list = {}, level = "28-35", type = "dungeon", name = "Gnomeregan",  keywords = {"gnomer", "gnomeregan"} },
      { id = "scarlet-monastery-graveyard", list = {}, level = "29-35", type = "dungeon", name = "Scarlet Monastery Graveyard",  keywords = {"sm", "gy"} },
      { id = "scarlet-monastery-library", list = {}, level = "31-37", type = "dungeon", name = "Scarlet Monastery Library",  keywords = {"sm", "lib"} },
      { id = "scarlet-monastery-cathedral", list = {}, level = "36-42", type = "dungeon", name = "Scarlet Monastery Cathedral",  keywords = {"sm", "cath"} },
      { id = "razorfen-downs", list = {}, level = "37-43", type = "dungeon", name = "Razorfen Downs",  keywords = {"rfd", "downs"} },
      { id = "uldaman", list = {}, level = "41-47", type = "dungeon", name = "Uldaman",  keywords = {"ulda", "uld", "uldman", "uldaman"} },
      { id = "zul-farrak", list = {}, level = "44-49", type = "dungeon", name = "Zul'Farrak",  keywords = {"zf", "farrak", "zulfarrak"} },
      { id = "maraudon", list = {}, level = "47-52", type = "dungeon", name = "Maraudon",  keywords = {"mara", "maraudon", "purple", "orange", "inner", "wicked", "grotto", "foulspore"} },
      { id = "blackrock-depths", list = {}, level = "49-53", type = "dungeon", name = "Blackrock Depths",  keywords = {"brd"} },
      { id = "dire-maul", list = {}, level = "55-60", type = "dungeon", name = "Dire Maul",  keywords = {"dme", "dmw", "dmn"} },
      { id = "stratholme", list = {}, level = "55-60", type = "dungeon", name = "Stratholme",  keywords = {"strat"} },
      { id = "scholomance", list = {}, level = "55-60", type = "dungeon", name = "Scholomance",  keywords = {"scholo"} },
      { id = "lower-blackrock-spire", list = {}, level = "55-60", type = "dungeon", name = "Lower Blackrock Spire",  keywords = {"lbrs"} },
      { id = "upper-blackrock-spire", list = {}, level = "55-60", type = "dungeon", name = "Upper Blackrock Spire",  keywords = {"ubrs"} },
      -- Raids
      { id = "sunken-temple", list = {}, level = "50", type = "raid", name = "Sunken Temple",  keywords = {"sunken"} },
      { id = "molten-core", list = {}, level = "60", type = "raid", name = "Molten Core",  keywords = {"mc"} },
      { id = "onyxias-lair", list = {}, level = "60", type = "raid", name = "Onyxia's Lair",  keywords = {"onyxia"} },
      { id = "blackwing-lair", list = {}, level = "60", type = "raid", name = "Blackwing Lair",  keywords = {"blackwing"} },
      { id = "dragons-of-nightmare", list = {}, level = "60", type = "raid", name = "Dragons of Nightmare",  keywords = {"dragons"} },
      { id = "zul-gurub", list = {}, level = "60", type = "raid", name = "Zul'Gurub",  keywords = {"zg"} },
      { id = "ruins-of-ahn-qiraj", list = {}, level = "60", type = "raid", name = "Ruins of Ahn'Qiraj",  keywords = {"aq", "ruins"} },
      { id = "temple-of-ahn-qiraj", list = {}, level = "60", type = "raid", name = "Temple of Ahn'Qiraj",  keywords = {"aq", "temple"} },
      { id = "naxxramas", list = {}, level = "60", type = "raid", name = "Naxxramas",  keywords = {"naxx"} },
    }
  }
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")

feature.frame:SetScript("OnEvent", function(self, event)
  if not ns.IsEnabled(feature.identifier) then return end
  
  if event == "ADDON_LOADED" then
    
    feature.frame.window = CreateFrame("Frame", "GroupFinder", UIParent)
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
    feature.frame.window.dropdown = CreateFrame("Frame", "InstanceDropDown", feature.frame.window, "UIDropDownMenuTemplate")
    feature.frame.window.dropdown:SetPoint("TOPRIGHT", 0, -50)
    feature.frame.window.dropdown:SetSize(230, 40)

    local function GetSelectedDropdownItems()
      local items = {}
      for _, item in ipairs(feature.config.listings) do
        if item.checked then
          tinsert(items, item.id)
        end
      end
      return items
    end

    local function InitializeDropdown(self, level)
      -- Dungeons
      local title = UIDropDownMenu_CreateInfo()
      title.text = "Dungeons"
      title.isTitle = true
      UIDropDownMenu_AddButton(title, level)
 
      for _, item in ipairs(feature.config.listings) do
        if item.type == "dungeon" then
          local info = UIDropDownMenu_CreateInfo()
          local menuItem = item
          info.text = item.name .. " (" .. item.level .. ")"
          info.checked = item.checked
          info.keepShownOnClick = true
          info.isNotRadio = true

          info.func = (function(menuItem)
            return function(_, _, _, value)
              menuItem.checked = value
              ns.KVStorage.Set("LFGSelected", GetSelectedDropdownItems())
            end
          end)(item)

          local previousSessionSelection = ns.KVStorage.Get("LFGSelected")
          if ns.Helpers.TableContainsValue(previousSessionSelection, item.id) then
            info.checked = true
            item.checked = true
          end

          UIDropDownMenu_AddButton(info, level)
        end
      end
      
      -- Raids
      local title = UIDropDownMenu_CreateInfo()
      title.text = "Raids"
      title.isTitle = true
      UIDropDownMenu_AddButton(title, level)
 
      for _, item in ipairs(feature.config.listings) do
        if item.type == "raid" then
          local info = UIDropDownMenu_CreateInfo()
          local menuItem = item
          info.text = item.name .. " (" .. item.level .. ")"
          info.checked = item.checked
          info.keepShownOnClick = true
          info.isNotRadio = true

          info.func = (function(menuItem)
            return function(_, _, _, value)
              menuItem.checked = value
              ns.KVStorage.Set("LFGSelected", GetSelectedDropdownItems())
            end
          end)(item)

          local previousSessionSelection = ns.KVStorage.Get("LFGSelected")
          if ns.Helpers.TableContainsValue(previousSessionSelection, item.id) then
            info.checked = true
            item.checked = true
          end

          UIDropDownMenu_AddButton(info, level)
        end
      end
    end

    UIDropDownMenu_Initialize(feature.frame.window.dropdown, InitializeDropdown)
    UIDropDownMenu_SetText(feature.frame.window.dropdown, "Dungeons & Raids")
    UIDropDownMenu_SetWidth(feature.frame.window.dropdown, 230)

    feature.frame.window.refresh = CreateFrame("Button", "RefreshButton", feature.frame.window, "UIPanelButtonTemplate")
    feature.frame.window.refresh:SetText("Refresh")
    feature.frame.window.refresh:SetPoint("BOTTOMLEFT", 17, 17)
    feature.frame.window.refresh:SetSize(123, 17)
    feature.frame.window.refresh:SetScript("OnClick", function()
      print("selected:")
      for _, id in pairs(GetSelectedDropdownItems()) do
        print(" - " .. id)
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
