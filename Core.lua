-- Peninsula Boss Addon
local addonName, addonTable = ...

-- Boss database for Vanilla, TBC and WotLK instances
local bossData = {
    -- ==================
    -- VANILLA RAIDS
    -- ==================
    ["Cœur du Magma"] = {
        "Lucifron", "Magmadar", "Gehennas", "Garr", "Shazzrah", "Baron Geddon",
        "Messager de Sulfuron", "Golemagg l'Incinérateur", "Chambellan Executus", "Ragnaros"
    },
    ["Repaire de l'Aile noire"] = {
        "Tranchetripe l'Indompté", "Vaelastrasz le Corrompu", "Seigneur des Couvées Lashlayer",
        "Gueule-de-feu", "Rochébène", "Flamegor", "Chromaggus", "Nefarian"
    },
    ["Ruines d'Ahn'Qiraj"] = {
        "Kurinnaxx", "Général Rajaxx", "Moam", "Buru Brise-os", "Ayamiss le Chasseur", "Ossirian l'Inaltéré"
    },
    ["Temple d'Ahn'Qiraj"] = {
        "Le Prophète Skeram", "Royauté silithide", "Garde de combat Sartura", "Fankriss l'Inflexible",
        "Viscidus", "Princesse Huhuran", "Empereurs jumeaux", "Ouro", "C'Thun"
    },
    ["Zul'Gurub"] = {
        "Grande prêtresse Jeklik", "Grand prêtre Venoxis", "Grande prêtresse Mar'li", "Seigneur sanglant Mandokir",
        "Gri'lek", "Hazza'rah", "Renataki", "Wushoolay", "Gahz'ranka",
        "Grand prêtre Thekal", "Grande prêtresse Arlokk", "Jin'do le Malsort", "Hakkar"
    },
    ["Repaire d'Onyxia"] = {
        "Onyxia"
    },
    
    -- ==================
    -- VANILLA DUNGEONS
    -- ==================
    ["Stratholme"] = {
        "L'Impitoyable", "Hearthsinger Forresten", "Timmy le Cruel", "Commandant Malor",
        "Willey Hopebreaker", "Instructeur Galford", "Balnazzar", "Baronne Anastari",
        "Nerub'enkan", "Maleki le Blafard", "Magistrat Barthilas", "Ramstein le Dévoreur",
        "Baron Vaillefendre"
    },
    ["Scholomance"] = {
        "Kirtonos le Héraut", "Jandice Barov", "Cliquettripes", "Marduk Blackpool",
        "Vectus", "Ras Murmegivre", "Instructeur Malicia", "Docteur Theolen Krastinov",
        "Gardien du savoir Polkelt", "Le Plamortin", "Seigneur Alexei Barov", "Dame Illucia Barov", "Sombre Maître Gandling"
    },
    ["Profondeurs de Blackrock"] = {
        "Seigneur Roccor", "Grand Inquisiteur Gerstahn", "Maître-chien Grebmar", "Cercle de la Loi",
        "Pyromancien Loregrain", "Seigneur Incendius", "Fineous Sombrevire", "Bael'Gar",
        "Général Forgehargne", "Seigneur golem Argelmach", "Hurley Souffle-noire", "Phalanx",
        "Plugger Spazzring", "Ambassadeur Flamelash", "Les Sept", "Magmus", "Empereur Dagran Thaurissan"
    },
    ["Pic Blackrock"] = {
        "Seigneur Omokk", "Chasseur des ombres Vosh'gajin", "Maître de guerre Voone", "Mère Smolderweb",
        "Urok Doomhowl", "Intendant Zigris", "Halycon", "Gizrul l'Asservisseur",
        "Seigneur Wyrmthalak", "Pyroguard Braise-oracle", "Solakar Couronne-de-flammes", "Jed Runewatcher",
        "Goraluk Anvilcrack", "Chef de guerre Rend Blackhand", "Gyth", "La Bête", "Général Drakkisath"
    },
    ["Hache-tripes"] = {
        "Zevrim Sabot-de-ronce", "Hydrospawn", "Lethtendris", "Alzzin le Modeleur",
        "Tendris Crochebois", "Illyanna Ravenoak", "Magistère Kalendris", "Immol'thar",
        "Prince Tortheldrin", "Garde Mol'dar", "Stomper Kreeg", "Garde Fengus",
        "Garde Slip'kik", "Capitaine Kromcrush", "Cho'Rush l'Observateur", "Roi Gordok"
    },
    
    -- ==================
    -- THE BURNING CRUSADE RAIDS
    -- ==================
    ["Karazhan"] = {
        "Attumen le Veneur", "Moroes", "Damoiselle de vertu", "Evénement de l'Opéra", "Le Conservateur",
        "Ombre d'Aran", "Terestian Malsabot", "Gangr'esprit", "Evénement des échecs", "Prince Malchezaar", "Plaie-Nocturne"
    },
    ["Repaire de Gruul"] = {
        "Haut Roi Maulgar", "Gruul le Tue-dragon"
    },
    ["Repaire de Magtheridon"] = {
        "Magtheridon"
    },
    ["Caverne du sanctuaire du Serpent"] = {
        "Hydross l'Instable", "Lurker d'en-bas", "Leotheras l'Aveugle",
        "Seigneur des fonds Karathress", "Morogrim Marcheur-des-flots", "Dame Vashj"
    },
    ["Donjon de la Tempête"] = {
        "Al'ar", "Saccageur du Vide", "Grande astromancienne Solarian", "Kael'thas Haut-soleil"
    },
    ["Sommet d'Hyjal"] = {
        "Rage Froidhiver", "Anetheron", "Kaz'rogal", "Azgalor", "Archimonde"
    },
    ["Temple Noir"] = {
        "Seigneur de guerre Naj'entus", "Supremus", "Ombre d'Akama", "Teron Fielsang",
        "Gurtogg Fièvresang", "Reliquaire des âmes", "Mère Shahraz", "Conseil illidari", "Illidan Hurlorage"
    },
    ["Zul'Aman"] = {
        "Nalorakk", "Akil'zon", "Jan'alai", "Halazzi", "Seigneur des maléfices Malacrass", "Zul'jin"
    },
    ["Plateau du Puits de soleil"] = {
        "Kalecgos", "Brutallus", "Gangrébru", "Jumelles érédars", "M'uru", "Kil'jaeden"
    },
    
    -- ==================
    -- THE BURNING CRUSADE DUNGEONS
    -- ==================
    ["Remparts des Flammes infernales"] = {
        "Gardien de guerre Gargolmar", "Omor le Balafré", "Vazruden et Nazan"
    },
    ["La Fournaise du sang"] = {
        "Le Faiseur", "Broggok", "Keli'dan le Briseur"
    },
    ["Les enclos aux esclaves"] = {
        "Mennu le Traître", "Rokmar le Crépitant", "Quagmirran"
    },
    ["La Basse-tourbière"] = {
        "Hungarfen", "Ghaz'an", "Seigneur des marais Musel'ek", "Le Traqueur noir"
    },
    ["Tombes-mana"] = {
        "Pandemonius", "Tavarok", "Prince-nexus Shaffar", "Yor"
    },
    ["Les cryptes Auchenaï"] = {
        "Shirrak le Veillemort", "Exarque Maladaar"
    },
    ["Les salles des Sethekk"] = {
        "Tisserand noir Syth", "Anzu", "Roi-serre Ikiss"
    },
    ["Le labyrinthe des ombres"] = {
        "Ambassadeur Gueule-d'enfer", "Cœur-noir l'Incitateur", "Grand maître Vorpil", "Murmure"
    },
    ["Les salles Brisées"] = {
        "Grand démoniste Néantkurse", "Garde de sang Porung", "Porteguerre O'mrogg", "Chef de guerre Kargath Lamepoing"
    },
    ["Le Caveau de la vapeur"] = {
        "Hydromancienne Thespia", "Mékgénieur Thermojoncteur", "Seigneur de guerre Kalithresh"
    },
    ["La Botanica"] = {
        "Commandant Sarannis", "Grand botaniste Freywinn", "Thorngrin le Dompteur", "Laj", "Brise-dimension"
    },
    ["Le Méchanar"] = {
        "Guette-porte Gyro-Meurtre", "Guette-porte Main-de-fer", "Mécano-Seigneur Capacitus", "Abimagus Sepethrea", "Pathaleon le Calculateur"
    },
    ["L'Arcatraz"] = {
        "Zereketh le Délié", "Dalliah l'Apocalypse", "Scrute-courroux Soccothrates", "Messager Skyriss"
    },
    ["Contreforts de Hautebrande d'antan"] = {
        "Lieutenant Drake", "Capitaine Skarloc", "Chasseur d'Époques"
    },
    ["Le Noir Marécage"] = {
        "Chronoseigneur Déjà", "Temporus", "Aeonus"
    },
    ["Terrasse des Magistères"] = {
        "Selin Cœur-de-feu", "Vexallus", "Prêtresse Delrissa", "Kael'thas Haut-soleil"
    },
    
    -- ==================
    -- WRATH OF THE LICH KING RAIDS
    -- ==================
    -- Naxxramas
    ["Naxxramas"] = {
        "Anub'Rekhan", "Grande veuve Faerlina", "Maexxna",
        "Noth le Porte-peste", "Heigan l'Impur", "Horreb",
        "Instructeur Razuvious", "Gothik le Moissonneur", "Les Quatre Cavaliers",
        "Recousu", "Grobbulus", "Gluth", "Thaddius",
        "Saphiron", "Kel'Thuzad"
    },
    -- Ulduar
    ["Ulduar"] = {
        "Léviathan des flammes", "Ignis le maître de la Fournaise", "Tranchécaille", "Déconstructeur XT-002",
        "L'Assemblée du Fer", "Kologarn", "Auriaya", "Hodir", "Thorim", "Freya", "Mimiron",
        "Général Vezax", "Yogg-Saron", "Algalon l'Observateur"
    },
    -- Trial of the Crusader
    ["L'épreuve du croisé"] = {
        "Les bêtes du Norfendre", "Seigneur Jaraxxus", "Champions de faction",
        "Val'kyrs jumelles", "Anub'arak"
    },
    -- Icecrown Citadel
    ["La Citadelle de la Couronne de glace"] = {
        "Seigneur Gargamoelle", "Dame Murmemort", "Combat de canonnière", "Porte-mort Saurfang",
        "Pulentraille", "Trognepus", "Professeur Putricide",
        "Conseil des princes du sang", "Reine de sang Lana'thel", "Valithria Marcherêve", "Sindragosa",
        "Le Roi-liche"
    },
    -- Ruby Sanctum
    ["Le sanctum Rubis"] = {
        "Halion"
    },
    -- Obsidian Sanctum
    ["Le sanctum Obsidien"] = {
        "Sartharion"
    },
    -- Eye of Eternity
    ["L'Œil de l'éternité"] = {
        "Malygos"
    },
    -- Vault of Archavon
    ["Caveau d'Archavon"] = {
        "Archavon le Gardien des pierres", "Emalon le Gardien des tempêtes",
        "Koralon le Gardien des flammes", "Toravon le Gardien des glaces"
    },
    
    -- ==================
    -- WRATH OF THE LICH KING DUNGEONS
    -- ==================
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
