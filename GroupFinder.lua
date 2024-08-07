local _, ns = ...

local feature = ns.Register({
  identifier = "GroupFinder",
  description = "Group finder window that parses Looking for Group channels |cFFFF0000(Beta)|r.",
  category = "social",
  frame = nil,
  config = {
    movable = true,
    windowWidth = 420,
    windowHeight = 540,
    classColor = {
      ["Warrior"] = {r = 0.78, g = 0.61, b = 0.43 },
      ["Paladin"] = {r = 0.96, g = 0.55, b = 0.73 },
      ["Hunter"]  = {r = 0.67, g = 0.83, b = 0.45 },
      ["Rogue"]   = {r = 1.00, g = 0.96, b = 0.41 },
      ["Priest"]  = {r = 1.00, g = 1.00, b = 1.00 },
      ["Shaman"]  = {r = 0.00, g = 0.44, b = 0.87 },
      ["Mage"]    = {r = 0.25, g = 0.78, b = 0.92 },
      ["Warlock"] = {r = 0.53, g = 0.53, b = 0.93 },
      ["Druid"]   = {r = 1.00, g = 0.49, b = 0.04 },
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
    },
    listingDimension = {
      rowHeight = 35,
      rowSpacer = 3,
    },

    filterGroupType = {
      { key = "lfg", label = "Looking for Group (LFG)" },
      { key = "lfm", label = "Looking for Man (LFM)" },
    },

    filterRole = {
      { key = "tank", label = "Tank" },
      { key = "healer", label = "Healer" },
      { key = "dps", label = "DPS" },
    },
    
    debugMessages = false,    -- prints out debug messages
    autoShow = false,         -- auto shows ui on start
    refreshInterval = 10,     -- refreshing ui every N seconds
    listingLifespan = 120,    -- how long can the oldest listing be in seconds
  },
  data = {
    listings = {},
    refreshTicker = nil,
    precompiledInstances = {},
    unfilteredListings = {},
    filteredListings = {},
  }
})

feature.frame = CreateFrame("Frame")
feature.frame:RegisterEvent("ADDON_LOADED")
feature.frame:RegisterEvent("CHAT_MSG_CHANNEL")

