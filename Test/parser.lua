local NonStd = {}

NonStd.String = {}

function NonStd.String.replace(str, pattern, replacement)
  return str:gsub(pattern, replacement)
end

function NonStd.String.split(str, pattern, variance)
  local words = {}
  for substring in str:gmatch(pattern) do
    table.insert(words, substring)
  end
  return words
end

function NonStd.String.trim(str)
	return (str:gsub("^%s*(.-)%s*$", "%1"))
end

-- Including test data from LFG group chat.
require("data1")
local messages = LFGChatDB

local feature = {
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
}

local precompiledInstances = {}
for _, instance in pairs(feature.config.listings) do
  for _, keyword in pairs(instance.keywords) do
    precompiledInstances[keyword] = instance.id
  end
end

local function parseMessage(item)
  local obj = {
    lfg = false,
    lfm = false,
    healer = false,
    dps = false,
    tank = false,
    instance = nil,
    message = nil,
  }

  item.message = string.lower(item.message)
  item.message = NonStd.String.replace(item.message, "%d+", " ")
  item.message = NonStd.String.replace(item.message, "/", " ")
  item.message = NonStd.String.replace(item.message, ",", " ")
  item.message = NonStd.String.replace(item.message, "-", " ")

  obj.message = item.message

  -- Tokenizing the message.
  local words = NonStd.String.split(item.message, "%S+")

  -- Checking fot LFG and LF/LFM and roles.
  for _, word in pairs(words) do
    if word == "lf" or word == "lfm" then obj.lfm = true end
    if word == "lfg" then obj.lfg = true end

    if word == "tank" then obj.tank = true end
    if word == "heals" or word == "healer" then obj.healer = true end
    if word == "dps" then obj.dps = true end
  end

  -- Check for instance only if LFG or LFM found.
  if obj.lfg or obj.lfm then
    for _, word in pairs(words) do
      for key, instance in pairs(precompiledInstances) do
        if word == key then
          obj.instance = instance
          break
        end
      end
    end
  end
  
  return obj
end

-- Loop through all the messages
local validListings = {}
for _, message in pairs(messages) do
  local res = parseMessage(message)
  if res and res.lfg or res.lfm and res.instance then
    table.insert(validListings, res)
  end
end

for _, message in pairs(validListings) do
  print(message.lfg, message.lfm, message.tank, message.healer, message.dps, message.instance, message.message)
end

print("All:", #messages)
print("Valid:", #validListings)
