local ADDON_NAME = "Tank Marker"

TankMarker = {}

local function tryGetMarkIndex(input)
    if input == "" then return TankMarker.Marks:DefaultIndex() end

    return TankMarker.Marks:TryGetIndex(input)
end

local function handleBadInput(input)
    local formattedOutput = string.format('%s: Mark "%s" not exists. Check help: /mt help', ADDON_NAME, input)
    print(formattedOutput)
end

local function handleNotInGroup()
    local formattedOutput = string.format('%s: You are not in group', ADDON_NAME)
    print(formattedOutput)
end

local function showHelp()
    local output = string.format('\nUse "/marktank" to set a default mark or "/marktank {mark} to choose a specific one. \n{mark} options:\n%s', TankMarker.Marks:OptionsInfo())
    .. string.format("\n%s: Addon will set a mark on tank or group leader, if there is no tanks in group. In raid it wokrs only if you have rules to set marks.", ADDON_NAME)
    print(output)
end

local function trimSpaces(str)
    return str:match("^%s*(.-)%s*$")
end

local function markTankOrLeader(input)
    if not IsInGroup() and not IsInRaid() then
        handleNotInGroup()
        return
    end

    input = trimSpaces(input)
    local markIndex = tryGetMarkIndex(input)
    if not markIndex then
        handleBadInput(input)
        return
    end

    for i = 0, GetNumSubgroupMembers() do
        local unit = "party" .. i
        if UnitGroupRolesAssigned(unit) == "TANK" then
            SetRaidTarget(unit, markIndex)
            return
        end

        if UnitIsGroupLeader(unit) then
            SetRaidTarget(unit, markIndex)
        end
    end
end

local function isHelpCommand(input)
    local command = "help"
    local startIndex = 1
    local commandLength = #command

    return string.sub(input, startIndex, commandLength) == command
end

local function HandleSlashCommand(input)
    if isHelpCommand(input) then
        showHelp()
        return
    end

    markTankOrLeader(input)
end

SLASH_MT1 = "/marktank"
SlashCmdList["MT"] = HandleSlashCommand