local function createListingFrame(parent, idx, listing)
  -- Create the frame.
  local row = CreateFrame("Frame", "ListingRow" .. idx, parent)
  row:SetSize(parent:GetWidth(), (feature.config.listingDimension.rowHeight-feature.config.listingDimension.rowSpacer))
  row:SetPoint("TOP", 0, -((idx-1) * feature.config.listingDimension.rowHeight))
  row:EnableMouse(true)
  row.data = listing

  -- Right click starts whisper chat.
  row:SetScript("OnMouseUp", function(self, button)
    if button == "RightButton" then
      ChatFrame_SendTell(listing.name)
      ChatEdit_GetActiveWindow():SetFocus()
    end
  end)

  -- Create the background texture.
  local texture = row:CreateTexture(nil, "BACKGROUND")
  texture:SetAllPoints(true)
  texture:SetColorTexture(30/255, 80/255, 160/255, 0.07)
  -- texture:SetColorTexture(0/255, 0/255, 0/255, 0.3)

  -- Tooltip with the original message.
  do
    row.tooltipText = listing.message
    row:SetScript("OnEnter", function(self)
      texture:SetColorTexture(30/255, 80/255, 160/255, 0.3)
      GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
      GameTooltip:SetText(self.tooltipText, 1, 1, 1, 1, true)
      GameTooltip:Show()
    end)

    row:SetScript("OnLeave", function(self)
      texture:SetColorTexture(30/255, 80/255, 160/255, 0.05)
      GameTooltip:Hide()
    end)
  end

  -- Message type (LFG, LFM)
  do
    local icon = row:CreateTexture(nil, "OVERLAY")
    icon:SetSize(32, 32)
    icon:SetPoint("LEFT", 4, 0)
    if listing.lfg then
      icon:SetTexture("Interface\\FriendsFrame\\UI-Toast-FriendRequestIcon")
    else
      icon:SetTexture("Interface\\FriendsFrame\\UI-Toast-ChatInviteIcon")
    end
  end

  -- Name, class and race
  do
    local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    name:SetText(listing.name)
    name:SetPoint("TOPLEFT", 42, -5)

    local nameColor = feature.config.classColor[listing.class]
    name:SetTextColor(nameColor.r, nameColor.g, nameColor.b)
    name:SetShadowColor(0, 0, 0, 1)
    
    local class = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    class:SetText("(" .. listing.race.. " " .. listing.class .. ")")
    class:SetPoint("TOPLEFT", 42 + name:GetWidth() + 5, -6)
    class:SetTextColor(80/255, 80/255, 80/255, 1)
    class:SetShadowColor(0, 0, 0, 1)
    class:SetFont(class:GetFont(), 10)
  end

  -- Instance name
  do
    local instanceName = nil
    for _, item in pairs(feature.config.listings) do
      if listing.instance == item.id then
        instanceName = item.name
        break
      end
    end
    
    local label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetText(instanceName)
    label:SetPoint("TOPLEFT", 42, -18)
    label:SetTextColor(130/255, 130/255, 130/255, 1)
    label:SetShadowColor(0, 0, 0, 1)
    label:SetFont(label:GetFont(), 10)
  end
  
  -- Invite to group button
  do
    local invite = CreateFrame("Button", "InviteToGroupButton" .. idx, row)
    invite:SetText("Invite")
    invite:SetPoint("RIGHT", -2, 0)
    invite:SetSize(20, 32)
    invite.data = listing

    local texture = invite:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints(true)
    texture:SetSize(20, 32)
    texture:SetTexture("Interface\\FriendsFrame\\TravelPass-Invite")
    local left, right, top, bottom = MIA.Texture.calculateCoordinates(64, 128, 3, 34, 23, 66)
    texture:SetTexCoord(left, right, top, bottom)
    
    local textureHover = invite:CreateTexture(nil, "OVERLAY")
    textureHover:SetAllPoints(true)
    textureHover:SetSize(20, 32)
    textureHover:SetTexture("Interface\\FriendsFrame\\TravelPass-Invite")
    local left, right, top, bottom = MIA.Texture.calculateCoordinates(64, 128, 30, 0, 50, 32)
    textureHover:SetTexCoord(left, right, top, bottom)
    textureHover:Hide()

    if listing.lfm then
      texture:SetDesaturated(true)
      texture:SetAlpha(0.3)
    end

    if listing.lfg then
      invite:SetScript("OnEnter", function(self) textureHover:Show() end)
      invite:SetScript("OnLeave", function(self) textureHover:Hide() end)
      invite:SetScript("OnClick", function()
        InviteUnit(listing.name)
      end)
    end
  end

  -- Checking if tank, healer or dps
  do
    local left, right, top, bottom = MIA.Texture.calculateCoordinates(64, 64, 0, 20, 20, 40)
    local icon = row:CreateTexture(nil, "OVERLAY")
    icon:SetSize(20, 20)
    icon:SetPoint("RIGHT", -80, 0)
    icon:SetTexture("Interface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES")
    icon:SetTexCoord(left, right, top, bottom)
    if not listing.tank then
      icon:SetDesaturated(true)
      icon:SetAlpha(0.3)
    end
    
    local left, right, top, bottom = MIA.Texture.calculateCoordinates(64, 64, 20, 0, 40, 20)
    local icon = row:CreateTexture(nil, "OVERLAY")
    icon:SetSize(20, 20)
    icon:SetPoint("RIGHT", -55, -1)
    icon:SetTexture("Interface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES")
    icon:SetTexCoord(left, right, top, bottom)
    if not listing.healer then
      icon:SetDesaturated(true)
      icon:SetAlpha(0.3)
    end
    
    local left, right, top, bottom = MIA.Texture.calculateCoordinates(64, 64, 20, 20, 40, 40)
    local icon = row:CreateTexture(nil, "OVERLAY")
    icon:SetSize(20, 20)
    icon:SetPoint("RIGHT", -30, -1)
    icon:SetTexture("Interface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES")
    icon:SetTexCoord(left, right, top, bottom)
    if not listing.dps then
      icon:SetDesaturated(true)
      icon:SetAlpha(0.3)
    end
  end
end

