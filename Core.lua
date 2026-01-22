-- Peninsula Boss Addon
local addonName, addonTable = ...

-- Boss database for WotLK instances
local bossData = {
    -- Naxxramas
    ["Naxxramas"] = {
        "Anub'Rekhan", "Grand Widow Faerlina", "Maexxna",
        "Noth the Plaguebringer", "Heigan the Unclean", "Loatheb",
        "Instructor Razuvious", "Gothik the Harvester", "The Four Horsemen",
        "Patchwerk", "Grobbulus", "Gluth", "Thaddius",
        "Sapphiron", "Kel'Thuzad"
    },
    -- Ulduar
    ["Ulduar"] = {
        "Flame Leviathan", "Ignis the Furnace Master", "Razorscale", "XT-002 Deconstructor",
        "The Assembly of Iron", "Kologarn", "Auriaya", "Hodir", "Thorim", "Freya", "Mimiron",
        "General Vezax", "Yogg-Saron", "Algalon the Observer"
    },
    -- Trial of the Crusader
    ["Trial of the Crusader"] = {
        "The Beasts of Northrend", "Lord Jaraxxus", "Faction Champions",
        "Twin Val'kyr", "Anub'arak"
    },
    -- Icecrown Citadel
    ["Icecrown Citadel"] = {
        "Lord Marrowgar", "Lady Deathwhisper", "Gunship Battle", "Deathbringer Saurfang",
        "Festergut", "Rotface", "Professor Putricide",
        "Blood Prince Council", "Blood-Queen Lana'thel", "Valithria Dreamwalker", "Sindragosa",
        "The Lich King"
    },
    -- Ruby Sanctum
    ["The Ruby Sanctum"] = {
        "Halion"
    },
    -- Obsidian Sanctum
    ["The Obsidian Sanctum"] = {
        "Sartharion"
    },
    -- Eye of Eternity
    ["The Eye of Eternity"] = {
        "Malygos"
    },
    -- Vault of Archavon
    ["Vault of Archavon"] = {
        "Archavon the Stone Watcher", "Emalon the Storm Watcher",
        "Koralon the Flame Watcher", "Toravon the Ice Watcher"
    },
    -- 5-man dungeons
    ["Utgarde Keep"] = {
        "Prince Keleseth", "Skarvald & Dalronn", "Ingvar the Plunderer"
    },
    ["The Nexus"] = {
        "Grand Magus Telestra", "Anomalus", "Ormorok the Tree-Shaper", "Keristrasza"
    },
    ["Azjol-Nerub"] = {
        "Krik'thir the Gatewatcher", "Hadronox", "Anub'arak"
    },
    ["Ahn'kahet: The Old Kingdom"] = {
        "Elder Nadox", "Prince Taldaram", "Jedoga Shadowseeker", "Herald Volazj"
    },
    ["Drak'Tharon Keep"] = {
        "Trollgore", "Novos the Summoner", "King Dred", "The Prophet Tharon'ja"
    },
    ["The Violet Hold"] = {
        "Erekem", "Moragg", "Ichoron", "Xevozz", "Lavanthor", "Zuramat the Obliterator", "Cyanigosa"
    },
    ["Gundrak"] = {
        "Slad'ran", "Drakkari Colossus", "Moorabi", "Eck the Ferocious", "Gal'darah"
    },
    ["Halls of Stone"] = {
        "Krystallus", "Maiden of Grief", "Tribunal of Ages", "Sjonnir the Ironshaper"
    },
    ["Halls of Lightning"] = {
        "General Bjarngrim", "Volkhan", "Ionar", "Loken"
    },
    ["The Oculus"] = {
        "Drakos the Interrogator", "Varos Cloudstrider", "Mage-Lord Urom", "Ley-Guardian Eregos"
    },
    ["Utgarde Pinnacle"] = {
        "Svala Sorrowgrave", "Gortok Palehoof", "Skadi the Ruthless", "King Ymiron"
    },
    ["The Culling of Stratholme"] = {
        "Meathook", "Salramm the Fleshcrafter", "Chrono-Lord Epoch", "Mal'Ganis"
    },
    ["Trial of the Champion"] = {
        "Grand Champions", "Eadric the Pure / Argent Confessor Paletress", "The Black Knight"
    },
    ["The Forge of Souls"] = {
        "Bronjahm", "Devourer of Souls"
    },
    ["Pit of Saron"] = {
        "Forgemaster Garfrost", "Ick & Krick", "Scourgelord Tyrannus"
    },
    ["Halls of Reflection"] = {
        "Falric", "Marwyn", "Escape from Arthas"
    }
}

-- Create main frame
local frame = CreateFrame("Frame", "PeninsulaBossFrame", UIParent)
frame:SetSize(200, 300)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
frame:SetBackdropColor(0, 0, 0, 0.8)

-- Create title
local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", frame, "TOP", 0, -15)
title:SetText("Peninsula Boss")

-- Create close button
local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
closeButton:SetScript("OnClick", function()
    frame:Hide()
end)

-- Make frame movable
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

-- Function to get current instance
local function GetCurrentInstance()
    local inInstance, instanceType = IsInInstance()
    if not inInstance then
        return nil
    end
    
    local name = GetInstanceInfo()
    return name, instanceType
end

-- Create scroll frame for boss list
local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -45)
scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 15)

local content = CreateFrame("Frame", nil, scrollFrame)
content:SetSize(165, 1)
scrollFrame:SetScrollChild(content)

-- Store boss text labels
local bossLabels = {}

-- Function to update boss list
local function UpdateBossList()
    -- Clear previous labels
    for _, label in ipairs(bossLabels) do
        label:Hide()
        label:SetText("")
    end
    
    local instanceName = GetCurrentInstance()
    if not instanceName or not bossData[instanceName] then
        -- No instance or no data
        if #bossLabels == 0 then
            local label = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            label:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
            table.insert(bossLabels, label)
        end
        bossLabels[1]:SetText("Not in a known instance")
        bossLabels[1]:Show()
        return
    end
    
    local bosses = bossData[instanceName]
    local yOffset = 0
    
    for i, bossName in ipairs(bosses) do
        if not bossLabels[i] then
            local label = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            label:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -yOffset)
            table.insert(bossLabels, label)
        else
            bossLabels[i]:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -yOffset)
        end
        
        bossLabels[i]:SetText(i .. ". " .. bossName)
        bossLabels[i]:Show()
        yOffset = yOffset + 15
    end
    
    content:SetHeight(math.max(yOffset, 1))
end

-- Update on zone change
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
    UpdateBossList()
end)

-- Initial update
UpdateBossList()

-- Slash command to toggle frame
SLASH_PENINSULABOSS1 = "/pboss"
SLASH_PENINSULABOSS2 = "/peninsulaboss"
SlashCmdList["PENINSULABOSS"] = function(msg)
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
        UpdateBossList()
    end
end

frame:Show()
