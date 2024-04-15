-- MIA is a simple library (Missing In Action) tha has some helper functions
-- that come in handy when developing WoW addons.

MIA = {}

MIA.String = {}

function MIA.String.replace(str, pattern, replacement)
  return str:gsub(pattern, replacement)
end

function MIA.String.split(str, pattern, variance)
  local words = {}
  for substring in str:gmatch(pattern) do
    table.insert(words, substring)
  end
  return words
end

function MIA.String.trim(str)
	return (str:gsub("^%s*(.-)%s*$", "%1"))
end

MIA.Texture = {}

function MIA.Texture.calculateCoordinates(textureWidth, textureHeight, x1, y1, x2, y2)
  local left = x1 / textureWidth
  local right = x2 / textureWidth
  local top = y1 / textureHeight
  local bottom = y2 / textureHeight
  return left, right, top, bottom
end

function MIA.Texture.placeholder(parent)
  local texture = parent:CreateTexture(nil, "BACKGROUND")
  texture:SetAllPoints(true)
  texture:SetColorTexture(255/255, 0/255, 0/255, 0.3)
end

MIA.Table = {}

function MIA.Table.getRange(tbl, startIndex, endIndex)
  local range = {}
  for i = startIndex, endIndex do
    range[#range + 1] = tbl[i]
  end
  return range
end