local function parseMessage(item)
  local obj = {
    lfg = false,
    lfm = false,
    healer = false,
    dps = false,
    tank = false,
    class = item.class,
    name = item.name,
    race = item.race,
    level = item.level,
    message = item.message,
    instance = nil,
  }

  item.message = string.lower(item.message)
  item.message = MIA.String.replace(item.message, "%d+", " ")
  item.message = MIA.String.replace(item.message, "/", " ")
  item.message = MIA.String.replace(item.message, ",", " ")
  item.message = MIA.String.replace(item.message, "%.", " ")
  item.message = MIA.String.replace(item.message, "-", " ")

  -- Tokenizing the message.
  local words = MIA.String.split(item.message, "%S+")

  -- Checking fot LFG and LF/LFM and roles.
  for _, word in pairs(words) do
    if word == "lf" or word == "lfm" then obj.lfm = true end
    if word == "lfg" then obj.lfg = true end
    if word == "tank" then obj.tank = true end
    if word == "heal" or word == "heals" or word == "healer" then obj.healer = true end
    if word == "dps" then obj.dps = true end
  end

  -- Check for instance only if LFG or LFM found.
  if obj.lfg or obj.lfm then
    for _, word in pairs(words) do
      for key, instance in pairs(feature.data.precompiledInstances) do
        if word == key then
          obj.instance = instance
          break
        end
      end
    end
  end

  return obj
end

