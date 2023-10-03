local marks = {}

local marksByForm = {
    ["star"] = 1,
    ["circle"] = 2,
    ["diamond"] = 3,
    ["triangle"] = 4,
    ["moon"] = 5,
    ["square"] = 6,
    ["cross"] = 7,
    ["skull"] = 8
}

local marksByColor = {
    ["yellow"] = 1,
    ["orange"] = 2,
    ["purple"] = 3,
    ["green"] = 4,
    ["blue"] = 6, -- 5 mark is skipped because it is white as 8
    ["red"] = 7,
    ["white"] = 8
}

local default = marksByColor["blue"]

function marks:TryGetIndex(name)
    return marksByForm[name] or marksByColor[name] or nil
end

function marks:DefaultIndex()
    return default
end

local function chatIcon(index)
    return string.format("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t", index)
end

function marks:OptionsInfo()
  return  string.format("%s: star or yellow", chatIcon(marksByForm["star"]))
  .. string.format("\n%s: circle or orange", chatIcon(marksByForm["circle"]))
  .. string.format("\n%s: diamond or purple", chatIcon(marksByForm["diamond"]))
  .. string.format("\n%s: triangle or green", chatIcon(marksByForm["triangle"]))
  .. string.format("\n%s: moon", chatIcon(marksByForm["moon"]))
  .. string.format("\n%s: square or blue", chatIcon(marksByForm["square"]))
  .. string.format("\n%s: cross or red", chatIcon(marksByForm["cross"]))
  .. string.format("\n%s: skull or white", chatIcon(marksByForm["skull"]))
  .. string.format("\nDefault mark: %s", chatIcon(default))
end

TankMarker.Marks = marks
return marks