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

frame:Show()