local function createBasicUIFrame()
  feature.frame.window = CreateFrame("Frame", "GroupFinder", UIParent)
  feature.frame.window:SetSize(512, 512)
  feature.frame.window:SetPoint("CENTER", 0, 0)
  feature.frame.window:SetFrameStrata("HIGH")
  feature.frame.window:SetToplevel(true)

  if feature.config.movable then
    feature.frame.window:SetMovable(true)
    feature.frame.window:EnableMouse(true)
    feature.frame.window:RegisterForDrag("LeftButton")
    feature.frame.window:SetScript("OnDragStart", feature.frame.window.StartMoving)
    feature.frame.window:SetScript("OnDragStop", feature.frame.window.StopMovingOrSizing)
  end

  feature.frame.window:SetScript("OnShow", function(self)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
  end)
  
  feature.frame.window:SetScript("OnHide", function(self)
    PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
  end)
  
  -- Create a texture to hold your background image
  feature.frame.window.background = feature.frame.window:CreateTexture(nil, "BACKGROUND")
  feature.frame.window.background:SetAllPoints(feature.frame.window)
  feature.frame.window.background:SetTexture("Interface\\AddOns\\ClassicEnhanced\\UI\\GroupFinder")
  feature.frame.window.background:SetVertexColor(1, 1, 1, 1)
  feature.frame.window.background:SetTexCoord(0.0, 1.0, 0.0, 1.0)

  -- Add title to the frame.
  local title = feature.frame.window:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  title:SetText("Group Finder")
  title:SetPoint("TOP", 20, -18)
  title:SetShadowColor(0, 0, 0, 1)

  -- Create a close button.
  feature.frame.window.close = CreateFrame("Button", nil, feature.frame.window, "UIPanelCloseButton")
  feature.frame.window.close:SetPoint("TOPRIGHT", feature.frame.window, "TOPRIGHT", 2, -8)
  feature.frame.window.close:SetScript("OnClick", function()
    feature.frame.window:Hide()
  end)

  -- Show the window.
  if not feature.config.autoShow then
    feature.frame.window:Hide()
  end

  -- Create group type filter dropdown frame.
  do
    feature.frame.window.groupTypeFilterDropdown = CreateFrame("Frame", "InstanceDropDown", feature.frame.window, "UIDropDownMenuTemplate")
    feature.frame.window.groupTypeFilterDropdown:SetPoint("TOPRIGHT", -292, -40)
    
    function GetSelectedGroupTypeFilterDropdownItems()
      local items = {}
      for _, item in ipairs(feature.config.filterGroupType) do
        if item.checked then
          tinsert(items, item.key)
        end
      end
      return items
    end

    local function InitializeDropdown(self, level)
      for _, option in pairs(feature.config.filterGroupType) do
        local info = UIDropDownMenu_CreateInfo()
        local menuItem = option
        info.text = option.label
        info.checked = option.checked
        info.keepShownOnClick = true
        info.isNotRadio = true

        info.func = (function(menuItem)
          return function(_, _, _, value)
            menuItem.checked = value
            ns.KVStorage.Set("LFGFilterGroupType", GetSelectedGroupTypeFilterDropdownItems())
          end
        end)(menuItem)
        
        local previousSessionSelection = ns.KVStorage.Get("LFGFilterGroupType")
        if ns.Helpers.TableContainsValue(previousSessionSelection, menuItem.key) then
          info.checked = true
          menuItem.checked = true
        end
        
        UIDropDownMenu_AddButton(info, level)
      end
    end

    UIDropDownMenu_Initialize(feature.frame.window.groupTypeFilterDropdown, InitializeDropdown)
    UIDropDownMenu_SetText(feature.frame.window.groupTypeFilterDropdown, "Group type")
    UIDropDownMenu_SetWidth(feature.frame.window.groupTypeFilterDropdown, 100)
  end

  -- Create roles filter dropdown frame.
  do
    feature.frame.window.roleFilterDropdown = CreateFrame("Frame", "InstanceDropDown", feature.frame.window, "UIDropDownMenuTemplate")
    feature.frame.window.roleFilterDropdown:SetPoint("TOPRIGHT", -172, -40)
    
    function GetSelectedRoleFilterDropdownItems()
      local items = {}
      for _, item in ipairs(feature.config.filterRole) do
        if item.checked then
          tinsert(items, item.key)
        end
      end
      return items
    end

    local function InitializeDropdown(self, level)
      for _, option in pairs(feature.config.filterRole) do
        local info = UIDropDownMenu_CreateInfo()
        local menuItem = option
        info.text = option.label
        info.checked = option.checked
        info.keepShownOnClick = true
        info.isNotRadio = true

        info.func = (function(menuItem)
          return function(_, _, _, value)
            menuItem.checked = value
            ns.KVStorage.Set("LFGFilterRole", GetSelectedRoleFilterDropdownItems())
          end
        end)(menuItem)

        local previousSessionSelection = ns.KVStorage.Get("LFGFilterRole")
        if ns.Helpers.TableContainsValue(previousSessionSelection, menuItem.key) then
          info.checked = true
          menuItem.checked = true
        end
        
        UIDropDownMenu_AddButton(info, level)
      end
    end

    UIDropDownMenu_Initialize(feature.frame.window.roleFilterDropdown, InitializeDropdown)
    UIDropDownMenu_SetText(feature.frame.window.roleFilterDropdown, "Role type")
    UIDropDownMenu_SetWidth(feature.frame.window.roleFilterDropdown, 100)
  end

  -- Create instance dropdown frame.
  do
    feature.frame.window.instanceDropdown = CreateFrame("Frame", "InstanceDropDown", feature.frame.window, "UIDropDownMenuTemplate")
    feature.frame.window.instanceDropdown:SetPoint("TOPRIGHT", 8, -40)

    function GetSelectedInstanceDropdownItems()
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
      title.notCheckable = true
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
              ns.KVStorage.Set("LFGSelected", GetSelectedInstanceDropdownItems())
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
      title.notCheckable = true
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
              ns.KVStorage.Set("LFGSelected", GetSelectedInstanceDropdownItems())
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

    UIDropDownMenu_Initialize(feature.frame.window.instanceDropdown, InitializeDropdown)
    UIDropDownMenu_SetText(feature.frame.window.instanceDropdown, "Dungeons & Raids")
    UIDropDownMenu_SetWidth(feature.frame.window.instanceDropdown, 160)
  end
  
  -- Create scrolling frame.
  feature.frame.window.scrollFrame = CreateFrame("ScrollFrame", nil, feature.frame.window, "UIPanelScrollFrameTemplate")
  feature.frame.window.scrollFrame:SetPoint("TOPLEFT", feature.frame.window, "TOPLEFT", 20, -78)
  feature.frame.window.scrollFrame:SetPoint("BOTTOMRIGHT", feature.frame.window, "BOTTOMRIGHT", -35, 15)

  feature.frame.window.scrollFrame.child = CreateFrame("Frame", nil, feature.frame.window.scrollFrame)
  feature.frame.window.scrollFrame.child:SetSize(feature.frame.window.scrollFrame:GetWidth(), feature.frame.window.scrollFrame:GetHeight() - 30)
  feature.frame.window.scrollFrame:SetScrollChild(feature.frame.window.scrollFrame.child)
  
  -- Add minimap button
  do
    local minimapButton = CreateFrame("Button", nil, Minimap)
    minimapButton:SetSize(32, 32)
    minimapButton:SetFrameStrata("MEDIUM")
    minimapButton:SetPoint("LEFT", Minimap, "LEFT", -22, 12)
    minimapButton:SetNormalTexture("Interface\\Addons\\ClassicEnhanced\\UI\\MinimapButton")
    minimapButton:SetHighlightTexture("Interface\\Addons\\ClassicEnhanced\\UI\\MinimapButton")
    minimapButton:GetHighlightTexture():SetBlendMode("ADD")
    minimapButton:GetHighlightTexture():SetVertexColor(0.2, 0.2, 0.2)

    minimapButton:SetScript("OnMouseDown", function(self)
      self:SetNormalTexture("Interface\\Addons\\ClassicEnhanced\\UI\\MinimapButtonHover")
    end)

    minimapButton:SetScript("OnMouseUp", function(self)
      self:SetNormalTexture("Interface\\Addons\\ClassicEnhanced\\UI\\MinimapButton")
    end)
    
    minimapButton:SetScript("OnClick", function(self)
      if feature.frame.window:IsShown() then
        feature.frame.window:Hide()
      else
        feature.frame.window:Show()
      end
    end)
  end

end

feature.frame:SetScript("OnEvent", function(self, event, ...)
  if not ns.IsEnabled(feature.identifier) then return end
  
  if event == "ADDON_LOADED" then    
    for _, instance in pairs(feature.config.listings) do
      for _, keyword in pairs(instance.keywords) do
        feature.data.precompiledInstances[keyword] = instance.id
      end
    end

    createBasicUIFrame()

    -- Filters messages and creates frames in UI.
    feature.data.refreshTicker = C_Timer.NewTicker(feature.config.refreshInterval, function()
      feature.data.filteredListings = {}

      -- Remove older unfilter listings.
      for idx, item in pairs(feature.data.unfilteredListings) do
        if item.created < (time() - feature.config.listingLifespan )then
          table.remove(feature.data.unfilteredListings, idx)
        end
      end
      
      local selectedInstances = GetSelectedInstanceDropdownItems()
      local filterGroupType = GetSelectedGroupTypeFilterDropdownItems()
      local filterRoleType = GetSelectedRoleFilterDropdownItems()

      -- Filter out only ones that are valid.
      -- Only allow one listing per user per instance.
      for idx, item in pairs(feature.data.unfilteredListings) do
        local message = parseMessage(item)
        if (message.lfg or message.lfm) and message.instance then
          -- Check for selected instanced.
          local instanceApproved = false
          for _, l in pairs(selectedInstances) do
            if message.instance == l then
              instanceApproved = true
            end
          end

          -- local obj = {
          --   lfg = false,
          --   lfm = false,
          --   healer = false,
          --   dps = false,
          --   tank = false,
          --   class = item.class,
          --   name = item.name,
          --   race = item.race,
          --   level = item.level,
          --   message = item.message,
          --   instance = nil,
          -- }gg

          if feature.config.debugMessages then
            print(message.instance, message.name, message.race, message.class, message.lfg, message.lfm, message.tank, message.healer, message.dps)
          end

          if instanceApproved then
            -- Check for group type filter.
            local breakOut = 0
            for _, e in pairs(filterGroupType) do
              if e == "lfg" and not message.lfg then breakOut = breakOut + 1 end
              if e == "lfm" and not message.lfm then breakOut = breakOut + 1 end
            end
            if breakOut == 2 then break end

            -- TODO: Check for role type filter.
            local filterRoleTypeApproved = false

            -- Add to filtered listing which are displayed in UI.
            table.insert(feature.data.filteredListings, message)
          end
        end
      end
      
      -- Removing old UI listing frames.
      -- FIXME: Fix this since it's a memory hog. Reuse frames in the future.
      for i = 1, 300 do
        if _G["ListingRow"..i] then
          _G["ListingRow"..i]:Hide()
          _G["ListingRow"..i] = nil
        end
      end

      -- Adding filtered listings to UI.
      for j, l in pairs(feature.data.filteredListings) do
        createListingFrame(feature.frame.window.scrollFrame.child, j, l)
      end

      if feature.config.debugMessages then
        print("Unfiltered:", #feature.data.unfilteredListings)
        print("Filtered:", #feature.data.filteredListings)
      end
    end)
  
    -- Register slash command.
    SLASH_TweaksLFG1 = "/lfg"
    SlashCmdList["TweaksLFG"] = function(msg, editbox)
      feature.frame.window:Show()
    end
    
    self:UnregisterEvent("ADDON_LOADED")
  end

  -- Parsing chat messages
  if event == "CHAT_MSG_CHANNEL" then
    local text, playerName, _, _, playerName2, _, _, channelIndex, channelBaseName, _, lineID, guid, _, _, _, _, _ = ...
    if channelBaseName == "LookingForGroup" then
      local class, _, race, _, _, name, realm = GetPlayerInfoByGUID(guid)
      table.insert(feature.data.unfilteredListings, {
        class = class,
        name = name,
        race = race,
        level = 0,
        message = text,
        created = time()
      })
    end
  end
end)
